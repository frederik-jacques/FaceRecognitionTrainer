//
//  TrainingCall.h
//  FaceRecognitionTrainer
//
//  Created by Frederik Jacques on 30/01/12.
//  Copyright (c) 2012 dev-dev. All rights reserved.
//

#import "PostCall.h"
#import "User.h"

@interface TrainingCall : PostCall{
    User *user;
}

@property (nonatomic, retain) User *user;

- (id)initWithUser:(User *)theUser;

@end
