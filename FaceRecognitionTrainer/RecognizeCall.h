//
//  RecognizeCall.h
//  FaceRecognitionTrainer
//
//  Created by Frederik Jacques on 30/01/12.
//  Copyright (c) 2012 dev-dev. All rights reserved.
//

#import "PostCall.h"
#import "TagVO.h"
#import "UidVO.h"

@interface RecognizeCall : PostCall {
    NSString *UIDs;
    NSData *imageData;
    
    NSMutableArray *tags;
    UidVO *highestConfidence;
}

@property (nonatomic, retain) NSString *UIDs;
@property (nonatomic, retain) NSData *imageData;
@property (nonatomic, retain) NSMutableArray *tags;
@property (nonatomic, retain) UidVO *highestConfidence;

- (id)initWithUIDs:(NSString *)theUIDs andImageData:(NSData *)theImageData;

@end
