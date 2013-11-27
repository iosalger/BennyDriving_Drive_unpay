//
//  BDDAppDelegate.h
//  BennyDriving_Driver
//
//  Created by BennyDriving on 8/19/13.
//  Copyright (c) 2013 BennyDriving. All rights reserved.
//



#import <UIKit/UIKit.h>

@class BDDViewController;

//@class DriLocVC;

@interface BDDAppDelegate : UIResponder <UIApplicationDelegate>

@property (nonatomic,assign)webType ws;

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) BDDViewController *viewController;
//@property (strong, nonatomic) DriLocVC *viewController;

@property (strong, nonatomic) UINavigationController *navHome;

@end