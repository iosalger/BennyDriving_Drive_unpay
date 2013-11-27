//
//  SevFinPop.h
//  BennyDriving_Driver
//
//  Created by ZHOUHONG on 9/2/13.
//  Copyright (c) 2013 BennyDriving. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MJSecondPopupDelegate;


@interface SevFinPop : UIViewController

@property (assign, nonatomic) id <MJSecondPopupDelegate>delegate;

@end


@protocol MJSecondPopupDelegate<NSObject>
@optional

- (void)cancelButtonClicked:(SevFinPop*)SevFinPop;
@end