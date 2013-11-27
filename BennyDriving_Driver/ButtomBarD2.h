//
//  ButtomBarD2.h
//  BennyDriving_Driver
//
//  Created by ZHOUHONG on 8/25/13.
//  Copyright (c) 2013 BennyDriving. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface ButtomBarD2 : UIViewController

@property (nonatomic,strong) UIButton* btn_rUnfold;
@property (nonatomic,strong) UIButton* btn_rFold;
@property (nonatomic,strong) UIButton* btn_lUnfold;
@property (nonatomic,strong) UIButton* btn_lFold;


@property (nonatomic,strong) UIView * pushView;
@property (nonatomic,strong) UIView * SevNumber;
@property (nonatomic,strong) UIView * LeftMenu;
@property (nonatomic,strong) UIView * RightMenu;


-(void)loadBottomBar;
-(void)loadAnimation;

@end
