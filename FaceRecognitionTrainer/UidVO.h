//
//  UidVO.h
//  FaceRecognitionTrainer
//
//  Created by Frederik Jacques on 30/01/12.
//  Copyright (c) 2012 dev-dev. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UidVO : NSObject{
    NSString *uid;
    NSNumber *confidence;
}

@property (nonatomic, retain) NSString *uid;
@property (nonatomic, retain) NSNumber *confidence;

- (id)initWithUID:(NSString *)theUID andConfidence:(NSNumber *)theConfidence;

@end
