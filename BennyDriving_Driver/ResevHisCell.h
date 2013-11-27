//
//  CateTableCell.h
//  top100
//
//  Created by Dai Cloud on 12-7-17.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SharedObj.h"
#import "ResevHisList.h"


@interface ResevHisCell : UITableViewCell

@property (strong, nonatomic) UILabel *title, *subTtile;
@property (strong, nonatomic) UIImageView *fin;
@property (strong, nonatomic) UIImageView *resevhis;
@property (strong,nonatomic)  UIButton *btn_fin;
@property (strong,nonatomic)  UIButton *btn_resevhis;

-(void)FinDetail:(id)sender;

@end
