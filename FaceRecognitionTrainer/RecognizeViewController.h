//
//  RecognizeViewController.h
//  FaceRecognitionTrainer
//
//  Created by Frederik Jacques on 29/01/12.
//  Copyright (c) 2012 dev-dev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "RecognizeCamera.h"
#import "RecognizeCall.h"

@interface RecognizeViewController : UIViewController {
    RecognizeCamera *camera;
    RecognizeCall *recognizeCall;
    NSManagedObjectContext *managedObjectContext;
    UIActivityIndicatorView *activityIndicator;
}

@property (nonatomic, retain) RecognizeCamera *camera;
@property (nonatomic, retain) RecognizeCall *recognizeCall;
@property (nonatomic, assign) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain) UIActivityIndicatorView *activityIndicator;

- (id)initWithManagedObjectContext:(NSManagedObjectContext *)context;

@end
