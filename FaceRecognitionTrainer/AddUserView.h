//
//  AddUserView.h
//  FaceRecognitionTrainer
//
//  Created by Frederik Jacques on 01/02/12.
//  Copyright (c) 2012 dev-dev. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddUserView : UIViewController <UINavigationBarDelegate> {
    NSManagedObjectContext *managedObjectContext;
    UITextField *firstNameTextfield;
    UITextField *lastNameTextfield;
}

@property (nonatomic, assign) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain) IBOutlet UITextField *firstNameTextfield;
@property (nonatomic, retain) IBOutlet UITextField *lastNameTextfield;

- (IBAction)returnKeyHandler:(id)sender;
- (IBAction)backgroundTouchedHandler:(id)sender;

- (id)initWithManagedObjectContext:(NSManagedObjectContext *)context;
- (IBAction)doneClicked:(id)sender;
@end
