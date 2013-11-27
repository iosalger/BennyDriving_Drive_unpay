//
//  MobileMallVC.h
//  BennyDriving_Driver
//
//  Created by BennyDriving on 8/13/13.
//  Copyright (c) 2013 BennyDriving. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ButtomBarD2.h"

@interface MobileMallVC : ButtomBarD2<UIAlertViewDelegate>

@property (nonatomic,strong)UIImageView *SerNum;
@property (nonatomic,strong)UIButton *dialNum;

@property (nonatomic,strong)UIImageView *bottomBar;
@property (nonatomic,strong)UIButton *btn_download;


-(void)loadBottomBar;
-(void)setBackLeftBarButtonItem;

@end
