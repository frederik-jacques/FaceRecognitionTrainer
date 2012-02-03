//
//  TrainerViewController.h
//  FaceRecognitionTrainer
//
//  Created by Frederik Jacques on 01/02/12.
//  Copyright (c) 2012 dev-dev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "TrainingCall.h"

@interface TrainerViewController : UIViewController <NSFetchedResultsControllerDelegate, UITableViewDelegate, UITableViewDataSource>{
    UITableView *tableview;
    
    NSManagedObjectContext *managedObjectContext;
    NSFetchedResultsController *fetchResultController;
    TrainingCall *trainingCall;
    
    UIActivityIndicatorView *activityIndicator;
}

@property (nonatomic, retain) IBOutlet UITableView *tableview;
@property (nonatomic, assign) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain) NSFetchedResultsController *fetchResultController;
@property (nonatomic, retain) TrainingCall *trainingCall;
@property (nonatomic, retain) UIActivityIndicatorView *activityIndicator;

- (id)initWithManagedObjectContext:(NSManagedObjectContext *)context;

@end
