//
//  CounterVC.h
//  BennyDriving_Driver
//
//  Created by ZHOUHONG on 8/22/13.
//  Copyright (c) 2013 BennyDriving. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CounterVC : UIViewController

@property (nonatomic,strong)UIImageView *counterbg;

@property (nonatomic,strong)UIImageView *bottomBar;
@property (nonatomic,strong)UIButton *btn_seePrice;

-(void)loadbody;

@end
