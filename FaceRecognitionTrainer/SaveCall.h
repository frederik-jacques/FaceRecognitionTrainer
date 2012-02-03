//
//  SaveCall.h
//  FaceRecognitionTrainer
//
//  Created by Frederik Jacques on 30/01/12.
//  Copyright (c) 2012 dev-dev. All rights reserved.
//

#import "PostCall.h"
#import "User.h"

@interface SaveCall : PostCall {
    NSArray *tagVOs;
    User *user;
    
    NSString *confirmed_tid;
}

@property (nonatomic, retain) NSArray *tagVOs;
@property (nonatomic, retain) User *user;
@property (nonatomic, retain) NSString *confirmed_tid;

- (id)initWithTagVOS:(NSArray *)theTagVOs andUser:(User *)theUser;

@end
