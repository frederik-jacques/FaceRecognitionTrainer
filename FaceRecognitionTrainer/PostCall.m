//
//  PostCall.m
//  FaceRecognitionTrainer
//
//  Created by Frederik Jacques on 29/01/12.
//  Copyright (c) 2012 dev-dev. All rights reserved.
//

#import "PostCall.h"

@implementation PostCall

@synthesize boundary;

- (id)initWithTheUrl:(NSURL *)theUrl cachePolicy:(NSURLRequestCachePolicy)theCachePolicy timeOut:(NSTimeInterval)theTimeOut {
    self = [super initWithURL:theUrl cachePolicy:theCachePolicy timeoutInterval:theTimeOut];
    
    if( self != nil ){
        NSLog(@"[PostCall] Init");
        self.boundary = @"thenerd_data_boundary";
        self.HTTPMethod = @"POST";
        
        NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@", boundary];
        [self setValue:contentType forHTTPHeaderField:@"Content-Type"];
    }
    
    return self;
}

- (NSData *)createHTTPBody {
    NSLog(@"[PostCall] Method should be overridden");
    return nil;
}

- (void)utfAppendBody:(NSMutableData *)body data:(NSString *)data {
	[body appendData:[data dataUsingEncoding:NSUTF8StringEncoding]];
}

- (void)execute {
    
}

@end
