//
//  DetectCall.h
//  FaceRecognitionTrainer
//
//  Created by Frederik Jacques on 29/01/12.
//  Copyright (c) 2012 dev-dev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PostCall.h"
#import "FaceDetectVO.h"

@interface DetectCall : PostCall {
    NSData *imageData;
    FaceDetectVO *faceDetectVO;
}

@property (nonatomic, retain) NSData *imageData;
@property (nonatomic, retain) FaceDetectVO *faceDetectVO;

- (id)initWithImageData:(NSData *)theImageData;

@end
