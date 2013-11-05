//
//  ceritaAppDelegate.m
//  Cerita
//
//  Created by Yazid Bustomi on 10/12/13.
//  Copyright (c) 2013 netra. All rights reserved.
//

#import "ceritaAppDelegate.h"

@implementation ceritaAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
	[netra setPage:@"1"];
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
	[[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
[[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(-200.f, 0) forBarMetrics:UIBarMetricsDefault];
    // Override point for customization after application launch.
	NSShadow *shadow = [[NSShadow alloc] init];
    shadow.shadowColor = [UIColor clearColor];
    shadow.shadowOffset = CGSizeMake(0, 1);
    [[UINavigationBar appearance] setTitleTextAttributes: [NSDictionary dictionaryWithObjectsAndKeys:
                                                           [UIColor whiteColor], NSForegroundColorAttributeName,
                                                           shadow, NSShadowAttributeName,
                                                           [UIFont fontWithName:@"HelveticaNeue-Light" size:18], NSFontAttributeName, nil]];
	
	main_center = [[UIView alloc]initWithFrame:CGRectMake(85, 0, 150, 44)];
	main_center.backgroundColor = [UIColor clearColor];
	[main_center addSubview:navLabel];
	
	[[UINavigationBar appearance] setBackIndicatorImage:[UIImage imageNamed:@"back_"]];
    [[UINavigationBar appearance] setBackIndicatorTransitionMaskImage:[UIImage imageNamed:@"back_"]];
	drawerController = [[MMDrawerController alloc] init];
    [drawerController setRestorationIdentifier:@"netra"];
    [drawerController setMaximumRightDrawerWidth:270];
	[drawerController setMaximumLeftDrawerWidth:270];
    [drawerController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeAll];
    [drawerController setCloseDrawerGestureModeMask:MMCloseDrawerGestureModeAll];
	[drawerController setShouldStretchDrawer:FALSE];
	[drawerController setDrawerVisualStateBlock:[MMDrawerVisualState slideAndScaleVisualStateBlock]];
	[drawerController setShowsShadow:NO];
	[drawerController setRightDrawerViewController:[[NSClassFromString(@"rightViewController") alloc]init]];
	[drawerController setLeftDrawerViewController:[[NSClassFromString(@"leftviewController") alloc]init]];
	
	[self setCenter:@"ceritaViewController" title:@"Day Tripper" cat:@""];
    self.window.backgroundColor = [UIColor whiteColor];
	self.window.rootViewController = drawerController;
    [self.window makeKeyAndVisible];
    return YES;
}
-(void)setCenter:(NSString *)center title:(NSString *)title cat:(NSString *)categorys{
	
	[netra setNewsContent:categorys];
	if([center isEqualToString:last_string]&&[last_category isEqualToString:categorys]){
		[drawerController setCenterViewController:navigation withCloseAnimation:YES completion:nil];
		
	}
	else{
		[netra setPage:@"1"];
		[navigation removeFromParentViewController];
		navigation = [[UINavigationController alloc]initWithRootViewController:[[NSClassFromString(center) alloc]init]];
		navigation.navigationBar.tintColor = [UIColor whiteColor];
		[drawerController setCenterViewController:navigation withCloseAnimation:YES completion:nil];
		last_string = center;
		last_category = categorys;
	}
	
	[navigation.navigationBar setBackgroundImage:[UIImage imageNamed:@"nav"] forBarMetrics:UIBarMetricsDefault];
	
	[navigation.navigationBar addSubview:main_center];
	
}
-(void)disableSwipe{
	[drawerController setRightDrawerViewController:Nil];
	[drawerController setLeftDrawerViewController:Nil];
	
	
}
-(void)openRight{
	[drawerController openDrawerSide:MMDrawerSideRight animated:YES completion:Nil];
}
-(void)enableSwipe{
	[drawerController setRightDrawerViewController:[[NSClassFromString(@"rightViewController") alloc]init]];

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
	// Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
