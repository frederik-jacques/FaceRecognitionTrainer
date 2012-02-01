//
//  RecognizeCamera.m
//  FaceRecognitionTrainer
//
//  Created by Frederik Jacques on 30/01/12.
//  Copyright (c) 2012 dev-dev. All rights reserved.
//

#import "RecognizeCamera.h"

@implementation RecognizeCamera

#pragma mark - Gesture methods
- (void)takeAPicture:(UITapGestureRecognizer *)sender {
    NSLog(@"[RecognizeCamera] Tap");
    // Grab an image from the videostream
    [self.stillImageOutput captureStillImageAsynchronouslyFromConnection:self.captureConnection completionHandler:
     ^(CMSampleBufferRef imageSampleBuffer, NSError *error) {
         
         // Got the image, show actionsheet
         self.image = [AVCaptureStillImageOutput jpegStillImageNSDataRepresentation:imageSampleBuffer];         
         
         [self uploadForRecognition];
     }];
}

- (void)uploadForRecognition {
    NSLog(@"[RecognizeCamera] Upload for recognition");
    [[NSNotificationCenter defaultCenter] postNotificationName:@"RECOGNIZE_PHOTO" object:self];
}

@end
