//
//  SaveCall.m
//  FaceRecognitionTrainer
//
//  Created by Frederik Jacques on 30/01/12.
//  Copyright (c) 2012 dev-dev. All rights reserved.
//

#import "SaveCall.h"
#import "TagVO.h"

@implementation SaveCall

@synthesize tagVOs;
@synthesize uid;
@synthesize label;
@synthesize confirmed_tid;
@synthesize firstname, lastname;

- (id)initWithTagVOS:(NSArray *)theTagVOs andUID:(NSString *)theUID andTheLabel:(NSString *)theLabel {
    self = [super initWithTheUrl:[NSURL URLWithString:FACE_SAVE_URL] cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeOut:10.0];
    
    if( self != nil ){
        NSLog(@"[SaveCall] Init");
        self.tagVOs = theTagVOs;
        self.uid = theUID;
        self.label = theLabel;

        [self setHTTPBody:[self createHTTPBody]];
    }
    
    return self;
}

- (NSData *)createHTTPBody {
    NSLog(@"[SaveCall] Create HTTPBody");
    NSMutableData *theData = [NSMutableData data];
    NSString *beginLine = [NSString stringWithFormat:@"--%@\r\n", self.boundary];
    NSString *endLine = [NSString stringWithFormat:@"\r\n--%@\r\n", self.boundary];
    
    [self utfAppendBody:theData data:beginLine];
    [self utfAppendBody:theData
                   data:[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"api_key\"\r\n\r\n"]];
    [self utfAppendBody:theData data:FACE_API_KEY];
    [self utfAppendBody:theData data:endLine];
    
    [self utfAppendBody:theData
                   data:[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"api_secret\"\r\n\r\n"]];
    [self utfAppendBody:theData data:FACE_API_SECRET];
    [self utfAppendBody:theData data:endLine];
    
    NSMutableString *tagId = [[NSMutableString alloc] init];
    for (TagVO *tagVO in self.tagVOs) {
        [tagId appendString:[NSString stringWithFormat:@"%@,",tagVO.tid]];
    }
    
    [self utfAppendBody:theData
                   data:[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"tids\"\r\n\r\n"]];
    [self utfAppendBody:theData data:tagId];
    [self utfAppendBody:theData data:endLine];
    
    [tagId release];
    tagId = nil;
    
    [self utfAppendBody:theData
                   data:[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"uid\"\r\n\r\n"]];
    [self utfAppendBody:theData data:self.uid];
    [self utfAppendBody:theData data:endLine];
    
    [self utfAppendBody:theData
                   data:[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"format\"\r\n\r\n"]];
    [self utfAppendBody:theData data:@"json"];
    [self utfAppendBody:theData data:endLine];
    
    [self utfAppendBody:theData
                   data:[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"label\"\r\n\r\n"]];
    [self utfAppendBody:theData data:self.label];
    [self utfAppendBody:theData data:endLine];
    
    [self utfAppendBody:theData
                   data:[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"attributes\"\r\n\r\n"]];
    [self utfAppendBody:theData data:@"all"];
    [self utfAppendBody:theData data:endLine];
    
    return theData;
    
}

- (void)execute {
    NSLog(@"[SaveCall] Execute");
    
    [NSURLConnection sendAsynchronousRequest:self queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *theResponse, NSData *theData, NSError *theError) {
        
        if( theData != nil ){
            NSLog(@"[SaveCall] Got JSON data from server");
            
            NSLog(@"[SaveCall] Parsing JSON");
            NSDictionary *json = [NSJSONSerialization JSONObjectWithData:theData
                                                                 options:kNilOptions error:&theError];
            
            NSLog(@"[SaveCall] %@", json);
            
            NSArray *results = [json objectForKey:@"saved_tags"];
            NSLog(@"[SaveCall] Converted json to array");
            NSDictionary *saved_tags = [results objectAtIndex:0];
            NSLog(@"[SaveCall] Converted array to dict");
            
            self.confirmed_tid =  [saved_tags objectForKey:@"tid"];

            [[NSNotificationCenter defaultCenter] postNotificationName:@"SAVING_COMPLETE" object:self];
        }
        
    }];
}

- (void)dealloc {
    NSLog(@"[SaveCall] Dealloc");
    [tagVOs release];
    tagVOs = nil;
    
    [uid release];
    uid = nil;
    
    [label release];
    label = nil;
    
    [firstname release];
    firstname = nil;
    
    [lastname release];
    lastname = nil;
    
    [confirmed_tid release];
    confirmed_tid = nil;
    [super dealloc];
}

@end
