//
//  InfoCentreVC.h
//  BennyDriving_Driver
//
//  Created by BennyDriving on 8/13/13.
//  Copyright (c) 2013 BennyDriving. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InfoCentreVC : UIViewController<UITableViewDataSource, UITableViewDelegate>

-(void)loadBtn;

@property (nonatomic,strong)UIImageView *Homepic;
@property (nonatomic,strong)UITableView *InfoList;

@property (nonatomic,strong)UITableView *InfoCentreTable;
@property (nonatomic,strong)NSMutableArray *InfoCentreLst;

@property (nonatomic,strong)UIImageView *img_CompanyNews;
@property (nonatomic,strong)UIImageView *img_Foucs;
@property (nonatomic,strong)UIImageView *img_BBS;


@end
