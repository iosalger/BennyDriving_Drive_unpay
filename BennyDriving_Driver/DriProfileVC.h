//
//  ProfileViewController.h
//  BennyDriving_Driver
//
//  Created by BennyDriving on 8/12/13.
//  Copyright (c) 2013 BennyDriving. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EGORefreshTableHeaderView.h"
#import "ButtomBarD2.h"

@interface DriProfileVC : UIViewController <EGORefreshTableHeaderDelegate,UITableViewDelegate,UITableViewDataSource>{
	
	EGORefreshTableHeaderView *_refreshHeaderView;
	
	//  Reloading var should really be your tableviews datasource
	//  Putting it here for demo purposes 
	BOOL _reloading;
}

@property (nonatomic,strong) UIImageView *driPhoto;
@property (nonatomic,strong) UILabel *gender;
@property (nonatomic,strong) UILabel *licenType;
@property (nonatomic,strong) UILabel *idcardNum;
@property (nonatomic,strong) UILabel *drilicenNum;
@property (nonatomic,strong) UILabel *idcardAddress;
@property (nonatomic,strong) UILabel *liveAddress;
@property (nonatomic,strong) UILabel *ergContName;
@property (nonatomic,strong) UILabel *ergContactPhone;

@property (strong,nonatomic) NSArray *driProArr;
@property (strong,nonatomic) NSMutableArray *titleArr;
@property (strong,nonatomic) NSMutableArray *valueArr;


@property (nonatomic,strong) UITableView *driproTable;

@property (nonatomic,strong)UIButton *checkname;
//@property (nonatomic,strong)UIButton *checkname;
//@property (nonatomic,strong)UIButton *checkname;
//@property (nonatomic,strong)UIButton *checkname;
@property (nonatomic,strong)UIButton *Checkbtn;
@property (nonatomic,strong)UIButton *photoCKbtn;
@property (nonatomic,strong)NSMutableArray *btnArray;


@property (nonatomic,strong)UIImageView *bottomBar;
@property (nonatomic,strong)UIButton *btn_submit;

@property (nonatomic,strong)NSDictionary *profiledic;

-(void)setBackLeftBarButtonItem;

- (void)reloadTableViewDataSource;
- (void)doneLoadingTableViewData;
-(void)loadrefreshead;


@end
