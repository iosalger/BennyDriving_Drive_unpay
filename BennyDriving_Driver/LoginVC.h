//
//  LoginVC.h
//  BennyDriving_Driver
//
//  Created by BennyDriving on 9/9/13.
//  Copyright (c) 2013 BennyDriving. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASIHttpHeaders.h"
#import "tooles.h"
#import "AgreementContentController.h"


@class TPKeyboardAvoidingScrollView;

@interface LoginVC : UIViewController<UITextFieldDelegate>
{
    TPKeyboardAvoidingScrollView *scrollView;
    UITextField *username;
    UITextField *password;
}

@property (nonatomic, retain) TPKeyboardAvoidingScrollView *scrollView;

@property (nonatomic,retain) UITextField *username;
@property (nonatomic,retain) UITextField *password;

@property (nonatomic,strong) UIImageView *loginBox;
@property (nonatomic,strong) UIImageView *loginHead;

@property (nonatomic,strong) UILabel *lbl_notice;

@property (nonatomic,strong) NSDictionary *fetchInfodic;

@property (nonatomic, retain) IBOutlet AgreementContentController *contentController;

-(void)setBackLeftBarButtonItem;

@end

