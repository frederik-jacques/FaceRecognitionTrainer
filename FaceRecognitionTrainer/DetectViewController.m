//
//  FirstViewController.m
//  FaceRecognitionTrainer
//
//  Created by Frederik Jacques on 29/01/12.
//  Copyright (c) 2012 dev-dev. All rights reserved.
//

#import "DetectViewController.h"
#import "DetectCall.h"
#import "TagVO.h"
#import "User.h"

@interface DetectViewController()
- (void)insertUser;
@end

@implementation DetectViewController

@synthesize camera;
@synthesize detectCall, saveCall;
@synthesize activityIndicator;
@synthesize saveVC;
@synthesize managedObjectContext;

- (id)initWithManagedObjectContext:(NSManagedObjectContext *)context {
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
        self.managedObjectContext = context;
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(uploadPhotos:) name:@"UPLOAD_PHOTO" object:self.camera];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(detectingDone:) name:@"DETECTING_COMPLETE" object:self.detectCall];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(save:) name:@"SAVE_USER" object:self.saveVC];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(saveComplete:) name:@"SAVING_COMPLETE" object:self.saveVC];
        
        self.title = @"Detect";
        self.tabBarItem.image = [UIImage imageNamed:@"first"];
    }
    return self;
}

- (void)uploadPhotos:(id)sender {
    NSLog(@"[DetectViewContainer] Upload photo");
    self.camera.isDisabled = YES;
    self.activityIndicator = [[[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite] autorelease];
    self.activityIndicator.frame = CGRectMake(self.view.center.x, self.view.center.y, self.activityIndicator.frame.size.width, self.activityIndicator.frame.size.height);
    [self.view addSubview:self.activityIndicator];
    self.activityIndicator.hidesWhenStopped = YES;
    [self.activityIndicator startAnimating]; 
    
    self.detectCall = [[[DetectCall alloc] initWithImageData:self.camera.image] autorelease];
    [detectCall execute];
}

- (void)detectingDone:(id)sender {
    NSLog(@"[DetectViewContainer] Got data from detection");
    self.camera.isDisabled = NO;
    [self.activityIndicator stopAnimating];
    
    self.saveVC = [[[SaveViewController alloc] initWithManagedObjectContext:self.managedObjectContext] autorelease];
    self.saveVC.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    [self presentModalViewController:self.saveVC animated:YES];
}

- (void)save:(id)sender {
    NSLog(@"[DetectViewContainer] Save");
    
    NSMutableArray *tagVOs = [[NSMutableArray alloc] init];
    
    for (TagVO *tagVO in self.detectCall.faceDetectVO.tags) {
        [tagVOs addObject:tagVO];
    }
    
    self.saveCall = [[[SaveCall alloc] initWithTagVOS:tagVOs andUser:self.saveVC.selectedUser] autorelease];
    [self.saveCall execute];
    
    [tagVOs release];
    tagVOs = nil;
}

- (void)saveComplete:(id)sender {
    NSLog(@"[DetectViewContainer] Save complete!");
    
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"User"];
    fetchRequest.predicate = [NSPredicate predicateWithFormat:@"uid MATCHES %@", self.saveCall.user.uid];
    
    NSError *error = nil;
    NSArray *results = [self.managedObjectContext executeFetchRequest:fetchRequest error:&error];
        
    if ( results == nil) {
        NSLog(@"[DetectVC] Fetch user FAILED");
    }else if( [results count] == 0 ) {
        NSLog(@"[DetectVC] User does not exist!");
        [self insertUser];
    }else{
        NSLog(@"[DetectVC] User exist!");
        User *user = [results lastObject];
        user.isTrained = [NSNumber numberWithBool:NO];
                
        if( [self.managedObjectContext save:&error] ){
            NSLog(@"[DetectVC] Saved");
        }else{
            NSLog(@"[DetectVC] Problem saving");
        }
    }
        
}


- (void)insertUser {
    NSError *error = nil;
    
    User *user = [NSEntityDescription insertNewObjectForEntityForName:@"User" inManagedObjectContext:self.managedObjectContext];
    user.uid = self.saveCall.user.uid;
    user.label = self.saveCall.user.label;
    user.isTrained = [NSNumber numberWithBool:NO];
    user.firstname = self.saveCall.user.firstname;
    user.lastname = self.saveCall.user.lastname;
    
    if( [self.managedObjectContext save:&error] ){
        NSLog(@"[DetectVC] User added!");
    }else{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Oops" message:@"I couldn't add the user to the database" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [alert show];
        
        [alert release];
        alert = nil;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    NSLog(@"[DetectVC] View did load");
}

- (void)viewDidUnload {
    [super viewDidUnload];
    NSLog(@"[DetectVC] View did unload");
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    self.camera = nil;
    self.detectCall = nil;
    self.saveCall = nil;
    self.saveVC = nil;
}

- (void)dealloc {
    NSLog(@"[DetectVC] Dealloc");
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"UPLOAD_PHOTO" object:self.camera];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"DETECTING_COMPLETE" object:self.detectCall];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"SAVE_USER" object:self.saveVC];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"SAVING_COMPLETE" object:self.saveVC];
    
    [camera release];
    camera = nil;
    
    [detectCall release];
    detectCall = nil;
    
    [saveVC release];
    saveVC = nil;
    
    [super dealloc];
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    self.camera = [[[Camera alloc] initWithFrame:self.view.frame] autorelease];
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
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

@end
