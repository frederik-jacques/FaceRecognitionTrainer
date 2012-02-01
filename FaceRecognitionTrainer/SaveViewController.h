//
//  SaveViewController.h
//  FaceRecognitionTrainer
//
//  Created by Frederik Jacques on 30/01/12.
//  Copyright (c) 2012 dev-dev. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SaveViewController : UIViewController {
    UIToolbar *toolbar;
    UIBarButtonItem *saveButton;
    UIBarButtonItem *cancelButton;
    UITextField *firstNameTextfield;
    UITextField *lastNameTextfield;
}

@property (nonatomic, retain) IBOutlet UITextField *firstNameTextfield;
@property (nonatomic, retain) IBOutlet UITextField *lastNameTextfield;
@property (nonatomic, retain) IBOutlet UIToolbar *toolbar;
@property (nonatomic, retain) IBOutlet UIBarButtonItem *saveButton;
@property (nonatomic, retain) IBOutlet UIBarButtonItem *cancelButton;

- (IBAction)returnKeyHandler:(id)sender;
- (IBAction)backgroundTouchedHandler:(id)sender;
- (IBAction)saveButtonHandler:(id)sender;
- (IBAction)cancelButtonHandler:(id)sender;

@end
