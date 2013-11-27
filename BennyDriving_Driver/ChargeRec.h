//
//  ChargeRec.h
//  BennyDriving_Driver
//
//  Created by BennyDriving on 8/29/13.
//  Copyright (c) 2013 BennyDriving. All rights reserved.
//

#import "ButtomBarD2.h"

@interface ChargeRec : ButtomBarD2<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) UITableView *chargeRecList;
@property (nonatomic,strong) NSMutableArray *recordInfoArr;

-(void)setBackLeftBarButtonItem;

@end
