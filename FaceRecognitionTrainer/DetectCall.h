//
//  DetectCall.h
//  FaceRecognitionTrainer
//
//  Created by Frederik Jacques on 29/01/12.
//  Copyright (c) 2012 dev-dev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PostCall.h"

@interface DetectCall : PostCall {
    NSData *imageData;
}

@property (nonatomic, retain) NSData *imageData;

- (id)initWithImageData:(NSData *)theImageData;

@end
