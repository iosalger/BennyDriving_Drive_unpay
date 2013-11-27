//
//  BDDAppDelegate.m
//  BennyDriving_Driver
//
//  Created by BennyDriving on 8/19/13.
//  Copyright (c) 2013 BennyDriving. All rights reserved.
//

#import "BDDAppDelegate.h"
#import "BDDViewController.h"
#import "SharedObj.h"
#import "SevCenterVC.h"
#import "LoginVC.h"


@implementation BDDAppDelegate

@synthesize window,viewController,navHome,ws;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
   //self.window = [[UIWindow alloc] initWithFrame:CGRectMake(0, 10, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height-10)];
    self.ws = web1;
    self.viewController = [[BDDViewController alloc] initWithNibName:@"BDDViewController" bundle:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(goSevCentre) name:@"goSevCentre" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(goHome) name:@"goHomeVC" object:nil];
    
    self.navHome = [[UINavigationController alloc] initWithRootViewController:self.viewController];
    self.window.rootViewController = self.navHome;
    [self.window makeKeyAndVisible];
    return YES;
}

-(void)goHome
{
    self.viewController = [[BDDViewController alloc] init];
    self.navHome = [[UINavigationController alloc] initWithRootViewController:self.viewController];
    self.window.rootViewController = self.navHome;
}

-(void)goSevCentre
{
        if([[SharedObj sharedOBJ].logindriid isEqualToString:@""])
        {
            LoginVC *login = [[LoginVC alloc] init];
            self.navHome = [[UINavigationController alloc] initWithRootViewController:login];
            self.window.rootViewController = self.navHome;
            
        }else if(![[SharedObj sharedOBJ].logindriid isEqualToString:@""])
        {
            SevCenterVC *scVC = [[SevCenterVC alloc] init];
            self.navHome = [[UINavigationController alloc] initWithRootViewController:scVC];
            self.window.rootViewController = self.navHome;
        }

//    DriMapVC *DriMap = [[DriMapVC alloc] initWithNibName:@"DriMapVC" bundle:nil];
//    DriMap.delegate = self;
//    self.navHome = [[UINavigationController alloc] initWithRootViewController:DriMap];
//    self.window.rootViewController = self.navHome;
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
