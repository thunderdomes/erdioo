//
//  AppDelegate.m
//  Erdioo
//
//  Created by Arie on 6/4/13.
//  Copyright (c) 2013 kumel. All rights reserved.
//

#import "AppDelegate.h"
#import "JASidePanelController.h"
#import "erdiooCenter.h"
#import "erdiooGroup.h"
#import "erdioomy.h"
#import "erdiooRegional.h"
#import "erdioLeft.h"
@implementation AppDelegate

- (void)dealloc
{
	[_window release];
    [super dealloc];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
	[[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(setCenter:)
												name:@"dealNotification"
											  object:nil];
	[Flurry startSession:flurry_api];
	[MagicalRecord setupCoreDataStackWithStoreNamed:@"MyDatabase.sqlite"];
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    // Override point for customization after application launch.
	self.viewController = [[JASidePanelController alloc] init];
	self.viewController.leftPanel = [[erdioLeft alloc] init];
	[self setCenter:nil];
    [self.window makeKeyAndVisible];
	
	//UINavigationBar *navBar = [erdiooCenter navigationBar];
	//UIImage *backgroundImage = [UIImage imageNamed:navbar];
	//[navBar setBackgroundImage:backgroundImage forBarMetrics:UIBarMetricsDefault];
	self.window.rootViewController = self.viewController;
    return YES;
}
-(void)setCenter:(NSNotification *)name{
	NSMutableArray *dict = (NSMutableArray*)name.object;
	if(name==nil){
		self.viewController.centerPanel = [[UINavigationController alloc] initWithRootViewController:[[erdiooCenter alloc] init]];
	}
	else if([[dict objectAtIndex:0] isEqualToString:@"erdiooCenter"]){
		self.viewController.centerPanel =nil;
		self.viewController.centerPanel = [[UINavigationController alloc] initWithRootViewController:[[erdiooCenter alloc] init]];
	}
	else if([[dict objectAtIndex:0] isEqualToString:@"erdiooRegional"]){
		self.viewController.centerPanel =nil;
		self.viewController.centerPanel = [[UINavigationController alloc] initWithRootViewController:[[erdiooRegional alloc] init]];
	}
	else if([[dict objectAtIndex:0] isEqualToString:@"erdioomy"]){
		self.viewController.centerPanel =nil;
		self.viewController.centerPanel = [[UINavigationController alloc] initWithRootViewController:[[erdioomy alloc] init]];
	}
	
}
- (void)applicationWillResignActive:(UIApplication *)application
{
	// Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
	// Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
	// Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
	// If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
	// Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
	// Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
	[MagicalRecord cleanUp];
	// Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
