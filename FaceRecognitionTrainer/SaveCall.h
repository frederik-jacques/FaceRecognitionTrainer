//
//  SaveCall.h
//  FaceRecognitionTrainer
//
//  Created by Frederik Jacques on 30/01/12.
//  Copyright (c) 2012 dev-dev. All rights reserved.
//

#import "PostCall.h"

@interface SaveCall : PostCall {
    NSArray *tagVOs;
    NSString *uid;
    NSString *label;
    NSString *firstname;
    NSString *lastname;
    
    NSString *confirmed_tid;
}

@property (nonatomic, retain) NSArray *tagVOs;
@property (nonatomic, retain) NSString *uid;
@property (nonatomic, retain) NSString *label;
@property (nonatomic, retain) NSString *confirmed_tid;
@property (nonatomic, retain) NSString *firstname;
@property (nonatomic, retain) NSString *lastname;

- (id)initWithTagVOS:(NSArray *)theTagVOs andUID:(NSString *)theUID andTheLabel:(NSString *)theLabel;

@end
