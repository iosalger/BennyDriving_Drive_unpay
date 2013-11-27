//
//  PriceListVC.h
//  BennyDriving_Driver
//
//  Created by ZHOUHONG on 8/13/13.
//  Copyright (c) 2013 BennyDriving. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TLTiltSlider.h"

@interface PriceListVC: UIViewController 

@property (nonatomic,strong) UIImageView *prlist;
@property (nonatomic,strong) UIImageView *prTable;

@property (nonatomic,strong)UIImageView *bottomBar;
@property (nonatomic,strong)UIButton *btn_seeCounter;

@property (retain,nonatomic) UILabel *mileZero,*mileMax,*mileValue,*dayprice,*nightprice;
@property (strong,nonatomic) TLTiltSlider *slider;

- (void)sliderChanged:(TLTiltSlider*)sender;

-(void)loadbody;
-(void)setBackLeftBarButtonItem;


@end
