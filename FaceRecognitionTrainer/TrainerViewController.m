//
//  TrainerViewController.m
//  FaceRecognitionTrainer
//
//  Created by Frederik Jacques on 01/02/12.
//  Copyright (c) 2012 dev-dev. All rights reserved.
//

#import "TrainerViewController.h"
#import "TrainingCell.h"

@implementation TrainerViewController

@synthesize tableview;
@synthesize managedObjectContext;
@synthesize fetchResultController;
@synthesize trainingCall;
@synthesize activityIndicator;

- (id)initWithManagedObjectContext:(NSManagedObjectContext *)context {
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
        // Custom initialization
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(trainingComplete:) name:@"TRAINING_COMPLETE" object:self.trainingCall];
        
        self.title = @"Train";
        self.tabBarItem.image = [UIImage imageNamed:@"second"];
        
        self.managedObjectContext = context;
        
        NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"User"];
        
        NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"label" ascending:YES];
        NSArray *arrSortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor, nil];
        request.sortDescriptors = arrSortDescriptors;
        [arrSortDescriptors release];
        arrSortDescriptors = nil;
        
        request.predicate = [NSPredicate predicateWithFormat:@"isTrained == NO"];
        
        self.fetchResultController = [[[NSFetchedResultsController alloc] initWithFetchRequest:request managedObjectContext:self.managedObjectContext sectionNameKeyPath:nil cacheName:nil] autorelease];
        self.fetchResultController.delegate = self;
        
        NSError *error = nil;
        if( [self.fetchResultController performFetch:&error] ){
            NSLog(@"[TrainingVC] Fetching users succeeded");
        }else{
            NSLog(@"[TrainingVC] Fetching users failed");
        }
        
        self.activityIndicator = [[[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray] autorelease];
        self.activityIndicator.hidesWhenStopped = YES;
        [self.activityIndicator setHidden:YES];
        self.activityIndicator.frame = CGRectMake(self.view.center.x, self.view.center.y, self.activityIndicator.frame.size.width, self.activityIndicator.frame.size.height);
        [self.view addSubview:self.activityIndicator];

    }
    return self;
}

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return [[self.fetchResultController sections] count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    id <NSFetchedResultsSectionInfo> sectionInfo = [[self.fetchResultController sections] objectAtIndex:section];
    return [sectionInfo numberOfObjects];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"UserCell";
    
    TrainingCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    User *user = [self.fetchResultController objectAtIndexPath:indexPath];
    
    if (cell == nil) {
        cell = [[[TrainingCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier andUser:user] autorelease];
    }
    
    // Configure the cell...
    cell.textLabel.text = user.label;
    
    return cell;
}

#pragma mark - Table view delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    TrainingCell *cell = (TrainingCell *)[tableView cellForRowAtIndexPath:indexPath];
    User *user = cell.user;
    
    [self.activityIndicator setHidden:NO];
    [self.activityIndicator startAnimating];
    self.trainingCall = [[[TrainingCall alloc] initWithUser:user] autorelease];
    [self.trainingCall execute];
}

- (void)trainingComplete:(id)sender {
    NSLog(@"[TrainingVC] Training complete");
    [self.activityIndicator stopAnimating];
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"User"];
    fetchRequest.predicate = [NSPredicate predicateWithFormat:@"uid MATCHES %@", self.trainingCall.user.uid];
    
    NSError *error = nil;
    NSArray *results = [self.managedObjectContext executeFetchRequest:fetchRequest error:&error];
    
    if ( results == nil) {
        NSLog(@"[TrainingVC] Fetch user FAILED");
    }else if( [results count] == 0 ) {
        NSLog(@"[TrainingVC] User does not exist!");
    }else{
        NSLog(@"[DetectVC] User exist!");
        User *user = [results lastObject];
        user.isTrained = [NSNumber numberWithBool:YES];
    }
}

#pragma mark - NSFetchedResultsControllerDelegate methods
- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
    NSLog(@"[TrainingVC] Model has been updated!");
    [self.tableview reloadData];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"TRAINING_COMPLETE" object:self.trainingCall];
    
    [trainingCall release];
    trainingCall = nil;
    
    [fetchResultController release];
    fetchResultController = nil;
    
    [activityIndicator release];
    activityIndicator = nil;
    
    [super dealloc];
}


@end
