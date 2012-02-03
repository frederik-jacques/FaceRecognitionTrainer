//
//  SaveViewController.h
//  FaceRecognitionTrainer
//
//  Created by Frederik Jacques on 30/01/12.
//  Copyright (c) 2012 dev-dev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "User.h"
#import "AddUserView.h"

@interface SaveViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, NSFetchedResultsControllerDelegate> {
    
    UITableView *tableview;
    NSManagedObjectContext *managedObjectContext;
    NSFetchedResultsController *fetchResultController;
    
    UINavigationBar *navigationBar;
 
    User *selectedUser;
    AddUserView *addUserVC;
    
}

@property (nonatomic, retain) IBOutlet UITableView *tableview;
@property (nonatomic, assign) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain) NSFetchedResultsController *fetchResultController;

@property (nonatomic, retain) IBOutlet UINavigationBar *navigationBar;

@property (nonatomic, retain) User *selectedUser;
@property (nonatomic, retain) AddUserView *addUserVC;

- (id)initWithManagedObjectContext:(NSManagedObjectContext *) context;
- (IBAction)addButtonClicked:(id)sender;

@end
