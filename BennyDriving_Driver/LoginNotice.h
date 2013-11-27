//
//  LoginNotice.h
//  BennyDriving_Driver
//
//  Created by BennyDriving on 9/26/13.
//  Copyright (c) 2013 BennyDriving. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MJSecondPopupDelegate;

@interface LoginNotice : UIViewController <UIWebViewDelegate>

@property (nonatomic,retain) IBOutlet UIWebView *Notice;

@property (assign, nonatomic) id <MJSecondPopupDelegate>delegate;

@end

@protocol MJSecondPopupDelegate<NSObject>

@optional
- (void)cancelButtonClicked:(LoginNotice*)LN;

@end