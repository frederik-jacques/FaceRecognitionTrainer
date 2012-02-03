//
//  FaceConstants.h
//  FaceRecognitionTrainer
//
//  Created by Frederik Jacques on 29/01/12.
//  Copyright (c) 2012 dev-dev. All rights reserved.
//

#import <Foundation/Foundation.h>

#define FACE_DETECT_URL @"http://api.face.com/faces/detect.json"
#define FACE_SAVE_URL @"http://api.face.com/tags/save.json"
#define FACE_TRAIN_URL @"http://api.face.com/faces/train.json"
#define FACE_RECOGNIZE_URL @"http://api.face.com/faces/recognize.json"

#define FACE_API_KEY @"YOUR_API"
#define FACE_API_SECRET @"YOUR_SECRET"

@interface FaceConstants : NSObject

@end
