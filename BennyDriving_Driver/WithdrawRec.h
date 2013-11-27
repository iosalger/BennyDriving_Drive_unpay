//
//  WithdrawRec.h
//  BennyDriving_Driver
//
//  Created by BennyDriving on 8/29/13.
//  Copyright (c) 2013 BennyDriving. All rights reserved.
//

#import "ButtomBarD2.h"

@interface WithdrawRec : ButtomBarD2<UITableViewDataSource,UITableViewDelegate>


@property (nonatomic,strong) UITableView *withdrawRecList;
@property (nonatomic,strong) NSMutableArray *recordInfoArr;


-(void)setBackLeftBarButtonItem;


@end
