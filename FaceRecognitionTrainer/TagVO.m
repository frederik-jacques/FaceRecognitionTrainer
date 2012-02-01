//
//  TagVO.m
//  FaceRecognitionTrainer
//
//  Created by Frederik Jacques on 30/01/12.
//  Copyright (c) 2012 dev-dev. All rights reserved.
//

#import "TagVO.h"
#import "UidVO.h"

@implementation TagVO

@synthesize tid;
@synthesize label;
@synthesize uids;

@synthesize confirmed, manual, recognizable;

@synthesize threshold;
@synthesize width, height;

@synthesize center;
@synthesize eye_left, eye_right;
@synthesize mouth_left, mouth_center, mouth_right;
@synthesize nose;

@synthesize yaw, roll, pitch;

@synthesize glasses;
@synthesize smiling;
@synthesize face;
@synthesize gender;
@synthesize mood;
@synthesize lips;

- (id)initWithDictionary:(NSDictionary *)theDictionary {
    self = [super init];
    
    if( self != nil ){
        
        self.tid = [theDictionary objectForKey:@"tid"];
        
        self.recognizable = (int)[theDictionary objectForKey:@"recognizable"];
        self.confirmed = (int)[theDictionary objectForKey:@"confirmed"];
        self.manual = (int)[theDictionary objectForKey:@"manual"];
        
        NSArray *arrUIDs = [NSArray arrayWithArray:[theDictionary objectForKey:@"uids"]];
        self.uids = [[[NSMutableArray alloc] init] autorelease];
        
        for (NSDictionary *uidDict in arrUIDs) {
            UidVO *uidVO = [[UidVO alloc] initWithUID:[uidDict objectForKey:@"uid"] andConfidence:[uidDict objectForKey:@"confidence"]];
            [self.uids addObject:uidVO];
            [uidVO release];
            uidVO = nil;
        }
        
        NSLog(@"[TagVO] Amount of uids %i", [self.uids count]);
        
        self.threshold = [theDictionary objectForKey:@"threshold"];
        self.label = [theDictionary objectForKey:@"label"];
        
        self.width = [theDictionary objectForKey:@"width"];
        self.height = [theDictionary objectForKey:@"height"];
        
        NSDictionary *theCenter = [theDictionary objectForKey:@"center"];
        self.center = CGPointMake([[theCenter objectForKey:@"x"] floatValue], [[theCenter objectForKey:@"y"] floatValue]);
        
        NSDictionary *theEyeLeft = [theDictionary objectForKey:@"eye_left"];
        self.eye_left = CGPointMake([[theEyeLeft objectForKey:@"x"] floatValue], [[theEyeLeft objectForKey:@"y"] floatValue]);
        
        NSDictionary *theEyeRight = [theDictionary objectForKey:@"eye_right"];
        self.eye_right = CGPointMake([[theEyeRight objectForKey:@"x"] floatValue], [[theEyeRight objectForKey:@"y"] floatValue]);
        
        NSDictionary *theMouthLeft = [theDictionary objectForKey:@"mouth_left"];
        self.mouth_left = CGPointMake([[theMouthLeft objectForKey:@"x"] floatValue], [[theMouthLeft objectForKey:@"y"] floatValue]);
        
        NSDictionary *theMouthCenter = [theDictionary objectForKey:@"mouth_center"];
        self.mouth_center = CGPointMake([[theMouthCenter objectForKey:@"x"] floatValue], [[theMouthCenter objectForKey:@"y"] floatValue]);
        
        NSDictionary *theMouthRight = [theDictionary objectForKey:@"mouth_right"];
        self.mouth_right = CGPointMake([[theMouthRight objectForKey:@"x"] floatValue], [[theMouthRight objectForKey:@"y"] floatValue]);
        
        NSDictionary *theNose = [theDictionary objectForKey:@"nose"];
        self.nose = CGPointMake([[theNose objectForKey:@"x"] floatValue], [[theNose objectForKey:@"y"] floatValue]);
        
        self.yaw = [theDictionary objectForKey:@"yaw"];
        self.roll = [theDictionary objectForKey:@"roll"];
        self.pitch = [theDictionary objectForKey:@"pitch"];
        
        NSDictionary *theAttributes = [theDictionary objectForKey:@"attributes"];
        
        for (NSString *key in theAttributes) {
            NSDictionary *theDict = [theAttributes objectForKey:key];

            if( [key isEqualToString:@"lips"] ){
               self.lips = [[[AttributeVO alloc] initWithHasAttribute:(int)[theDict objectForKey:@"value"] andConfidence:[theDict objectForKey:@"confidence"] andName:key] autorelease]; 
            }
            
            if( [key isEqualToString:@"gender"] ){
                self.gender = [[[AttributeVO alloc] initWithHasAttribute:(int)[theDict objectForKey:@"value"] andConfidence:[theDict objectForKey:@"confidence"] andName:key] autorelease];
            }
            
            if( [key isEqualToString:@"glasses"] ){
                self.glasses = [[[AttributeVO alloc] initWithHasAttribute:(int)[theDict objectForKey:@"value"] andConfidence:[theDict objectForKey:@"confidence"] andName:key] autorelease];
            }
            
            if( [key isEqualToString:@"mood"] ){
                self.mood = [[[AttributeVO alloc] initWithHasAttribute:(int)[theDict objectForKey:@"value"] andConfidence:[theDict objectForKey:@"confidence"] andName:key] autorelease];
            }
            
            if( [key isEqualToString:@"smiling"] ){
                self.smiling = [[[AttributeVO alloc] initWithHasAttribute:(int)[theDict objectForKey:@"value"] andConfidence:[theDict objectForKey:@"confidence"] andName:key] autorelease];
            }
            
            if( [key isEqualToString:@"face"] ){
                self.face = [[[AttributeVO alloc] initWithHasAttribute:(int)[theDict objectForKey:@"value"] andConfidence:[theDict objectForKey:@"confidence"] andName:key] autorelease];
            }
            
        }
    }
    
    return self;
}

- (void)info {
    NSLog(@"--- Info about Tag ---");
    NSLog(@"Tid = %@", self.tid);
    NSLog(@"Label = %@", self.label);
    
    NSLog(@"# of uids = %i", [self.uids count]);
    
    NSLog(@"Confirmed = %@", [self confirmed] ? @"YES" : @"NO");
    NSLog(@"Manual = %@", [self manual] ? @"YES" : @"NO");
    NSLog(@"Recognizable = %@", [self recognizable] ? @"YES" : @"NO");
    
    NSLog(@"Threshold = %@", self.threshold);
    NSLog(@"Width = %@", self.width);
    NSLog(@"Height = %@", self.height);
    
    NSLog(@"Eye left = %@", NSStringFromCGPoint( self.eye_left ));
    NSLog(@"Eye right = %@", NSStringFromCGPoint( self.eye_right ));
    NSLog(@"Mouth left = %@", NSStringFromCGPoint( self.mouth_left ));
    NSLog(@"Mouth center = %@", NSStringFromCGPoint( self.mouth_center ));
    NSLog(@"Mouth right = %@", NSStringFromCGPoint( self.mouth_right ));
    NSLog(@"Nose = %@", NSStringFromCGPoint( self.nose ));
    
    NSLog(@"Yaw = %@", yaw);
    NSLog(@"Roll = %@", roll);
    NSLog(@"Pitch = %@", pitch);
    
    [self.glasses info];
    [self.smiling info];
    [self.face info];
    [self.gender info];
    [self.mood info];
    [self.lips info];    
}

- (void)dealloc {
    [tid release];
    tid = nil;
    
    [label release];
    label = nil;
    
    [uids release];
    uids = nil;
    
    [threshold release];
    threshold = nil;
    
    [width release];
    width = nil;
    
    [height release];
    height = nil;
    
    [yaw release];
    yaw = nil;
    
    [roll release];
    roll = nil;
    
    [pitch release];
    pitch = nil;
    
    [glasses release];
    glasses = nil;
    
    [smiling release];
    smiling = nil;
    
    [face release];
    face = nil;
    
    [gender release];
    gender = nil;
    
    [mood release];
    mood = nil;
    
    [lips release];
    lips = nil;
    
    [super dealloc];
}

@end
