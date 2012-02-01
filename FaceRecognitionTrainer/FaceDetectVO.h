//
//  FaceDetectVO.h
//  FaceRecognitionTrainer
//
//  Created by Frederik Jacques on 30/01/12.
//  Copyright (c) 2012 dev-dev. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FaceDetectVO : NSObject{
    NSString *photo_url;
    NSString *pid;
    NSInteger photo_width;
    NSInteger photo_height;
    NSMutableArray *tags;
}

@property (nonatomic, retain) NSString *photo_url;
@property (nonatomic, retain) NSString *pid;
@property (nonatomic, assign) NSInteger photo_width;
@property (nonatomic, assign) NSInteger photo_height;
@property (nonatomic, retain) NSMutableArray *tags;

- (id)initWithDictionary:(NSDictionary *)theDictionary;

@end
