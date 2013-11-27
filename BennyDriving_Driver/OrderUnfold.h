//
//  OrderUnfold.h
//  BennyDriving_Driver
//
//  Created by ZHOUHONG on 9/9/13.
//  Copyright (c) 2013 BennyDriving. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrderListVC.h"

@interface OrderUnfold : UIViewController

@property (strong, nonatomic) NSArray *subCates;
@property (strong, nonatomic) OrderListVC *cateVC;

-(void)getOrder;

@end
