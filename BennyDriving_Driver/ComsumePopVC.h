//
//  MJSecondDetailViewController.h
//  BennyDriving_Driver
//
//  Created by BennyDriving on 8/29/13.
//  Copyright (c) 2013 BennyDriving. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MJSecondPopupDelegate;


@interface ComsumePopVC : UIViewController

@property (assign, nonatomic) id <MJSecondPopupDelegate>delegate;

@end



@protocol MJSecondPopupDelegate<NSObject>
@optional
- (void)cancelButtonClicked:(ComsumePopVC*)ComsumePopVC;
@end