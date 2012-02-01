//
//  TrainingViewController.h
//  FaceRecognitionTrainer
//
//  Created by Frederik Jacques on 30/01/12.
//  Copyright (c) 2012 dev-dev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "TrainingCall.h"

@interface TrainingViewController : UITableViewController <NSFetchedResultsControllerDelegate>{
    NSManagedObjectContext *managedObjectContext;
    NSFetchedResultsController *fetchResultController;
    TrainingCall *trainingCall;
    
    UIActivityIndicatorView *activityIndicator;
}

@property (nonatomic, assign) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain) NSFetchedResultsController *fetchResultController;
@property (nonatomic, retain) TrainingCall *trainingCall;
@property (nonatomic, retain) UIActivityIndicatorView *activityIndicator;

- (id)initWithStyle:(UITableViewStyle)style andManagedObjectContext:(NSManagedObjectContext *)context;

@end
