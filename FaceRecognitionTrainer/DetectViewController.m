//
//  FirstViewController.m
//  FaceRecognitionTrainer
//
//  Created by Frederik Jacques on 29/01/12.
//  Copyright (c) 2012 dev-dev. All rights reserved.
//

#import "DetectViewController.h"
#import "DetectCall.h"

@implementation DetectViewController

@synthesize camera;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"Detect";
        self.tabBarItem.image = [UIImage imageNamed:@"first"];
        
        camera = [[Camera alloc] initWithFrame:self.view.frame];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(uploadPhotos:) name:@"UPLOAD_PHOTO" object:camera];
        [self.view addSubview:camera];
    }
    return self;
}

- (void)uploadPhotos:(id)sender {
    NSLog(@"[DetectViewContainer] Upload photo");
    DetectCall *call = [[DetectCall alloc] initWithImageData:self.camera.image];
    [call execute];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    self.camera = nil;
}

- (void)dealloc {
    NSLog(@"[DetectVC] Dealloc");
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"UPLOAD_PHOTO" object:camera];
    
    [camera release];
    camera = nil;
    
    [super dealloc];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated {
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

@end
