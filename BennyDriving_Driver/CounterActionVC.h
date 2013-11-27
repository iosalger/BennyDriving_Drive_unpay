//
//  CounterActionVC.h
//  BennyDriving_Driver
//
//  Created by ZHOUHONG on 8/22/13.
//  Copyright (c) 2013 BennyDriving. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CounterActionVC : UIViewController
{
    BOOL isRunning;
    BOOL isCarMoving;
    BOOL isServerOver;
    double total_LC;
    NSDate *startDate;
    NSDate *endDate;
    NSTimeInterval totalTimeInterval;
    NSTimeInterval timeInterval;
    unsigned long iMBCNT; //秒表计数
    
}
@property (assign, nonatomic) int iDJType;
@property (nonatomic,strong)UIImageView *counterbg;
@property (copy, nonatomic) NSString *m_strXSLC;
@property (retain, nonatomic) NSMutableDictionary *m_DicInfo;
@property (nonatomic,strong)NSString *pl;
-(void)loadbody;
- (void)doRefresh;
- (void)creatViews;

@end
