//
//  StoreRateVC.h
//  BennyDriving_Driver
//
//  Created by BennyDriving on 8/14/13.
//  Copyright (c) 2013 BennyDriving. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ButtomBarD2.h"

@interface StoreRateVC : ButtomBarD2<UIWebViewDelegate>

@property(nonatomic,retain)UIWebView *storeRate;

- (void)loadWebPageWithString;

@end
