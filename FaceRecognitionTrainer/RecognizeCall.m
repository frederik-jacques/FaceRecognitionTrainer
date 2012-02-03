//
//  RecognizeCall.m
//  FaceRecognitionTrainer
//
//  Created by Frederik Jacques on 30/01/12.
//  Copyright (c) 2012 dev-dev. All rights reserved.
//

#import "RecognizeCall.h"

@implementation RecognizeCall

@synthesize UIDs;
@synthesize imageData;
@synthesize tags;
@synthesize highestConfidence;

- (id)initWithUIDs:(NSString *)theUIDs andImageData:(NSData *)theImageData {
    self = [super initWithTheUrl:[NSURL URLWithString:FACE_RECOGNIZE_URL] cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeOut:10.0];
    
    if( self != nil ){
        NSLog(@"[RecognizeCall] Init");
        self.UIDs = theUIDs;
        self.imageData = theImageData;
        
        [self setHTTPBody:[self createHTTPBody]];
    }
    
    return self;
}

- (NSData *)createHTTPBody {
    NSLog(@"[TrainingCall] Create HTTPBody");
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
    
    [self utfAppendBody:theData
                   data:[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"uids\"\r\n\r\n"]];
    [self utfAppendBody:theData data:self.UIDs];
    [self utfAppendBody:theData data:endLine];
    
    [self utfAppendBody:theData
                   data:[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"format\"\r\n\r\n"]];
    [self utfAppendBody:theData data:@"json"];
    [self utfAppendBody:theData data:endLine];
    
    [self utfAppendBody:theData
                   data:[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"attributes\"\r\n\r\n"]];
    [self utfAppendBody:theData data:@"all"];
    [self utfAppendBody:theData data:endLine];
    
    [self utfAppendBody:theData
                   data:[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"thePicture\"; filename=\"i_look_good.jpg\"\r\n"]];
    [self utfAppendBody:theData
                   data:[NSString stringWithString:@"Content-Type: image/jpeg\r\n\r\n"]];
    
    [theData appendData:UIImageJPEGRepresentation([UIImage imageWithData:self.imageData], 1.0)];
    [self utfAppendBody:theData data:endLine];
    
    return theData;
    
}

- (void)execute {
    NSLog(@"[RecognizeCall] Execute");
    
    [NSURLConnection sendAsynchronousRequest:self queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *theResponse, NSData *theData, NSError *theError) {
        
        if( theData != nil ){
            NSLog(@"[RecognizeCall] Got JSON data from server");
            
            NSLog(@"[RecognizeCall] Parsing JSON");
            NSDictionary *json = [NSJSONSerialization JSONObjectWithData:theData
                                                                 options:kNilOptions error:&theError];
            
            NSLog(@"[RecognizeCall] %@", json);
            
            NSArray *results = [json objectForKey:@"photos"];
            NSDictionary *photos = [results objectAtIndex:0];
            
            NSArray *tagsArray = [photos objectForKey:@"tags"];
            
            self.highestConfidence = nil;
            self.tags = [[[NSMutableArray alloc] init] autorelease];
            for (NSDictionary *tagDict in tagsArray) {
                TagVO *tagVO = [[TagVO alloc] initWithDictionary:tagDict];
                NSLog(@"[RecognizeCall] Tag VO");
                for ( UidVO *vo in tagVO.uids) {
                    NSLog(@"[RecognizeCall] Looping through uids %@", vo.uid );
                    NSLog(@"[RecognizeCall] Current confidence = %@", vo.confidence);
                    NSLog(@"[RecognizeCall] Highest confidence = %@", highestConfidence.confidence);
                    if( self.highestConfidence.confidence < vo.confidence ){
                        NSLog(@"[RecognizeCall] Confidence higher then previous");
                        self.highestConfidence = vo;
                    }else{
                        NSLog(@"[RecognizeCall] Not higher");
                    }
                }
                
                [self.tags addObject:tagVO];
                [tagVO info];
                [tagVO release];
                tagVO = nil;
            }
            
            NSLog(@"[RecognizeCall] Highest confidence = %@", self.highestConfidence.uid);
                        
            [[NSNotificationCenter defaultCenter] postNotificationName:@"RECOGNITION_COMPLETE" object:self];
        }
        
    }];
}


@end
