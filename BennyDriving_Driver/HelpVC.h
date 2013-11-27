//
//  HelpVC.h
//  BennyDriving_Driver
//
//  Created by BennyDriving on 8/13/13.
//  Copyright (c) 2013 BennyDriving. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HelpVC : UIViewController<UITableViewDataSource, UITableViewDelegate,UIWebViewDelegate>

@property (nonatomic,strong)UIImageView *Homepic;
@property (nonatomic,strong)UITableView *helpList;

@property (nonatomic,strong)NSMutableArray *HelpLst;

@property (nonatomic,strong)UIImageView *img_aboutUs;
@property (nonatomic,strong)UIImageView *img_terms;
@property (nonatomic,strong)UIImageView *img_faq;
@property (nonatomic,strong)UIImageView *img_feedback;
@property (nonatomic,strong)UIImageView *img_rateSoft;

@property (nonatomic,strong)UILabel *lbl_aboutUs;
@property (nonatomic,strong)UILabel *lbl_terms;
@property (nonatomic,strong)UILabel *lbl_faq;
@property (nonatomic,strong)UILabel *lbl_feedback;
@property (nonatomic,strong)UILabel *lbl_rateSoft;

-(void)loadBtn;
-(void)terms;
-(void)setBackLeftBarButtonItem;

@end
