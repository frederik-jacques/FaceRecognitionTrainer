//
//  Camera.m
//  FaceRecognitionTrainer
//
//  Created by Frederik Jacques on 29/01/12.
//  Copyright (c) 2012 dev-dev. All rights reserved.
//

#import "Camera.h"

@interface Camera() 
- (void)showActionSheet;
@end

@implementation Camera

@synthesize image;
@synthesize captureSession;
@synthesize device;
@synthesize deviceInput;
@synthesize videoOutput;
@synthesize previewLayer;
@synthesize captureConnection;
@synthesize stillImageOutput;
@synthesize isDisabled;

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {        
        self.captureSession = [[[AVCaptureSession alloc] init] autorelease];
        self.captureSession.sessionPreset = AVCaptureSessionPresetMedium;

        NSError *error = nil;        
        self.device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
        self.deviceInput = [AVCaptureDeviceInput deviceInputWithDevice:self.device error:&error];
        //self.deviceInput = nil;
        
        // Setup input device
        if( self.deviceInput ){
            [self.captureSession addInput:self.deviceInput];
        }else{
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Woops..." message:@"I couldn't find any capture device" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
            [alert show];
            [alert release];
            alert = nil;
        }
        
        // Setup video output and add to the session
        self.videoOutput = [[[AVCaptureVideoDataOutput alloc] init] autorelease];
        NSDictionary *rgbOutputSettings = [NSDictionary dictionaryWithObject:
                                           [NSNumber numberWithInt:kCMPixelFormat_32BGRA] forKey:(id)kCVPixelBufferPixelFormatTypeKey];
        [self.videoOutput setVideoSettings:rgbOutputSettings];
        
        if( self.videoOutput ){
            [self.captureSession addOutput:self.videoOutput];
        }else{
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Woops..." message:@"I couldn't create an output for the video stream" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
            [alert show];
            [alert release];
            alert = nil;
        }
        
        // Setup preview layer to show the video data
        self.previewLayer = [AVCaptureVideoPreviewLayer layerWithSession:self.captureSession];
        self.previewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
        self.previewLayer.frame = self.frame;
        [self.layer addSublayer:self.previewLayer];
            
        // Setup grabbing of images and add to the session
        self.stillImageOutput = [[[AVCaptureStillImageOutput alloc] init] autorelease];
        NSDictionary *outputSettings = [[NSDictionary alloc] initWithObjectsAndKeys:
                                        AVVideoCodecJPEG, AVVideoCodecKey, nil];
        [self.stillImageOutput setOutputSettings:outputSettings];
        [outputSettings release];
        outputSettings = nil;
        
        [self.captureSession addOutput:self.stillImageOutput];
        
        self.captureConnection = nil;
        for (AVCaptureConnection *connection in self.stillImageOutput.connections) {
            for (AVCaptureInputPort *port in [connection inputPorts]) {
                if ([[port mediaType] isEqual:AVMediaTypeVideo] ) {
                    self.captureConnection = connection;
                    break;
                }
            }
            if (self.captureConnection) { break; }
        }
        
        // Start the video session
        [self.captureSession startRunning];
        
        // Add gestures to camera
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(takeAPicture:)];
        tapGesture.numberOfTapsRequired = 1;
        [self addGestureRecognizer:tapGesture];
        
        [tapGesture release];
        tapGesture = nil;
    
    }
    return self;
}

- (void)showActionSheet {

    UIActionSheet *actionsheet = [[UIActionSheet alloc] initWithTitle:@"And now ..." delegate:self cancelButtonTitle:nil destructiveButtonTitle:@"Remove picture" otherButtonTitles:@"Upload for recognition", nil];
        
    [actionsheet showInView:self];
    [actionsheet release];
    actionsheet = nil;
}

- (void)setIsDisabled:(BOOL)value {
    isDisabled = value;
    
    if( isDisabled ){
        [self setUserInteractionEnabled:NO];
    }else{
        [self setUserInteractionEnabled:YES];
    }
}

#pragma mark - Gesture methods
- (void)takeAPicture:(UITapGestureRecognizer *)sender {
    NSLog(@"[Camera] Tap");
    // Grab an image from the videostream
    [self.stillImageOutput captureStillImageAsynchronouslyFromConnection:self.captureConnection completionHandler:
     ^(CMSampleBufferRef imageSampleBuffer, NSError *error) {
         
         // Got the image, show actionsheet
         self.image = [AVCaptureStillImageOutput jpegStillImageNSDataRepresentation:imageSampleBuffer];
         [self showActionSheet];
         
     }];
}

#pragma mark - UIActionSheetDelegate methods
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    NSLog(@"[Camera] Actionsheet pressed at index %i", buttonIndex);
    
    switch (buttonIndex) {
        case 0: // Remove photos
            self.image = nil;
            break;
            
        case 1:
            // Upload
            [[NSNotificationCenter defaultCenter] postNotificationName:@"UPLOAD_PHOTO" object:self];
            break;
    }
    
}

#pragma mark - Dealloc
- (void)dealloc {
    NSLog(@"[Camera] Dealloc");
    [image release];
    image = nil;
    
    [captureSession release];
    captureSession = nil;
    
    [device release];
    device = nil;
    
    [deviceInput release];
    deviceInput = nil;
    
    [videoOutput release];
    videoOutput = nil;
    
    [previewLayer release];
    previewLayer = nil;
    
    [captureConnection release];
    captureConnection = nil;
    
    [stillImageOutput release];
    stillImageOutput = nil;
    
    [super dealloc];
}

@end
