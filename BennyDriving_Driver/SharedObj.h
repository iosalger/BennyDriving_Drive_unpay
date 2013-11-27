//
//  SharedObj.h
//  BennyDriving_Driver
//
//  Created by ZHOUHONG on 8/14/13.
//  Copyright (c) 2013 BennyDriving. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SharedObj : UIViewController
{
    NSInteger switchison;
}

+ (SharedObj *)sharedOBJ;

@property (nonatomic,strong)UIImageView *SerNum;
@property (nonatomic,strong)UIButton *dialNum;
@property (nonatomic,assign)NSInteger switchon;
@property (nonatomic,assign)NSInteger segmentIndex;

@property (nonatomic,assign)NSInteger indexPathRow_news;
@property (nonatomic,assign)NSInteger indexPathRow_orders;

@property (nonatomic,strong)NSString *logindriid;
@property (nonatomic,strong)NSString *logindrinum;
@property (nonatomic,strong)NSString *loginisagr;

@property (nonatomic,strong)NSString *startLocation;
@property (nonatomic,strong)NSString *endLocation;

@property (nonatomic,strong)NSString *starTime;
@property (nonatomic,strong)NSString *endTime;

@property (nonatomic,assign)double driLog;
@property (nonatomic,assign)double driLat;

@end
