//
//  AttributeVO.h
//  FaceRecognitionTrainer
//
//  Created by Frederik Jacques on 30/01/12.
//  Copyright (c) 2012 dev-dev. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AttributeVO : NSObject {
    BOOL hasAttribute;
    NSNumber *confidence;
    NSString *name;
}

@property (nonatomic, assign) BOOL hasAttribute;
@property (nonatomic, retain) NSNumber *confidence;
@property (nonatomic, retain) NSString *name;

- (id)initWithHasAttribute:(BOOL)hasIt andConfidence:(NSNumber *)theConfidence andName:(NSString *)theName;
- (void)info;

@end
