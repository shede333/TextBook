//
//  TextBookAppDelegate.m
//  TextBook
//
//  Created by zhihuiguan on 11-7-15.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "TextBookAppDelegate.h"

#import "TextBookViewController.h"

@implementation TextBookAppDelegate


@synthesize window=_window;
@synthesize nc;
@synthesize viewController=_viewController;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
//    [[UIApplication sharedApplication] setStatusBarOrientation:UIInterfaceOrientationLandscapeRight animated:YES];
    // Override point for customization after application launch.
    self.window.rootViewController = self.nc;
    [self.window makeKeyAndVisible];
    [self DuplicateDB];
    return YES;
}

- (void)DuplicateDB{
    NSString *orginDBPath = [[NSBundle mainBundle] pathForResource:@"MonsterChat" ofType:@"sqlite"];
    NSString *targetDBPath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/MonsterChat.sqlite"];
    NSFileManager *filemanager = [NSFileManager defaultManager];
    if (![filemanager fileExistsAtPath:targetDBPath]) {
        NSError *error;
        [filemanager copyItemAtPath:orginDBPath toPath:targetDBPath error:&error];
        NSAssert(error, @"error:%@",error);
    }
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
     */
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    /*
     Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
     */
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    /*
     Called when the application is about to terminate.
     Save data if appropriate.
     See also applicationDidEnterBackground:.
     */
}

- (void)dealloc
{
    [nc release];
    [_window release];
    [_viewController release];
    [super dealloc];
}

@end
