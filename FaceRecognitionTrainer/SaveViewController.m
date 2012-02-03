//
//  SaveViewController.m
//  FaceRecognitionTrainer
//
//  Created by Frederik Jacques on 30/01/12.
//  Copyright (c) 2012 dev-dev. All rights reserved.
//

#import "SaveViewController.h"
#import "TrainingCell.h"
#import "AddUserView.h"

@implementation SaveViewController

@synthesize tableview;
@synthesize managedObjectContext;
@synthesize fetchResultController;

@synthesize navigationBar;

@synthesize selectedUser;
@synthesize addUserVC;

- (id)initWithManagedObjectContext:(NSManagedObjectContext *) context{
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
        // Custom initialization
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(userAdded:) name:@"USER_ADDED" object:self.addUserVC];
        
        self.managedObjectContext = context;
        
        NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"User"];
        
        NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"firstname" ascending:YES];
        NSArray *arrSortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor, nil];
        request.sortDescriptors = arrSortDescriptors;
        [arrSortDescriptors release];
        arrSortDescriptors = nil;
        
        self.fetchResultController = [[[NSFetchedResultsController alloc] initWithFetchRequest:request managedObjectContext:self.managedObjectContext sectionNameKeyPath:nil cacheName:nil] autorelease];
        self.fetchResultController.delegate = self;
        
        NSError *error = nil;
        if( [self.fetchResultController performFetch:&error] ){
            NSLog(@"[SaveVC] Fetching users succeeded");
        }else{
            NSLog(@"[SaveVC] Fetching users failed");
        }
    }
    return self;
}

#pragma mark - NSFetchedResultsControllerDelegate methods
- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
    NSLog(@"[SaveVC] Model has been updated!");
    [self.tableview reloadData];
}


- (IBAction)addButtonClicked:(id)sender {
    NSLog(@"[SaveVC] Add tapped");
    self.addUserVC = [[[AddUserView alloc] initWithManagedObjectContext:self.managedObjectContext] autorelease];
    [self presentModalViewController:self.addUserVC animated:YES];
}

- (void)userAdded:(id)sender {
    NSLog(@"[SaveVC] User added");
    [self.addUserVC dismissModalViewControllerAnimated:YES];
//    [self.tableview reloadData];
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
    selectedUser = cell.user;
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"SAVE_USER" object:self];
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
    self.tableview = nil;
    self.fetchResultController = nil;
    
    self.selectedUser = nil;
    self.addUserVC = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)dealloc {
    NSLog(@"[SaveViewVC] Dealloc");
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"USER_ADDED" object:self.addUserVC];
    
    [tableview release];
    tableview = nil;
    
    [selectedUser release];
    selectedUser = nil;
    
    [fetchResultController release];
    fetchResultController = nil;
    
    [addUserVC release];
    addUserVC = nil;
    
    [super dealloc];
}

@end
