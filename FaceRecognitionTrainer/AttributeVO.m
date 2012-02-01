//
//  AttributeVO.m
//  FaceRecognitionTrainer
//
//  Created by Frederik Jacques on 30/01/12.
//  Copyright (c) 2012 dev-dev. All rights reserved.
//

#import "AttributeVO.h"

@implementation AttributeVO

@synthesize hasAttribute;
@synthesize confidence;
@synthesize name;

- (id)initWithHasAttribute:(BOOL)hasIt andConfidence:(NSNumber *)theConfidence andName:(NSString *)theName {
    
    self = [super init];
    
    if( self != nil ){
        self.hasAttribute = hasIt;
        self.confidence = theConfidence;
        self.name = theName;
    }
    
    return self;
    
}

- (void)info {
    NSLog(@"--- Info about %@ ---", self.name);
    NSLog(@"Has attribute %@", [self hasAttribute] ? @"YES" : @"NO");
    NSLog(@"Confidence %@", self.confidence);
}

- (void)dealloc {
    NSLog(@"[AttributeVO] Dealloc");
    [confidence release];
    confidence = nil;
    
    [name release];
    name = nil;
    
    [super dealloc];
}

@end
