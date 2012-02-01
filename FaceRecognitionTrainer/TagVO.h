//
//  TagVO.h
//  FaceRecognitionTrainer
//
//  Created by Frederik Jacques on 30/01/12.
//  Copyright (c) 2012 dev-dev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AttributeVO.h"

@interface TagVO : NSObject{
    NSString *tid;
    NSString *label;
    
    NSMutableArray *uids;

    BOOL confirmed;
    BOOL manual;
    BOOL recognizable;
    
    NSNumber *threshold;
    NSNumber *width;
    NSNumber *height;
    
    CGPoint center;
    CGPoint eye_left;
    CGPoint eye_right;
    CGPoint mouth_left;
    CGPoint mouth_center;
    CGPoint mouth_right;
    CGPoint nose;
    
    NSNumber *yaw;
    NSNumber *roll;
    NSNumber *pitch;
    
    AttributeVO *glasses;
    AttributeVO *smiling;
    AttributeVO *face;
    AttributeVO *gender;
    AttributeVO *mood;
    AttributeVO *lips;
    
    
}

@property (nonatomic, retain ) NSString *tid;
@property (nonatomic, retain ) NSString *label;
@property (nonatomic, retain ) NSMutableArray *uids;

@property (nonatomic, assign ) BOOL confirmed;
@property (nonatomic, assign ) BOOL manual;
@property (nonatomic, assign ) BOOL recognizable;

@property (nonatomic, retain ) NSNumber *threshold;
@property (nonatomic, retain ) NSNumber *width;
@property (nonatomic, retain ) NSNumber *height;

@property (nonatomic, assign ) CGPoint center;
@property (nonatomic, assign ) CGPoint eye_left;
@property (nonatomic, assign ) CGPoint eye_right;
@property (nonatomic, assign ) CGPoint mouth_left;
@property (nonatomic, assign ) CGPoint mouth_center;
@property (nonatomic, assign ) CGPoint mouth_right;
@property (nonatomic, assign ) CGPoint nose;

@property (nonatomic, retain ) NSNumber *yaw;
@property (nonatomic, retain ) NSNumber *roll;
@property (nonatomic, retain ) NSNumber *pitch;

@property (nonatomic, retain ) AttributeVO *glasses;
@property (nonatomic, retain ) AttributeVO *smiling;
@property (nonatomic, retain ) AttributeVO *face;
@property (nonatomic, retain ) AttributeVO *gender;
@property (nonatomic, retain ) AttributeVO *mood;
@property (nonatomic, retain ) AttributeVO *lips;

- (id)initWithDictionary:(NSDictionary *)theDictionary;
- (void)info;
@end
