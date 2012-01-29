//
//  Camera.h
//  FaceRecognitionTrainer
//
//  Created by Frederik Jacques on 29/01/12.
//  Copyright (c) 2012 dev-dev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@interface Camera : UIView <UIActionSheetDelegate>{
    AVCaptureSession *captureSession;
    AVCaptureDevice *device;
    AVCaptureDeviceInput *deviceInput;
    AVCaptureVideoDataOutput *videoOutput;
    AVCaptureVideoPreviewLayer *previewLayer;
    
    AVCaptureConnection *captureConnection;
    AVCaptureStillImageOutput *stillImageOutput;
    
    NSData *image;
}

@property (nonatomic, retain) AVCaptureSession *captureSession;
@property (nonatomic, retain) AVCaptureDevice *device;
@property (nonatomic, retain) AVCaptureDeviceInput *deviceInput;
@property (nonatomic, retain) AVCaptureVideoDataOutput *videoOutput;
@property (nonatomic, retain) AVCaptureVideoPreviewLayer *previewLayer;
@property (nonatomic, retain) AVCaptureConnection *captureConnection;
@property (nonatomic, retain) AVCaptureStillImageOutput *stillImageOutput;

@property (nonatomic, retain) NSData *image;

@end
