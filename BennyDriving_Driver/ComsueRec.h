//
//  ComsueRec.h
//  BennyDriving_Driver
//
//  Created by BennyDriving on 8/29/13.
//  Copyright (c) 2013 BennyDriving. All rights reserved.
//

#import "ButtomBarD2.h"

@interface ComsueRec : ButtomBarD2<UITableViewDataSource,UITableViewDelegate>


@property (nonatomic,strong) UITableView *comsRecList;
@property (nonatomic,strong) NSMutableArray *recordInfoArr;
@property (nonatomic,strong) UIImageView *title;

-(void)setBackLeftBarButtonItem;

@end
