//
//  AdvServiceVC.h
//  BennyDriving_Driver
//
//  Created by BennyDriving on 8/13/13.
//  Copyright (c) 2013 BennyDriving. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ButtomBarD2.h"

@interface AdvServiceVC : ButtomBarD2<UITableViewDataSource, UITableViewDelegate>


@property (nonatomic,strong)UITableView *AdvSVTable;
@property (nonatomic,strong)NSMutableArray *AdvSVLst;

@property (nonatomic,strong)UIImageView *img_InqueryInfo;
@property (nonatomic,strong)UIImageView *img_Searchmap;
@property (nonatomic,strong)UIImageView *img_Aid;


-(void)loadBtn;
-(void)setBackLeftBarButtonItem;

@end
