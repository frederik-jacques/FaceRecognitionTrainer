//
//  RecognizeViewController.m
//  FaceRecognitionTrainer
//
//  Created by Frederik Jacques on 29/01/12.
//  Copyright (c) 2012 dev-dev. All rights reserved.
//

#import "RecognizeViewController.h"
#import "User.h"

@implementation RecognizeViewController

@synthesize managedObjectContext;
@synthesize camera;
@synthesize recognizeCall;
@synthesize activityIndicator;

- (id)initWithManagedObjectContext:(NSManagedObjectContext *)context {
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
        // Custom initialization
        self.managedObjectContext = context;
        
        self.title = @"Recognize";
            
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(uploadForRecognition:) name:@"RECOGNIZE_PHOTO" object:self.camera];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(recognitionComplete:) name:@"RECOGNITION_COMPLETE" object:self.recognizeCall];
        
        self.activityIndicator = [[[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray] autorelease];
        self.activityIndicator.hidesWhenStopped = YES;
        [self.activityIndicator setHidden:YES];
        self.activityIndicator.frame = CGRectMake(self.view.center.x, self.view.center.y, self.activityIndicator.frame.size.width, self.activityIndicator.frame.size.height);
        [self.view addSubview:self.activityIndicator];
    }
    return self;
}

- (void)uploadForRecognition:(id)sender{
    NSLog(@"[RecognizeVC] Upload for recognition");
    self.camera.isDisabled = YES;
    
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"User"];
    NSError *error = nil;
    
    NSArray *result = [self.managedObjectContext executeFetchRequest:request error:&error];
    
    if( [result count] > 0 ){
        NSMutableString *uids = [NSMutableString string];
        for (User *user in result) {
            [uids appendString:[NSString stringWithFormat:@"%@,", user.uid]];
        }
        
        [self.view bringSubviewToFront:self.activityIndicator];
        [self.activityIndicator setHidden:NO];
        [self.activityIndicator startAnimating];
        
        self.recognizeCall = [[[RecognizeCall alloc] initWithUIDs:uids andImageData:self.camera.image] autorelease];
        [self.recognizeCall execute];
    }else{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Woops!" message:@"First train some users!" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [alert show];
        
        [alert release];
        alert = nil;
    }
    
}

- (void)recognitionComplete:(id)sender {
    NSLog(@"[RecognizeVC] Recognition complete");
    [self.activityIndicator stopAnimating];
    self.camera.isDisabled = NO;
    
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"User"];
    request.predicate = [NSPredicate predicateWithFormat:@"uid == %@", self.recognizeCall.highestConfidence.uid];
    NSError *error = nil;
    
    NSArray *result = [self.managedObjectContext executeFetchRequest:request error:&error];
    
    UIAlertView *alert = nil;
    if( [result count] > 0 ){
        User *user = [result lastObject];
        
        alert = [[UIAlertView alloc] initWithTitle:@"Ow yeah!" message:[NSString stringWithFormat:@"I'm sure you are %@ %@.", user.firstname, user.lastname] delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
    }else{
        alert = [[UIAlertView alloc] initWithTitle:@"Oh, pitty" message:[NSString stringWithFormat:@"I couldn't recognize anybody!"] delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
    }
    
    [alert show];
    
    [alert release];
    alert = nil;
}

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    self.camera = [[[RecognizeCamera alloc] initWithFrame:self.view.frame] autorelease];
    [self.view addSubview:camera];
}

- (void)viewWillDisappear:(BOOL)animated {
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated {
	[super viewDidDisappear:animated];
    [self.camera removeFromSuperview];
    [camera release];
    camera = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)dealloc {
    NSLog(@"[RecognizeVC] Dealloc");
    [camera release];
    camera = nil;
    
    [recognizeCall release];
    recognizeCall = nil;
    
    [activityIndicator release];
    activityIndicator = nil;
    
    [super dealloc];
}

@end
