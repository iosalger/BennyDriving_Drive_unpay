//
//  OrderListVC.h
//  BennyDriving_Driver
//
//  Created by ZHOUHONG on 9/9/13.
//  Copyright (c) 2013 BennyDriving. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIFolderTableView.h"

@interface OrderListVC : UIViewController <UITableViewDataSource, UITableViewDelegate,UIAlertViewDelegate>

//@property (strong, nonatomic) NSArray *cates;
@property (strong, nonatomic) IBOutlet UIFolderTableView *tableView;
@property (nonatomic,strong)UIImageView *Homepic;


-(void)getOrder;
-(void)setBackLeftBarButtonItem;

@end
