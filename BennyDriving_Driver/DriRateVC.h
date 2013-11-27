//
//  DriRateVC.h
//  BennyDriving_Driver
//
//  Created by ZHOUHONG on 8/20/13.
//  Copyright (c) 2013 BennyDriving. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ButtomBarD2.h"

@interface DriRateVC : ButtomBarD2 <UITableViewDelegate,UITableViewDataSource>

//@property (strong,nonatomic) UIImageView *drihead;
//@property (strong,nonatomic) UILabel *driname;
//@property (strong,nonatomic) UILabel *drirate;
//@property (strong,nonatomic) UILabel *driworkid;
//@property (strong,nonatomic) UILabel *driidcard;
//@property (strong,nonatomic) UILabel *dridist;

@property (strong,nonatomic) NSArray *driInfoArr;
@property (strong,nonatomic) NSArray *driComment;
@property (strong,nonatomic) NSArray *dricomTimeArr;
@property (strong,nonatomic) NSArray *dricomDateArr;
@property (strong,nonatomic) NSArray *dricomContentArr;

//@property (nonatomic,strong) UIScrollView *comment;
@property (nonatomic,strong) UITableView *commentTable;
@property (nonatomic,strong) UIToolbar *bottombar;
@property (nonatomic,strong) UIImageView *commentTitle;

@property (nonatomic,strong) UIView *contentView;

-(void)loadprofile;
-(void)setBackLeftBarButtonItem;

@end
