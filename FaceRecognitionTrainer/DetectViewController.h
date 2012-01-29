//
//  FirstViewController.h
//  FaceRecognitionTrainer
//
//  Created by Frederik Jacques on 29/01/12.
//  Copyright (c) 2012 dev-dev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Camera.h"

@interface DetectViewController : UIViewController{
    Camera *camera;
}

@property (nonatomic, retain) Camera *camera;

@end
