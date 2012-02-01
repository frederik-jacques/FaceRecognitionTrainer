//
//  UidVO.m
//  FaceRecognitionTrainer
//
//  Created by Frederik Jacques on 30/01/12.
//  Copyright (c) 2012 dev-dev. All rights reserved.
//

#import "UidVO.h"

@implementation UidVO

@synthesize uid;
@synthesize confidence;

- (id)initWithUID:(NSString *)theUID andConfidence:(NSNumber *)theConfidence {
    
    self = [super init];
    
    if( self != nil ){
        self.uid = theUID;
        self.confidence = theConfidence;
    }
    
    return self;
}

- (void)dealloc {
    [uid release];
    uid = nil;
    
    [confidence release];
    confidence = nil;
    
    [super dealloc];
}

@end
