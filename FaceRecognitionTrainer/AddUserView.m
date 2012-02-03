//
//  AddUserView.m
//  FaceRecognitionTrainer
//
//  Created by Frederik Jacques on 01/02/12.
//  Copyright (c) 2012 dev-dev. All rights reserved.
//

#import "AddUserView.h"
#import "User.h"

@implementation AddUserView

@synthesize firstNameTextfield,lastNameTextfield;
@synthesize managedObjectContext;

- (id)initWithManagedObjectContext:(NSManagedObjectContext *)context {
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
        // Custom initialization
        self.managedObjectContext = context;
    }
    return self;
}

#pragma mark - IBActions
- (IBAction)returnKeyHandler:(id)sender {
    NSLog(@"[AddUserVC] Return key");
    [sender resignFirstResponder];
}

- (IBAction)backgroundTouchedHandler:(id)sender {
    NSLog(@"[AddUserVC] Background touched");
    [firstNameTextfield resignFirstResponder];
    [lastNameTextfield resignFirstResponder];
}

- (IBAction)doneClicked:(id)sender {
    NSLog(@"[AddUserVC] Done clicked");
    
    if( ![firstNameTextfield.text isEqualToString:@""] && ![lastNameTextfield.text isEqualToString:@""] ){
        
        NSString *uid = [NSString stringWithFormat:@"%@%@@frederikjacques", self.firstNameTextfield.text, self.lastNameTextfield.text];
        uid = [uid stringByReplacingOccurrencesOfString:@" " withString:@"_"];
        NSString *label = [NSString stringWithFormat:@"%@ %@", self.firstNameTextfield.text, self.lastNameTextfield.text];
        
        User *newUser = [NSEntityDescription insertNewObjectForEntityForName:@"User" inManagedObjectContext:self.managedObjectContext];
        newUser.uid = uid;
        newUser.firstname = [self.firstNameTextfield.text capitalizedString];
        newUser.lastname = [self.lastNameTextfield.text capitalizedString];
        newUser.label = label;
        
        NSError *error = nil;
        if( [self.managedObjectContext save:&error] ){
            NSLog(@"[AddUserVC] Saved");
            [[NSNotificationCenter defaultCenter] postNotificationName:@"USER_ADDED" object:self];
            //[self dismissModalViewControllerAnimated:YES];
        }else{
            NSLog(@"[AddUserVC] Save failed");
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Woops" message:@"I couldn't write the user to the database, sorry ..." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
            
            [alert show];
            
            [alert release];
            alert = nil;
            
        }
    }
    
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
    
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)dealloc {
    NSLog(@"[AddUserVC] Dealloc");
    [firstNameTextfield release];
    firstNameTextfield = nil;
    
    [lastNameTextfield release];
    lastNameTextfield = nil;
    
    [super dealloc];
}

@end
