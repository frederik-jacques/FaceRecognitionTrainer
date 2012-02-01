//
//  FaceDetectVO.m
//  FaceRecognitionTrainer
//
//  Created by Frederik Jacques on 30/01/12.
//  Copyright (c) 2012 dev-dev. All rights reserved.
//

#import "FaceDetectVO.h"
#import "TagVO.h"

@implementation FaceDetectVO

@synthesize photo_url;
@synthesize pid;
@synthesize photo_width;
@synthesize photo_height;
@synthesize tags;

- (id)initWithDictionary:(NSDictionary *)theDictionary{
    self = [super init];
    
    if( self != nil ){
        NSLog(@"[FaceDetectVO] Init");
        self.photo_url = [theDictionary objectForKey:@"url"];
        self.pid = [theDictionary objectForKey:@"pid"];
        self.photo_width = [[theDictionary objectForKey:@"width"] integerValue];
        self.photo_height = [[theDictionary objectForKey:@"height"] integerValue];
        
        NSArray *tagsArray = [theDictionary objectForKey:@"tags"];
        
        self.tags = [[[NSMutableArray alloc] init] autorelease];
        for (NSDictionary *tagDict in tagsArray) {
            TagVO *tagVO = [[TagVO alloc] initWithDictionary:tagDict];
            [self.tags addObject:tagVO];
            [tagVO info];
            [tagVO release];
            tagVO = nil;
        }
        
    }
    
    return self;
}

- (void)dealloc {
    [photo_url release];
    photo_url = nil;
    
    [pid release];
    pid = nil;
    
    [tags release];
    tags = nil;
    
    [super dealloc];
}

@end
