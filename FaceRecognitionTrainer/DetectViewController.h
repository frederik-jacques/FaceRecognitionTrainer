//
//  FirstViewController.h
//  FaceRecognitionTrainer
//
//  Created by Frederik Jacques on 29/01/12.
//  Copyright (c) 2012 dev-dev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

#import "Camera.h"
#import "DetectCall.h"
#import "SaveCall.h"
#import "SaveViewController.h"

@interface DetectViewController : UIViewController{
    Camera *camera;
    DetectCall *detectCall;
    SaveCall *saveCall;
    UIActivityIndicatorView *activityIndicator;
    SaveViewController *saveVC;
    NSManagedObjectContext *managedObjectContext;
}

- (id)initWithManagedObjectContext:(NSManagedObjectContext *)context;

@property (nonatomic, retain) Camera *camera;
@property (nonatomic, retain) DetectCall *detectCall;
@property (nonatomic, retain) SaveCall *saveCall;
@property (nonatomic, retain) UIActivityIndicatorView *activityIndicator;
@property (nonatomic, retain) SaveViewController *saveVC;
@property (nonatomic, assign) NSManagedObjectContext *managedObjectContext;


@end
