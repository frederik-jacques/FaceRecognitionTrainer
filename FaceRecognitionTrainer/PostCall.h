//
//  PostCall.h
//  FaceRecognitionTrainer
//
//  Created by Frederik Jacques on 29/01/12.
//  Copyright (c) 2012 dev-dev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FaceConstants.h"

@interface PostCall : NSMutableURLRequest{
    NSString *boundary;
}

@property (nonatomic, retain) NSString *boundary;

- (id)initWithTheUrl:(NSURL *)theUrl cachePolicy:(NSURLRequestCachePolicy)theCachePolicy timeOut:(NSTimeInterval)theTimeOut;
- (NSData *)createHTTPBody;
- (void)utfAppendBody:(NSMutableData *)body data:(NSString *)data;
- (void)execute;

@end
