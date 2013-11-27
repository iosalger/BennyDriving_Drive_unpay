//
//  AccountViewController.h
//  BennyDriving_Driver
//
//  Created by BennyDriving on 8/12/13.
//  Copyright (c) 2013 BennyDriving. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ButtomBarD2.h"
#import "UPPayPluginDelegate.h"

@class TPKeyboardAvoidingScrollView;

@interface AccountVC : ButtomBarD2<UITextFieldDelegate,UPPayPluginDelegate>
{
    
    TPKeyboardAvoidingScrollView *scrollView;
    UITextField *input_withdraw;
    UIAlertView* mAlert;
    NSMutableData* mData;

}

@property (nonatomic, retain) TPKeyboardAvoidingScrollView *scrollView;
@property (nonatomic,strong) UITextField *input_withdraw;
@property (nonatomic,strong) UIImageView *bgbox;

@property (nonatomic,strong) NSDictionary *dic;

-(void)setBackLeftBarButtonItem;

@end
