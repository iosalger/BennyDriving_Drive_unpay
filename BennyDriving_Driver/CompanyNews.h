//
//  CompanyNews.h
//  BennyDriving_Driver
//
//  Created by BennyDriving on 8/31/13.
//  Copyright (c) 2013 BennyDriving. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CompanyNews : UIViewController<UITableViewDelegate,UITableViewDataSource>

@property (strong,nonatomic)UITableView *NewsTable;
@property (strong,nonatomic)UIImageView *CoverImage;
@property (strong,nonatomic)UITextView *NewsContent;

@end
