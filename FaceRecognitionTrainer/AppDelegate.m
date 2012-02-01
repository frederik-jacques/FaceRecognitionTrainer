//
//  AppDelegate.m
//  FaceRecognitionTrainer
//
//  Created by Frederik Jacques on 29/01/12.
//  Copyright (c) 2012 dev-dev. All rights reserved.
//

#import "AppDelegate.h"

#import "DetectViewController.h"
#import "TrainingViewController.h"
#import "RecognizeViewController.h"

@interface AppDelegate()
- (void)useDatabase;
@end

@implementation AppDelegate

@synthesize window = _window;
@synthesize tabBarController = _tabBarController;
@synthesize userDatabase;

- (void)dealloc {
    [_window release];
    _window = nil;
    
    [_tabBarController release];
    _tabBarController = nil;
    
    [userDatabase release];
    userDatabase = nil;
    
    [super dealloc];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [[UIApplication sharedApplication] setStatusBarHidden:YES];
    
    if( !self.userDatabase ){
        NSURL *url = [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
        url = [url URLByAppendingPathComponent:@"userDB"];
        
        self.userDatabase = [[[UIManagedDocument alloc] initWithFileURL:url] autorelease];
    }
    
    return YES;
}

- (void)startApp {
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    
    // Override point for customization after application launch.
    UIViewController *detectVC = [[[DetectViewController alloc] initWithManagedObjectContext:self.userDatabase.managedObjectContext] autorelease];
    
    UIViewController *trainingVC = [[[TrainingViewController alloc] initWithStyle:UITableViewStylePlain andManagedObjectContext:self.userDatabase.managedObjectContext] autorelease];
    
    UIViewController *recognizeVC = [[[RecognizeViewController alloc] initWithManagedObjectContext:self.userDatabase.managedObjectContext] autorelease];
    
    self.tabBarController = [[[UITabBarController alloc] init] autorelease];
    self.tabBarController.viewControllers = [NSArray arrayWithObjects:detectVC, trainingVC, recognizeVC, nil];
    
    self.window.rootViewController = self.tabBarController;
    [self.window makeKeyAndVisible];
}

- (void)useDatabase {
    NSLog(@"[AppDelegate] Open database");
    if( ![[NSFileManager defaultManager] fileExistsAtPath:[self.userDatabase.fileURL path]] ){
        NSLog(@"Create new database");
        [self.userDatabase saveToURL:self.userDatabase.fileURL forSaveOperation:UIDocumentSaveForCreating completionHandler:^(BOOL success){
            NSLog(@"Created new database");
            [self startApp];
        }];
    }else if( self.userDatabase.documentState == UIDocumentStateClosed ){
        NSLog(@"Database closed ... opening");
        [self.userDatabase openWithCompletionHandler:^(BOOL success){
            NSLog(@"Database now open");
            [self startApp];
        }];
    }else if( self.userDatabase.documentState == UIDocumentStateNormal ){
        NSLog(@"Database normal");
        [self startApp];
    }
}

- (void)setUserDatabase:(UIManagedDocument *)theUserDatabase {
    if( self.userDatabase != theUserDatabase ){
        [userDatabase release];
        userDatabase = [theUserDatabase retain];
        
        [self useDatabase];
    }
}

- (void)applicationWillResignActive:(UIApplication *)application {
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
     */
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    /*
     Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
     */
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}

- (void)applicationWillTerminate:(UIApplication *)application {
    /*
     Called when the application is about to terminate.
     Save data if appropriate.
     See also applicationDidEnterBackground:.
     */
}

/*
// Optional UITabBarControllerDelegate method.
- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
}
*/

/*
// Optional UITabBarControllerDelegate method.
- (void)tabBarController:(UITabBarController *)tabBarController didEndCustomizingViewControllers:(NSArray *)viewControllers changed:(BOOL)changed
{
}
*/

@end
