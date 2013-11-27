//
//  CounterActionVC.m
//  BennyDriving_Driver
//
//  Created by ZHOUHONG on 8/22/13.
//  Copyright (c) 2013 BennyDriving. All rights reserved.
//

#import "CounterActionVC.h"
#import "NSThread+test.h"
#import <CoreLocation/CoreLocation.h>
#import "SevFinPop.h"
#import "UIViewController+MJPopupViewController.h"
#import "SharedObj.h"

#define K_DJ_TYPE1  2.00 //白天 3<X<10 单价
#define K_DJ_TYPE2  4.00 //白天 X > 10 单价
#define K_DJ_TYPE3  4.00 //黑夜 3<X<10 单价
#define K_DJ_TYPE4  6.00 //黑夜 X > 10 单价

#define STARTDATE   @"StartDate"
#define ENDDATE     @"EndDate"
#define WAITTIME    @"WaitTime"
#define ZJE         @"ZongJinE"
@interface CounterActionVC () <UIAlertViewDelegate,CLLocationManagerDelegate,MJSecondPopupDelegate>{
    SevFinPop *sevFinPop;
}
@property (strong, nonatomic) CLLocationManager *locationManager;
@property (strong, nonatomic) NSMutableArray *Arr;
@property (strong, nonatomic) UILabel *lab_ZJE;        //总金额
@property (strong, nonatomic) UILabel *lab_CurrentTM;  //系统当前时间
@property (nonatomic,strong) UILabel *nowlabel;//当前时间
@property (assign, nonatomic) double km;
@property (strong, nonatomic) UILabel *lab_SJD_B;      //白天时间段
@property (strong, nonatomic) UILabel *lab_SJD_H;      //黑夜时间段
@property (strong, nonatomic) UILabel *lab_XSLC;       //行驶里程
@property (strong, nonatomic) UILabel *lab_B_DJ1;      //白天单价1
@property (strong, nonatomic) UILabel *lab_B_DJ2;      //白天单价2
@property (strong, nonatomic) UILabel *lab_H_DJ1;      //黑夜单价1
@property (strong, nonatomic) UILabel *lab_H_DJ2;      //黑夜单价2
@property (strong, nonatomic) UILabel *lab_LCFY;       //里程费用
@property (strong, nonatomic) UILabel *lab_DDSJ;       //等待时间
@property (strong, nonatomic) UILabel *lab_DDFY;       //等待费用
@property (strong, nonatomic) UILabel *lab_CRT_Status; //当前状态
@property (strong, nonatomic) UIButton *btn_pause;
@property (strong, nonatomic) UIButton *btn_start;
@property (strong, nonatomic) UIButton *btn_finish;
@property (strong, nonatomic) NSTimer *timer_CurrentTM;
@property (strong, nonatomic) NSTimer *timer_MB;
@property (strong, nonatomic) NSTimer *timer_Refresh;
@property (strong, nonatomic) NSThread *_thread;
@property (strong, nonatomic) UIView *popView;
@property (strong, nonatomic) UITapGestureRecognizer *tap;
@end

@implementation CounterActionVC

@synthesize counterbg;
@synthesize lab_ZJE;
@synthesize lab_CurrentTM;
@synthesize lab_SJD_B;
@synthesize lab_SJD_H;
@synthesize lab_XSLC;
@synthesize lab_B_DJ1;
@synthesize lab_B_DJ2;
@synthesize lab_H_DJ1;
@synthesize lab_H_DJ2;
@synthesize lab_LCFY;
@synthesize lab_DDSJ;
@synthesize lab_DDFY;
@synthesize lab_CRT_Status;
@synthesize btn_pause,btn_start,btn_finish;

@synthesize timer_CurrentTM;
@synthesize timer_MB;
@synthesize timer_Refresh;
@synthesize _thread;
@synthesize iDJType;
@synthesize m_strXSLC;
@synthesize m_DicInfo,locationManager;
@synthesize Arr;
@synthesize popView;
@synthesize tap,km;
@synthesize pl;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
       
    }
    return self;
}


- (void)initInfo
{

    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"计价器";
    UIButton *lbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    lbtn.frame = CGRectMake(0, 0, 40, 40);
    [lbtn setBackgroundImage:[UIImage imageNamed:@"btn_back"] forState:UIControlStateNormal];
    [lbtn addTarget:self action:@selector(doBack:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *lbarbtn = [[UIBarButtonItem alloc]initWithCustomView:lbtn];
    self.navigationItem.leftBarButtonItem = lbarbtn;
    
    
    UIButton *rbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rbtn.frame = CGRectMake(0, 0, 40, 40);
    [rbtn setBackgroundImage:[UIImage imageNamed:@"btn_home"] forState:UIControlStateNormal];
    [rbtn addTarget:self action:@selector(handleHome) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rbarbtn = [[UIBarButtonItem alloc]initWithCustomView:rbtn];
    self.navigationItem.rightBarButtonItem = rbarbtn;
    
    
    isRunning = false;
    iMBCNT = 0;
    iDJType = 1;
    m_strXSLC = @"0";
    m_DicInfo = [NSMutableDictionary dictionaryWithCapacity:10];
    
}

-(void)doBack:(UIButton *)bt
{
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"确认退出" message:@"你确定要退出计价器吗？退出可能清空所有计时计费！"
                                                 delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确认", nil];
    alert.tag = 100;
	[alert show];
    
}



-(void)handleHome
{
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"确认退出" message:@"你确定要退出计价器吗？退出可能清空所有计时计费！"
                                                    delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确认", nil];
    alert.tag = 101;
	[alert show];

}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden=NO;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    [self initInfo];
    [self loadbody];
    [self creatViews];
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"couter_bg"]];

    if ([CLLocationManager locationServicesEnabled])
    {
        locationManager = [[CLLocationManager alloc]init];
        locationManager.delegate = self;
        locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        locationManager.distanceFilter = 5.0f;
       
    }

    //实时更新界面
    [self doRefresh];
    
}
#pragma mark - locationManagerdelegate
- (void)locationManager:(CLLocationManager *)manager
	didUpdateToLocation:(CLLocation *)newLocation
		   fromLocation:(CLLocation *)oldLocation
{
    km += [newLocation distanceFromLocation:oldLocation];
    [lab_XSLC setText:[NSString stringWithFormat:@"%d",abs(km/1000)]];
    
    /////////获取位置信息
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    [geocoder reverseGeocodeLocation:newLocation completionHandler:^(NSArray* placemarks,NSError *error)
     {
         if (placemarks.count >0   )
         {
             CLPlacemark * plmark = [placemarks objectAtIndex:0];
             
             NSString * country = plmark.country;
             NSString * city    = plmark.locality;
             
             
             NSLog(@"%@-%@-%@",country,city,plmark.name);
             //self.m_locationName.text =plmark.name;
             pl = [NSString stringWithFormat:@"%@-%@-%@",country,city,plmark.name];
             
         }
         
         NSLog(@"%@",placemarks);
         
     }];

}

- (void)doRefresh
{
    timer_Refresh = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(refreshInfo) userInfo:nil repeats:YES];
}

- (void)refreshInfo
{
    NSDate *date=[NSDate date];
    NSDateFormatter *formater=[[NSDateFormatter alloc] init];
    //设置日期格式
    formater.dateFormat=@"yyyy-MM-dd HH:mm:ss";  //HH大写代表24时制  hh代表12小时制
    //把日期变成字符串
    NSString *strCurrentTM=[formater stringFromDate:date];
    NSLog(@"strCurrentTM=%@",strCurrentTM);
    NSArray *Arr1 = [strCurrentTM componentsSeparatedByString:@" "];
//    NSLog(@"arr=%@",Arr);
    //设置时区
    formater.locale=[[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
    //把字符串变成日期
    //返回的是格林制时间
    date=[formater dateFromString:@"2013-05-16 13:40:50"];
    [lab_CurrentTM setText:[Arr1 objectAtIndex:1]];
    
    //根据当前时间判断目前的单价 红色高亮显示
    NSArray *arrDate = [strCurrentTM componentsSeparatedByString:@" "];
    NSArray *arrTiem = [[arrDate objectAtIndex:1] componentsSeparatedByString:@":"];
    NSString *strHH =   [arrTiem objectAtIndex:0];
    m_strXSLC = [lab_XSLC text];
    if ([strHH integerValue] >= 8 && [strHH integerValue] < 22) {
        [lab_SJD_H setText:@"日"];
//        [lab_SJD_B setHighlightedTextColor:[UIColor redColor]];
        if ([m_strXSLC integerValue] < 10) {
            self.iDJType = 1;
            [lab_SJD_B setText:@"2"];
//            [lab_B_DJ1 setHighlighted:true];
//            [lab_B_DJ1 setHighlightedTextColor:[UIColor redColor]];
        } else {
            self.iDJType = 2;
             [lab_SJD_B setText:@"4"];
//            [lab_B_DJ2 setHighlighted:true];
//            [lab_B_DJ2 setHighlightedTextColor:[UIColor redColor]];
        }
    } else {
        [lab_SJD_H setText:@"夜"];
//        [lab_SJD_H setHighlightedTextColor:[UIColor redColor]];
        if ([m_strXSLC integerValue] < 10) {
            self.iDJType = 3;
             [lab_SJD_B setText:@"4"];
//            [lab_H_DJ1 setHighlighted:true];
//            [lab_H_DJ1 setHighlightedTextColor:[UIColor redColor]];
        } else {
            self.iDJType = 4;
             [lab_SJD_B setText:@"6"];
//            [lab_H_DJ2 setHighlighted:true];
//            [lab_H_DJ2 setHighlightedTextColor:[UIColor redColor]];
        }
    }

}

- (void)setLabsText
{
    ////获取当前时间 + 根据当前时间判断目前的单价 红色高亮显示
    timer_CurrentTM = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(doCal:) userInfo:nil repeats:YES];
    
}

- (void)calLCFY
{
    //计算里程费用   
    m_strXSLC = [lab_XSLC text];
    NSString *strLCFY = @"";
    if ([m_strXSLC floatValue] < 3) {
        [lab_LCFY setText:@"15.00"];
        return;
    } else {
    switch (iDJType) {
        case 1:
        {
            float f_Current_LCFY = 0.00;
            float fcuttentLC = [m_strXSLC floatValue];
            //根据实际情况，它前面可能是从type = 3 跳转到 type = 1；
            if ([m_DicInfo objectForKey:@"3"] != nil) { //有 type = 3 
                float f_orign_LC = [[m_DicInfo objectForKey:@"3"] floatValue];
                //根据实际情况，取type = 3时，有可能行驶里程 < 3
                if (f_orign_LC > 3) {//行驶里程 > 3
                    f_Current_LCFY = 15.00 + (f_orign_LC - 3)*4.00 + (fcuttentLC - f_orign_LC)*2.00;
                } else {//行驶里程 < 3
                    f_Current_LCFY = 15.00 + (fcuttentLC - 3)*2.00;
                }
                
            } else {//无 type = 3 
                f_Current_LCFY = 15.00 + (fcuttentLC - 3)*2.00;
            }
            strLCFY = [NSString stringWithFormat:@"%.02f",f_Current_LCFY];
        }
            break;
        case 2:
        {
            float f_Current_LCFY = 0.00;
            float fcuttentLC = [m_strXSLC floatValue];
            //根据实际情况，它前面可能是从3->1->2,3->4->2
            if ([m_DicInfo objectForKey:@"3"] != nil) {//有 type = 3
                if ([m_DicInfo objectForKey:@"1"] != nil) { //有 1
                    float f_orign_LC_1 = [[m_DicInfo objectForKey:@"3"] floatValue];
                    float f_orign_LC_2 = [[m_DicInfo objectForKey:@"1"] floatValue];
                    if (f_orign_LC_1 > 3) {//f_orign_LC_1 > 3
                      f_Current_LCFY =  15.00 + (f_orign_LC_1 - 3)*4.00 + (f_orign_LC_2 - f_orign_LC_1)*2.00 + (fcuttentLC - f_orign_LC_2)*4.00;
                    } else {// < 3
                        f_Current_LCFY = 15.00 + (f_orign_LC_2 - 3)*2.00 + (fcuttentLC - f_orign_LC_2)*4.00;
                    }
                }
                if ([m_DicInfo objectForKey:@"4"] != nil) { //有 4
                    float f_orign_LC_1 = [[m_DicInfo objectForKey:@"3"] floatValue];
                    float f_orign_LC_2 = [[m_DicInfo objectForKey:@"4"] floatValue];
                    if (f_orign_LC_1 > 3) {//f_orign_LC_1 > 3
                        f_Current_LCFY =  15.00 + (f_orign_LC_1 - 3)*4.00 + (f_orign_LC_2 - f_orign_LC_1)*6.00 + (fcuttentLC - f_orign_LC_2)*4.00;
                    } else {// < 3
                        f_Current_LCFY = 15.00 + (f_orign_LC_2 - 3)*6.00 + (fcuttentLC - f_orign_LC_2)*4.00;
                    }
                }
            } else { //无 type = 3 肯定是1->2
                float f_orign_LC = [[m_DicInfo objectForKey:@"1"] floatValue];
                f_Current_LCFY = 15.00 + (f_orign_LC -3)*2.00 + (fcuttentLC - f_orign_LC)*4.00;
            }

            strLCFY = [NSString stringWithFormat:@"%.02f",f_Current_LCFY];
        }
            break;
        case 3:
        {
            float f_Current_LCFY = 0.00;
            float fcuttentLC = [m_strXSLC floatValue];
            //根据实际情况，它可能是从1->3
            
            if ([m_DicInfo objectForKey:@"1"] != nil) { //有 type = 1
                float f_orign_LC = [[m_DicInfo objectForKey:@"1"] floatValue];
                //根据实际情况，取type = 1时，有可能行驶里程 < 3
                if (f_orign_LC > 3) {//行驶里程 > 3
                    f_Current_LCFY = 15.00 + (f_orign_LC - 3)*2.00 + (fcuttentLC - f_orign_LC)*4.00;
                } else {//行驶里程 < 3
                    f_Current_LCFY = 15.00 + (fcuttentLC - 3)*4.00;
                }
                
            } else {//无 type = 1
                f_Current_LCFY = 15.00 + (fcuttentLC - 3)*4.00;
            }

            strLCFY = [NSString stringWithFormat:@"%.02f",f_Current_LCFY];
        }
            break;
        case 4:
        {
            float f_Current_LCFY = 0.00;
            float fcuttentLC = [m_strXSLC floatValue];
            //根据实际情况，它前面可能是从1->2->4,1->3->4
            if ([m_DicInfo objectForKey:@"1"] != nil) {//有 type = 1
                if ([m_DicInfo objectForKey:@"2"] != nil) { //1->2->4
                    float f_orign_LC_1 = [[m_DicInfo objectForKey:@"1"] floatValue];
                    float f_orign_LC_2 = [[m_DicInfo objectForKey:@"2"] floatValue];
                    //f_orign_LC_1 肯定 > 3
                    f_Current_LCFY =  15.00 + (f_orign_LC_1 - 3)*2.00 + (f_orign_LC_2 - f_orign_LC_1)*4.00 + (fcuttentLC - f_orign_LC_2)*6.00;
                   
                }
                if ([m_DicInfo objectForKey:@"3"] != nil) { ////1->3->4
                    float f_orign_LC_1 = [[m_DicInfo objectForKey:@"1"] floatValue];
                    float f_orign_LC_2 = [[m_DicInfo objectForKey:@"3"] floatValue];
                    if (f_orign_LC_1 > 3) {//f_orign_LC_1 > 3
                        f_Current_LCFY =  15.00 + (f_orign_LC_1 - 3)*2.00 + (f_orign_LC_2 - f_orign_LC_1)*4.00 + (fcuttentLC - f_orign_LC_2)*6.00;
                    } else {// < 3
                        f_Current_LCFY = 15.00 + (f_orign_LC_2 - 3)*4.00 + (fcuttentLC - f_orign_LC_2)*6.00;
                    }
                }
            } else { //无 type = 1 肯定是3->4
                float f_orign_LC = [[m_DicInfo objectForKey:@"3"] floatValue];
                f_Current_LCFY = 15.00 + (f_orign_LC -3)*4.00 + (fcuttentLC - f_orign_LC)*6.00;
            }
            
            strLCFY = [NSString stringWithFormat:@"%.02f",f_Current_LCFY];
        }
            break;
        default:
            break;
    }
    [lab_LCFY setText:strLCFY];
    }
    
}

- (void)calZJE
{
    //计算总金额
    float fZJE = 0.00;
    if ([[lab_DDFY text] floatValue] > 5.00) {
        fZJE = [[lab_LCFY text] floatValue] + [[lab_DDFY text] floatValue];
    } else {
        fZJE = [[lab_LCFY text] floatValue];
    }
    
    [lab_ZJE setText:[NSString stringWithFormat:@"%.02f",fZJE]];
    
    NSLog(@"------%f",fZJE);
}




//获取当前时间 + 根据当前时间判断目前的单价 红色高亮显示
-(void)doCal:(NSTimer *)_timer
{
    [self calLCFY];//计算里程费用
    [self calZJE]; //计算总金额
    
}

//秒表 更新
-(void)updateTimer
{
    if (isRunning == false) return;
    NSDate *currentDate = [NSDate date];
    timeInterval = [currentDate timeIntervalSinceDate:startDate];
    timeInterval += totalTimeInterval;
    NSDate *timerDate = [NSDate dateWithTimeIntervalSince1970:timeInterval];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"HH:mm:ss"];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0.0]];
    NSString *timeString=[dateFormatter stringFromDate:timerDate];
    NSArray *timeArr = [timeString componentsSeparatedByString:@":"];
    lab_DDSJ.text = [NSString stringWithFormat:@"%@:%@",[timeArr objectAtIndex:0],[timeArr objectAtIndex:1]];
    
    if (iMBCNT == 60) {
        iMBCNT = 0;
        NSArray *arr = [timeString componentsSeparatedByString:@":"];
        [lab_DDFY setText:[NSString stringWithFormat: @"%.02f",[[arr objectAtIndex:0] integerValue]*60+([[arr objectAtIndex:1] integerValue] +1)*1.00]];
    } 
    iMBCNT++;
        
}


- (NSString *)convertDateToSting:(NSDate *)_date
{
    NSDate *date= _date;
    NSDateFormatter *formater=[[NSDateFormatter alloc] init];
    formater.dateFormat=@"yyyy-MM-dd HH:mm:ss";  //HH大写代表24时制  hh代表12小时制
    NSString *strCurrentTM=[formater stringFromDate:date];
    formater.locale=[[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
    //把字符串变成日期
    //返回的是格林制时间
    date=[formater dateFromString:@"2013-05-16 13:40:50"];
    //NSLog(@"==========%@",strCurrentTM);
    return strCurrentTM;
}

-(void)seePricelist
{
    //PriceListVC *plvc = [[PriceListVC alloc] init];
    // [self.navigationController popToViewController:plvc animated:YES];
    [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:2] animated:YES];
    
}


#pragma mark
#pragma mark Buttons Method
//等待控制按钮
-(void)doPause
{
    NSLog(@"doPause");
    /*
    _thread = [NSThread getThread];
    [_thread initWithTarget:self selector:@selector(countT) object:nil];
    [_thread start];
    flag = TRUE;
     */
    
    if (isRunning == false)
    {
        isRunning = true;
        startDate = [NSDate date];
        [self doRefresh];
        [self setLabsText];//时时更新 labels
        if ([lab_DDSJ.text isEqualToString:@"00:00:00"]) {
            //将当前时间保存到字典
            [m_DicInfo setObject:[self convertDateToSting:startDate] forKey:STARTDATE];
        }
        timer_MB = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(updateTimer)userInfo:nil repeats:YES];
        [lab_CRT_Status setText:@"等待计时中..."];
        
        if (isCarMoving) {
            isCarMoving = false;
            isRunning = true;
            [btn_finish setBackgroundImage:[UIImage imageNamed:@"start"] forState:UIControlStateNormal];
            [btn_finish setEnabled:true];
            [btn_pause setBackgroundImage:[UIImage imageNamed:@"pause_disable"] forState:UIControlStateNormal];
            [btn_pause setEnabled:false];
        } else {
            [btn_start setBackgroundImage:[UIImage imageNamed:@"stop"] forState:UIControlStateNormal];
            [btn_start setEnabled:true];
            [btn_pause setBackgroundImage:[UIImage imageNamed:@"pause_disable"] forState:UIControlStateNormal];
            [btn_pause setEnabled:false];
        }
    }

    
}
//里程计费控制按钮
-(void)doStart
{
    [SharedObj sharedOBJ].startLocation = pl;
    [SharedObj sharedOBJ].starTime = [NSString stringWithFormat:@"%@",timer_CurrentTM];
    
    
    if (isCarMoving == false) {
        [locationManager startUpdatingLocation];
        [self doRefresh];
        [self setLabsText];//时时更新 labels
        isCarMoving = true;
        isServerOver = false;
        //开始计费，注册kvo观察者 观察 单价的类型改变
        [self addObserver:self forKeyPath:@"iDJType" options:NSKeyValueObservingOptionNew context:nil];
        //计算里程费用 + 设置总金额
        if ([lab_DDSJ.text isEqualToString:@"00:00:00"]) {
            startDate = [NSDate date];
            [m_DicInfo setObject:[self convertDateToSting:startDate] forKey:STARTDATE];
        } 
        if (isRunning) {
            //暂停计时器
            totalTimeInterval = timeInterval;
            isRunning = false;
            [btn_pause setBackgroundImage:[UIImage imageNamed:@"pause"] forState:UIControlStateNormal];
            [btn_pause setEnabled:true];
            
            [btn_finish setEnabled:false];
            [btn_finish setBackgroundImage:[UIImage imageNamed:@"start_disable"] forState:UIControlStateNormal];
        }
        [lab_CRT_Status setText:@"里程计费中..."];
        [btn_start setBackgroundImage:[UIImage imageNamed:@"stop"] forState:UIControlStateNormal];
        [btn_start setEnabled:true];
    } 
    
}

//代驾结束控制按钮
-(void)doFinish
{
    
    if (isServerOver == false) {
        if (![[lab_DDSJ text] isEqualToString:@"00:00:00"]) {
            [self doCal:nil];
            totalTimeInterval = timeInterval;
            isRunning = false;
            [btn_pause setEnabled:false];
        }
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"确定结束本次代驾???" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        
        [alert show];
    }
    else
    {
        //do刷新操作
//        [self refreshInfo];
//        isServerOver = false;
//        [btn_pause setEnabled:true];
//        [btn_finish setEnabled:true];
    }
    
 
}



- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
  
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"iDJType"]) {
        NSLog(@"---%@",[change objectForKey:@"new"]);
        [m_DicInfo setObject:lab_XSLC.text forKey:[change objectForKey:@"new"]];
     
    }
}
  


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    switch (buttonIndex) {
        case 0://取消
        {
            //秒表继续
            if (isRunning == false && isCarMoving == false) {
                totalTimeInterval = timeInterval;
                isRunning = false;
                [btn_pause setEnabled:true];
                [self doPause];
            }
            
        }
            break;
        case 1://确定 结束本次代驾
        {
            endDate = [NSDate date];
            [m_DicInfo setObject:lab_DDSJ.text forKey:WAITTIME];
            //[m_DicInfo setObject:[self convertDateToSting:startDate] forKey:STARTDATE];
            [m_DicInfo setObject:[self convertDateToSting:endDate] forKey:ENDDATE];
            [m_DicInfo setObject:lab_ZJE.text forKey:ZJE];
            NSLog(@"%@",m_DicInfo);
  
            //按钮设置
            
            /* 刷新
            [lab_DDSJ setText:@"00:00:00"];
            [lab_ZJE  setText:@"0.00"];
            [lab_LCFY setText:@"0.00"];
             */
            isCarMoving = false;
            isRunning = false;
            isServerOver = true;
            [btn_pause setEnabled:true];
            [btn_finish setEnabled:true];
                        
            //[btn_start setTitle:@"刷新" forState:UIControlStateNormal];
            //定时器关闭
            [timer_Refresh invalidate];
            [timer_CurrentTM invalidate];
            [timer_MB invalidate];
            
           
            //[self removeObserver:self forKeyPath:@"iDJType"];
            [lab_CRT_Status setText:@"本次代驾服务结束..."];
            
            popView = [[UIView alloc] initWithFrame:CGRectMake(0,50,320, 203)];
            UIImageView *popImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 203)];
            popImg.image = [UIImage imageNamed:@"SevFinPop"];
            [popView addSubview:popImg];
            [popView setBackgroundColor:[UIColor clearColor]];
            [self.view addSubview:popView];
            
            tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doHidePopView:)];
            tap.numberOfTouchesRequired = 1;
            tap.numberOfTapsRequired = 1;
            [popView addGestureRecognizer:tap];

            [SharedObj sharedOBJ].endLocation = pl;
            [SharedObj sharedOBJ].endTime = [NSString stringWithFormat:@"%@",timer_CurrentTM];
            
            //NSLog(@"%@-%@",[SharedObj sharedOBJ].endLocation,[SharedObj sharedOBJ].endTime);
            
//            sevFinPop = nil;
//            sevFinPop = [[SevFinPop alloc] initWithNibName:@"SevFinPop" bundle:nil];
//            sevFinPop.delegate = self;
//            [self presentPopupViewController:sevFinPop animationType:MJPopupViewAnimationFade];    
//            
            
        }
            break;
            
        default:
            break;
    }
    
    NSLog(@"clickedButtonAtIndex:%d",0);
    
    if (buttonIndex == 0) {
        
        
    }else if(alertView.tag==100 && buttonIndex ==1){
        
        [self.navigationController popViewControllerAnimated:YES];
        
    }else if(alertView.tag==101 && buttonIndex ==1){
        
        NSLog(@"Go Home......");
        [[NSNotificationCenter defaultCenter] postNotificationName:@"goHomeVC" object:nil];
    }

}

- (void)cancelButtonClicked:(SevFinPop *)aSecondDetailViewController
{
    //[self dismissPopupViewControllerWithanimationType:MJPopupViewAnimationFade];
    //sevFinPop = nil;
    //[sevFinPop removeFromParentViewController];
    isRunning = false;
    isCarMoving = false;
    isServerOver = false;
    [btn_pause setEnabled:true];
    [btn_start setEnabled:false];
    [btn_finish setEnabled:true];
    [lab_DDSJ setText:@"00:00"];
    [lab_ZJE  setText:@"0.00"];
    [lab_LCFY setText:@"0.00"];
}


- (void)doHidePopView:(UIGestureRecognizer *)sender
{
    [popView removeFromSuperview];
    isRunning = false;
    isCarMoving = false;
    isServerOver = false;
    [btn_pause setEnabled:true];
    [btn_start setEnabled:false];
    [btn_finish setEnabled:true];
    [lab_DDSJ setText:@"00:00"];
    [lab_ZJE  setText:@"0.00"];
    [lab_LCFY setText:@"0.00"];
}

- (void)creatViews
{
    //当前系统时间
    lab_CurrentTM = [[UILabel alloc] initWithFrame:CGRectMake(15, 4, 170, 50)];
    lab_CurrentTM.backgroundColor = [UIColor clearColor];
    [lab_CurrentTM setTextAlignment:NSTextAlignmentLeft];
    [lab_CurrentTM setTextColor:[UIColor redColor]];
    [lab_CurrentTM setFont:[UIFont fontWithName:@"Arial" size:20]];
    [lab_CurrentTM setFont:[UIFont fontWithName:@"DBLCDTempBlack" size:38.0]];
    //NSLog(@"%d : %d : %d",hour,min,sec);
    [lab_CurrentTM setTextColor:[UIColor orangeColor]];
    
    [self .view addSubview:lab_CurrentTM];
    UIImageView *nowImageView = [[UIImageView alloc]initWithFrame:CGRectMake(80, 15, 175, 50)];
    nowImageView.image = [UIImage imageNamed:@"nowBg"];
    [nowImageView addSubview:lab_CurrentTM];
    [self.view addSubview:nowImageView];
    UIImageView *nowTitil = [[UIImageView alloc]initWithFrame:CGRectMake(100, 67, 130, 13)];
    nowTitil.image = [UIImage imageNamed:@"sjwz"];
    [self.view addSubview:nowTitil];

    
    
    //总金额
    UIImageView *zjeImg = [[UIImageView alloc]initWithFrame:CGRectMake(10, 75, 45, 16)];
    zjeImg.image = [UIImage imageNamed:@"zje"];
    [self.view addSubview:zjeImg];
    //总金额计价器背景
    
    lab_ZJE = [[UILabel alloc] initWithFrame:CGRectMake(8, 6, 300, 80)];
    lab_ZJE.backgroundColor = [UIColor clearColor];
    [lab_ZJE setText:@"0.00"];
    [lab_ZJE setFont:[UIFont fontWithName:@"DBLCDTempBlack" size:77.0]];
    [lab_ZJE setTextAlignment:NSTextAlignmentLeft];
    [lab_ZJE setTextColor:[UIColor orangeColor]];
    
    UIImageView *zjeBgImg = [[UIImageView alloc]initWithFrame:CGRectMake(10, 95, 300, 80)];
    [zjeBgImg addSubview:lab_ZJE];
    zjeBgImg.image = [UIImage imageNamed:@"zjebg"];
    [self.view addSubview:zjeBgImg];
    

    
    
    
    
    
    //明细
    UIImageView *mxImageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 177, 31, 15)];
    mxImageView.image = [UIImage imageNamed:@"mingxi"];
    [self.view addSubview:mxImageView];
    
    
    //已驾驶
    UIImageView *yjsImageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 205, 37, 12)];
    yjsImageView.image = [UIImage imageNamed:@"yjs"];
    [self.view addSubview:yjsImageView];
    //路程
    UIImageView *yjsbgImageView = [[UIImageView alloc]initWithFrame:CGRectMake(50, 198, 100, 28)];
    yjsbgImageView.image = [UIImage imageNamed:@"xdbg"];
    lab_XSLC = [[UILabel alloc] initWithFrame:CGRectMake(5, 3, 80, 25)];
    lab_XSLC.backgroundColor = [UIColor clearColor];
    [lab_XSLC setText:@"0.00"];
    [lab_XSLC setFont:[UIFont fontWithName:@"DBLCDTempBlack" size:25.0]];
    [lab_XSLC setTextAlignment:NSTextAlignmentCenter];
    [lab_XSLC setTextColor:[UIColor orangeColor]];
    [yjsbgImageView addSubview:lab_XSLC];
    [self.view addSubview:yjsbgImageView];
    
/*
    lab_B_DJ1 = [[UILabel alloc] initWithFrame:CGRectMake(103, 110, 40, 30)];
    lab_B_DJ1.backgroundColor = [UIColor yellowColor];
    [lab_B_DJ1 setText:@"2.00"];
    [lab_B_DJ1 setTextAlignment:NSTextAlignmentLeft];
    [lab_B_DJ1 setTextColor:[UIColor blackColor]];
    [lab_B_DJ1 setFont:[UIFont fontWithName:@"Arial" size:20]];
//    [self .view addSubview:lab_B_DJ1];
    
    lab_B_DJ2 = [[UILabel alloc] initWithFrame:CGRectMake(158, 110, 40, 30)];
    lab_B_DJ2.backgroundColor = [UIColor yellowColor];
    [lab_B_DJ2 setText:@"4.00"];
    [lab_B_DJ2 setTextAlignment:NSTextAlignmentLeft];
    [lab_B_DJ2 setTextColor:[UIColor blackColor]];
    [lab_B_DJ2 setFont:[UIFont fontWithName:@"Arial" size:20]];
//    [self .view addSubview:lab_B_DJ2];
    
    lab_H_DJ1 = [[UILabel alloc] initWithFrame:CGRectMake(103, 150, 40, 30)];
    lab_H_DJ1.backgroundColor = [UIColor yellowColor];
    [lab_H_DJ1 setText:@"4.00"];
    [lab_H_DJ1 setTextAlignment:NSTextAlignmentLeft];
    [lab_H_DJ1 setTextColor:[UIColor blackColor]];
    [lab_H_DJ1 setFont:[UIFont fontWithName:@"Arial" size:20]];
//    [self .view addSubview:lab_H_DJ1];
    
    lab_H_DJ2 = [[UILabel alloc] initWithFrame:CGRectMake(158, 150, 40, 30)];
    lab_H_DJ2.backgroundColor = [UIColor yellowColor];
    [lab_H_DJ2 setText:@"6.00"];
    [lab_H_DJ2 setTextAlignment:NSTextAlignmentLeft];
    [lab_H_DJ2 setTextColor:[UIColor blackColor]];
    [lab_H_DJ2 setFont:[UIFont fontWithName:@"Arial" size:20]];
//    [self .view addSubview:lab_H_DJ2];
 */   
   //里程费
    UIImageView *lcfImageView = [[UIImageView alloc]initWithFrame:CGRectMake(165, 205, 37, 12)];
    lcfImageView.image = [UIImage imageNamed:@"lcf"];
    [self.view addSubview:lcfImageView];
    //路程
    UIImageView *lcfbgImageView = [[UIImageView alloc]initWithFrame:CGRectMake(205, 198, 100, 28)];
    lcfbgImageView.image = [UIImage imageNamed:@"xdbg"];
    lab_LCFY = [[UILabel alloc] initWithFrame:CGRectMake(5, 3, 90, 25)];
    lab_LCFY.backgroundColor = [UIColor clearColor];
    [lab_LCFY setText:@"0.00"];
    [lab_LCFY setFont:[UIFont fontWithName:@"DBLCDTempBlack" size:25.0]];
    [lab_LCFY setTextAlignment:NSTextAlignmentCenter];
    [lab_LCFY setTextColor:[UIColor orangeColor]];
    [lcfbgImageView addSubview:lab_LCFY];
    [self.view addSubview:lcfbgImageView];
    
    
    
    
  //等待时间
    //已等侯
    UIImageView *ddsjImageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 245, 37, 12)];
    ddsjImageView.image = [UIImage imageNamed:@"ydh"];
    [self.view addSubview:ddsjImageView];
    //时间
    UIImageView *ddsjbgImageView = [[UIImageView alloc]initWithFrame:CGRectMake(50, 238, 100, 28)];
    ddsjbgImageView.image = [UIImage imageNamed:@"xdbg"];
    lab_DDSJ = [[UILabel alloc] initWithFrame:CGRectMake(5, 3, 100, 25)];
    lab_DDSJ.backgroundColor = [UIColor clearColor];
    [lab_DDSJ setText:@"00:00"];
    [lab_DDSJ setFont:[UIFont fontWithName:@"DBLCDTempBlack" size:25.0]];
    [lab_DDSJ setTextAlignment:NSTextAlignmentCenter];
    [lab_DDSJ setTextColor:[UIColor orangeColor]];
    [ddsjbgImageView addSubview:lab_DDSJ];
    [self.view addSubview:ddsjbgImageView];
    
    //等侯费
    UIImageView *dhfImageView = [[UIImageView alloc]initWithFrame:CGRectMake(165, 245, 37, 12)];
    dhfImageView.image = [UIImage imageNamed:@"dhf"];
    [self.view addSubview:dhfImageView];
    //费用
    UIImageView *dhfbgImageView = [[UIImageView alloc]initWithFrame:CGRectMake(205, 238, 100, 28)];
    dhfbgImageView.image = [UIImage imageNamed:@"xdbg"];
    lab_DDFY = [[UILabel alloc] initWithFrame:CGRectMake(5, 3, 90, 25)];
    lab_DDFY.backgroundColor = [UIColor clearColor];
    [lab_DDFY setText:@"0.00"];
    [lab_DDFY setFont:[UIFont fontWithName:@"DBLCDTempBlack" size:25.0]];
    [lab_DDFY setTextAlignment:NSTextAlignmentCenter];
    [lab_DDFY setTextColor:[UIColor orangeColor]];
    [dhfbgImageView addSubview:lab_DDFY];
    [self.view addSubview:dhfbgImageView];
    //执行
    UIImageView *zxImageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 275, 33, 17)];
    zxImageView.image = [UIImage imageNamed:@"zx"];
    [self.view addSubview:zxImageView];
    //里程单价背景
    UIImageView *lcbgImageView = [[UIImageView alloc]initWithFrame:CGRectMake(20, 300, 60, 60)];
    lcbgImageView.image = [UIImage imageNamed:@"lc"];
    
    lab_SJD_B = [[UILabel alloc] initWithFrame:CGRectMake(0, 17, 40, 40)];
    lab_SJD_B.backgroundColor = [UIColor clearColor];
    [lab_SJD_B setTextAlignment:NSTextAlignmentCenter];
    [lab_SJD_B setText:@"2"];
    [lab_SJD_B setFont:[UIFont fontWithName:@"DBLCDTempBlack" size:25.0]];
    [lab_SJD_B setTextAlignment:NSTextAlignmentCenter];
    [lab_SJD_B setTextColor:[UIColor orangeColor]];
    [lcbgImageView addSubview:lab_SJD_B];
    
    
    
    
    [self.view addSubview:lcbgImageView];
    
    //等侯单价背景
    UIImageView *dhbgImageView = [[UIImageView alloc]initWithFrame:CGRectMake(120, 300, 60, 60)];
    dhbgImageView.image = [UIImage imageNamed:@"dh"];
    
   UILabel *dhdjlab = [[UILabel alloc] initWithFrame:CGRectMake(0, 18, 40, 40)];
    dhdjlab.backgroundColor = [UIColor clearColor];
    [dhdjlab setTextAlignment:NSTextAlignmentCenter];
    [dhdjlab setText:@"1"];
    [dhdjlab setFont:[UIFont fontWithName:@"DBLCDTempBlack" size:25.0]];
    [dhdjlab setTextAlignment:NSTextAlignmentCenter];
    [dhdjlab setTextColor:[UIColor orangeColor]];
    [dhbgImageView addSubview:dhdjlab];
    [self.view addSubview:dhbgImageView];
    
    
    //时段背景
    UIImageView *sdbgImageView = [[UIImageView alloc]initWithFrame:CGRectMake(220, 300, 60, 60)];
    sdbgImageView.image = [UIImage imageNamed:@"sd"];
    
    
    lab_SJD_H = [[UILabel alloc] initWithFrame:CGRectMake(10, 18, 40, 40)];
    lab_SJD_H.backgroundColor = [UIColor clearColor];
    [lab_SJD_H setTextAlignment:NSTextAlignmentCenter];
//    [lab_SJD_H setText:@"夜"];
    [lab_SJD_H setFont:[UIFont fontWithName:@"DBLCDTempBlack" size:20.0]];
    [lab_SJD_H setTextAlignment:NSTextAlignmentCenter];
    [lab_SJD_H setTextColor:[UIColor orangeColor]];
    [sdbgImageView addSubview:lab_SJD_H];
    
    
    [self.view addSubview:sdbgImageView];
    
    
    lab_CRT_Status = [[UILabel alloc] initWithFrame:CGRectMake(40, 275, 220, 40)];
    lab_CRT_Status.backgroundColor = [UIColor yellowColor];
    [lab_CRT_Status setTextAlignment:NSTextAlignmentCenter];
    [lab_CRT_Status setTextColor:[UIColor grayColor]];
    [lab_CRT_Status setText:@"本次服务尚未启动..."];
    [lab_CRT_Status setFont:[UIFont fontWithName:@"Arial" size:20]];
//    [self .view addSubview:lab_CRT_Status];
}

-(void)loadbody
{
//    self.counterbg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 272.5)];
//    self.counterbg.image = [UIImage imageNamed:@"counter2"];
//    [self.view addSubview:self.counterbg];
    
    //    UIButton *btn_toCounter = [UIButton buttonWithType:UIButtonTypeCustom];
    //    btn_toCounter.frame = CGRectMake(0, self.view.frame.size.height-88, 320, 44);
    //    btn_toCounter.backgroundColor = [UIColor colorWithRed:0.0/255.0 green:130.0/255.0 blue:210.0/255.0 alpha:1];
    //    [btn_toCounter setTitle:@"收费标准" forState:UIControlStateNormal];
    //    [btn_toCounter addTarget:self action:@selector(seePricelist)forControlEvents:UIControlEventTouchUpInside];
    //    [self.view addSubview:btn_toCounter];
    UIImageView *BottomView = [[UIImageView alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height-94, self.view.frame.size.width, 60)];
    BottomView.backgroundColor = [UIColor blackColor];
    BottomView.userInteractionEnabled = YES;
    
//    BottomView.image = [UIImage imageNamed:@"navbg"];
    
    //开始记时
    btn_pause = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    btn_pause.frame = CGRectMake(20, 10, 18, 28);
    [btn_pause setBackgroundImage:[UIImage imageNamed:@"pause"]  forState:UIControlStateNormal];
    [btn_pause addTarget:self action:@selector(doPause)forControlEvents:UIControlEventTouchUpInside];
    [BottomView addSubview:btn_pause];

    //开始计算
    btn_finish = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    btn_finish.frame = CGRectMake(150, 10, 20, 26);
    [btn_finish setBackgroundImage:[UIImage imageNamed:@"start"]  forState:UIControlStateNormal];
    [btn_finish addTarget:self action:@selector(doStart)forControlEvents:UIControlEventTouchUpInside];
    [BottomView addSubview:btn_finish];
    
    
//退出  
    btn_start = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    btn_start.frame=CGRectMake(280, 10, 25, 26);
    [btn_start setBackgroundImage:[UIImage imageNamed:@"stop"]  forState:UIControlStateNormal];
    [btn_start addTarget:self action:@selector(doFinish)forControlEvents:UIControlEventTouchUpInside];
    [btn_start setEnabled:false];
    [BottomView addSubview:btn_start];
    [self.view addSubview:BottomView];
}


/*
#pragma mark - 暂时没用

//多线程调用
int i=0;
int j =0,k=0,l=0;
BOOL flag = TRUE;
-(void)countT
{
    while(flag)
    {
        [self performSelectorOnMainThread:@selector(clockMoving) withObject:nil waitUntilDone:YES];
        [NSThread sleepForTimeInterval:0.01];//休眠0.01秒
    }
}
-(void)clockMoving
{
    j++;
    if (j==60) {
        j = 0;
        k++;
    }
    if (k == 60) {
        l++;
        k=0;
    }
    NSString *str = [NSString stringWithFormat:@"%i:%i:%i",l,k,j];
    NSLog(@"%@",str);
    
    lab_DDSJ.text = str;
    
}*/
@end


