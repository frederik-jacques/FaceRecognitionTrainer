//
//  SaveViewController.m
//  FaceRecognitionTrainer
//
//  Created by Frederik Jacques on 30/01/12.
//  Copyright (c) 2012 dev-dev. All rights reserved.
//

#import "SaveViewController.h"

@implementation SaveViewController

@synthesize firstNameTextfield,lastNameTextfield;
@synthesize toolbar;
@synthesize saveButton, cancelButton;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

#pragma mark - IBActions
- (IBAction)returnKeyHandler:(id)sender {
    NSLog(@"[SaveViewVC] Return key");
    [sender resignFirstResponder];
}

- (IBAction)backgroundTouchedHandler:(id)sender {
    NSLog(@"[SaveViewVC] Background touched");
    [firstNameTextfield resignFirstResponder];
    [lastNameTextfield resignFirstResponder];
}

- (IBAction)saveButtonHandler:(id)sender {
    NSLog(@"[SaveViewVC] Save");
    if( ![firstNameTextfield.text isEqualToString:@""] && ![lastNameTextfield.text isEqualToString:@""] ){
        [[NSNotificationCenter defaultCenter] postNotificationName:@"SAVE_NAME" object:self];
        [self dismissModalViewControllerAnimated:YES];   
    }
}

- (IBAction)cancelButtonHandler:(id)sender {
    NSLog(@"[SaveViewVC] Cancel");
    [self dismissModalViewControllerAnimated:YES];
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
    self.firstNameTextfield = nil;
    self.lastNameTextfield = nil;
    self.toolbar = nil;
    self.saveButton = nil;
    self.cancelButton = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)dealloc {
    NSLog(@"[SaveViewVC] Dealloc");
    [firstNameTextfield release];
    firstNameTextfield = nil;
    
    [lastNameTextfield release];
    lastNameTextfield = nil;
    
    [toolbar release];
    toolbar = nil;
    
    [saveButton release];
    saveButton = nil;
    
    [cancelButton release];
    cancelButton = nil;
    
    [super dealloc];
}

@end
