//
//  TrainingCall.m
//  FaceRecognitionTrainer
//
//  Created by Frederik Jacques on 30/01/12.
//  Copyright (c) 2012 dev-dev. All rights reserved.
//

#import "TrainingCall.h"

@implementation TrainingCall

@synthesize user;

- (id)initWithUser:(User *)theUser {
    self = [super initWithTheUrl:[NSURL URLWithString:FACE_TRAIN_URL] cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeOut:10.0];
    
    if( self != nil ){
        NSLog(@"[TrainingCall] Init");
        self.user = theUser;
        
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
    [self utfAppendBody:theData data:self.user.uid];
    [self utfAppendBody:theData data:endLine];
    
    [self utfAppendBody:theData
                   data:[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"format\"\r\n\r\n"]];
    [self utfAppendBody:theData data:@"json"];
    [self utfAppendBody:theData data:endLine];
    
    [self utfAppendBody:theData
                   data:[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"attributes\"\r\n\r\n"]];
    [self utfAppendBody:theData data:@"all"];
    [self utfAppendBody:theData data:endLine];
    
    return theData;
    
}

- (void)execute {
    NSLog(@"[TrainingCall] Execute");
    
    [NSURLConnection sendAsynchronousRequest:self queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *theResponse, NSData *theData, NSError *theError) {
        
        if( theData != nil ){
            NSLog(@"[TrainingCall] Got JSON data from server");
            
            NSLog(@"[TrainingCall] Parsing JSON");
            NSDictionary *json = [NSJSONSerialization JSONObjectWithData:theData
                                                                 options:kNilOptions error:&theError];
            
            NSLog(@"[TrainingCall] %@", json);
              
            [[NSNotificationCenter defaultCenter] postNotificationName:@"TRAINING_COMPLETE" object:self];
        }
        
    }];
}


@end
