//
//  MJSecondDetailViewController.h
//  BennyDriving_Driver
//
//  Created by Martin Juhasz on 24.06.12.
//  Copyright (c) 2012 martinjuhasz.de. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MJSecondPopupDelegate;

@interface WithdrawPopVC : UIViewController

@property (assign, nonatomic) id <MJSecondPopupDelegate>delegate;

@end

@protocol MJSecondPopupDelegate<NSObject>
@optional
- (void)cancelButtonClicked:(WithdrawPopVC*)WithdrawPopVC;
@end