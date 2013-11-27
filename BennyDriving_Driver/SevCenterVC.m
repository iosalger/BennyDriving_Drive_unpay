//
//  SevCenterVC.m
//  BennyDriving_Driver
//
//  Created by BennyDriving on 8/19/13.
//  Copyright (c) 2013 BennyDriving. All rights reserved.
//

#import "SevCenterVC.h"
#import "InfoCentreVC.h"
#import "HelpVC.h"
#import "AdvServiceVC.h"
#import "HelpEachVC.h"
#import "CurrentOrdered.h"
#import "OrderListVC.h"
#import "AccountVC.h"
#import "DriRateVC.h"
#import "DriProfileVC.h"
#import "StoreRateVC.h"
#import "SharedObj.h"
#import "CounterVC.h"
#import "CounterActionVC.h"
#import "PriceListVC.h"
#import "MobileMallVC.h"
#import <QuartzCore/QuartzCore.h>

#import "ASIHttpHeaders.h"
#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"

#import "JSONKit.h"
#import "tooles.h"
#import "MBProgressHUD.h"

@interface SevCenterVC ()

@end

@implementation SevCenterVC

@synthesize on;

@synthesize btn_OrderList,btn_help,btn_Reservison,btn_helpEachother,btn_advancedService,btn_infoCentre,btn_account,btn_profile,btn_MoMall,dialNum;
@synthesize switchCtl,SevStatus;
@synthesize button = _button;
@synthesize btn_rUnfold,btn_rFold,btn_lFold,btn_lUnfold;
@synthesize pushView,SevNumber,LeftMenu,RightMenu,Homepic;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
//        self.navigationItem.title = @"服务中心";
        self.view.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated
{
    
    self.navigationController.navigationBarHidden = NO;
    
    if ([CLLocationManager locationServicesEnabled]) { // 检查定位服务是否可用
        locationManager = [[CLLocationManager alloc] init];
        locationManager.delegate = self;
        locationManager.distanceFilter=1000;
        locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        
        [locationManager startUpdatingLocation]; // 开始定位
    }
    
    
    [SevStatus removeFromSuperview];
    
    SevStatus = [[UILabel alloc] initWithFrame:CGRectMake(200, 310, 200, 40)];
    if ([SharedObj sharedOBJ].switchon==0)
    {
        
        SevStatus.text = @"服务已关闭";
        SevStatus.backgroundColor = [UIColor clearColor];
        SevStatus.textColor =[UIColor whiteColor];
        
//        NSLog(@"服务已关闭");
//        
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"开启服务，让用户在地图上看见我！"
//                                                       delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
//        [alert show];
        //NSLog(@"访问BBS,请先登陆......");

        
    }else if([SharedObj sharedOBJ].switchon==1)
    {
        SevStatus.text = @"服务已开启";
        SevStatus.backgroundColor = [UIColor clearColor];
        SevStatus.textColor =[UIColor whiteColor];
       // NSLog(@"服务已开启，传输经纬度");
    }
    [self.view addSubview:SevStatus];

}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
//    self.navigationController.navigationBar.titleTextAttributes
//    = @{UITextAttributeFont: [UIFont fontWithName:@"Arial" size:12.0],UITextAttributeTextColor: [UIColor whiteColor]};
    [self.navigationItem setTitle:@"服务中心"];
    
    
//    UIImage *HomeBtnImg = [UIImage imageNamed:@"btn_home.png"];
//    
//    UIButton *homeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    homeBtn.frame = CGRectMake(0, 0, 44, 44);
//    [homeBtn addTarget:self action:@selector(handleHome) forControlEvents:UIControlEventTouchUpInside];
//    
//    [homeBtn setImage:HomeBtnImg forState:UIControlStateNormal];
//    UIBarButtonItem *homeButton = [[UIBarButtonItem alloc] initWithCustomView:homeBtn];
    
    

//    UIBarButtonItem *gohelp = [[UIBarButtonItem alloc] initWithTitle:@"帮助"                                                                      style:UIBarButtonItemStylePlain target:self action:@selector(gohelp)];
    
    UIImage *HelpBtnImg = [UIImage imageNamed:@"btn_help.png"];
    
    UIButton *helpBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    helpBtn.frame = CGRectMake(0, 5, 45, 45);
    [helpBtn addTarget:self action:@selector(gohelp) forControlEvents:UIControlEventTouchUpInside];
    
    [helpBtn setImage:HelpBtnImg forState:UIControlStateNormal];
    UIBarButtonItem *gohelp = [[UIBarButtonItem alloc] initWithCustomView:helpBtn];
    //NSArray *rightBtnArr = [NSArray arrayWithObjects:homeButton,gohelp, nil];
    
    self.navigationItem.rightBarButtonItem = gohelp;
    
//    self.navigationItem.title = @"服务中心";
    
//    UIImage *topBarImg = [UIImage imageNamed:@"bottombar_bg_opq"];
////    self.navigationController.navigationBar set
//    [self.navigationController.navigationBar setBackgroundImage:topBarImg forBarMetrics:UIBarMetricsDefault];
    
    Homepic = [[UIImageView alloc] init];
    Homepic.frame = CGRectMake(0, 0, 320, 480);
    Homepic.image = [UIImage imageNamed:@"homebg.png"];
    [self.view addSubview:Homepic];
    
    //创建左侧按钮
    [self setBackLeftBarButtonItem];
        
    [self loadButtons];
    
    switchCtl = [[UISwitch alloc] initWithFrame:CGRectMake(200, 285, 100, 40)];
    [switchCtl addTarget:self action:@selector(switchAction:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:switchCtl];

    
    [super loadBottomBar];
}

- (void)setBackLeftBarButtonItem{
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(0, 0, 44, 44);
    
    [backBtn setImage:[UIImage imageNamed:@"btn_back.png"] forState:UIControlStateNormal];
    [backBtn setImage:[UIImage imageNamed:@"btn_back_tapped.png"] forState:UIControlStateHighlighted];
    
    [backBtn addTarget:self action:@selector(doBack:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    self.navigationItem.leftBarButtonItem = backItem;
    
    
}


#pragma mark -
#pragma mark  导航按钮事件处理
-(void)doBack:(UIButton *)bt
{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}




-(void)loadButtons
{
    //Orders
    self.btn_OrderList = [UIButton buttonWithType:UIButtonTypeCustom];
    self.btn_OrderList.frame = CGRectMake(20, 20,140, 160);
    //[self.btn_OrderList setTitle:@"抢单池" forState:UIControlStateNormal];
    [self.btn_OrderList setBackgroundImage:[UIImage imageNamed:@"orders"] forState:UIControlStateNormal];
    [self.btn_OrderList setAlpha:0.8];
    //self.btn_infoCentre.titleLabel.textColor = [UIColor colorWithRed:50.0/255.0 green:100.0/255.0 blue:50.0/255.0 alpha:1];
    [self.btn_OrderList addTarget:self action:@selector(getOrderList)forControlEvents:UIControlEventTouchUpInside];
    self.btn_OrderList.backgroundColor = [UIColor colorWithRed:50.0/255.0 green:160.0/255.0 blue:80.0/255.0 alpha:1];
    [self.view addSubview:self.btn_OrderList];
    
    //Reservation Records
    self.btn_Reservison = [UIButton buttonWithType:UIButtonTypeCustom];
    self.btn_Reservison.frame = CGRectMake(165,20,140,80);
    //[self.btn_Reservison setTitle:@"预约记录" forState:UIControlStateNormal];
    [self.btn_Reservison setBackgroundImage:[UIImage imageNamed:@"resvRec"] forState:UIControlStateNormal];
    [self.btn_Reservison setAlpha:0.8];
    //self.btn_Reservison.backgroundColor = [UIColor colorWithRed:50.0/255.0 green:160.0/255.0 blue:80.0/255.0 alpha:1];
    [self.btn_Reservison addTarget:self action:@selector(getReserRecords)forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.btn_Reservison];
    
    //Help eachother
    self.btn_helpEachother = [UIButton buttonWithType:UIButtonTypeCustom];
    self.btn_helpEachother.frame = CGRectMake(20, 270, 140, 80);
    //[self.btn_helpEachother setTitle:@"帮帮忙" forState:UIControlStateNormal];
    [self.btn_helpEachother setBackgroundImage:[UIImage imageNamed:@"helpeach"] forState:UIControlStateNormal];    [self.btn_helpEachother addTarget:self action:@selector(gohelpEach)forControlEvents:UIControlEventTouchUpInside];
    [self.btn_helpEachother setAlpha:0.8];
    //self.btn_helpEachother.backgroundColor = [UIColor colorWithRed:50.0/255.0 green:160.0/255.0 blue:80.0/255.0 alpha:1];
    [self.view addSubview:self.btn_helpEachother];
    
    //Advanced Service
    self.btn_advancedService = [UIButton buttonWithType:UIButtonTypeCustom];
    self.btn_advancedService.frame = CGRectMake(165, 105, 140, 160);
    //[self.btn_advancedService setTitle:@"高级服务" forState:UIControlStateNormal];
    [self.btn_advancedService setBackgroundImage:[UIImage imageNamed:@"advSev"] forState:UIControlStateNormal];    
    //self.btn_advancedService.backgroundColor = [UIColor colorWithRed:50.0/255.0 green:160.0/255.0 blue:80.0/255.0 alpha:1];
    [self.btn_advancedService setAlpha:0.8];
    [self.btn_advancedService addTarget:self action:@selector(goAdvancedService)forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.btn_advancedService];

    //Info Centre
    self.btn_infoCentre = [UIButton buttonWithType:UIButtonTypeCustom];
    self.btn_infoCentre.frame = CGRectMake(165, 270, 140, 80);
    //[self.btn_infoCentre setTitle:@"信息中心" forState:UIControlStateNormal];
    //self.btn_infoCentre.titleLabel.textColor = [UIColor colorWithRed:50.0/255.0 green:100.0/255.0 blue:50.0/255.0 alpha:1];
    [self.btn_infoCentre setAlpha:0.8];
    [self.btn_infoCentre addTarget:self action:@selector(goInfoCentre)forControlEvents:UIControlEventTouchUpInside];
    [self.btn_infoCentre setBackgroundImage:[UIImage imageNamed:@"switch"] forState:UIControlStateNormal];    
    self.btn_infoCentre.backgroundColor = [UIColor colorWithRed:50.0/255.0 green:160.0/255.0 blue:80.0/255.0 alpha:1];
    [self.view addSubview:self.btn_infoCentre];
    
//    //See Profile
//    self.btn_profile = [UIButton buttonWithType:UIButtonTypeCustom];
//    self.btn_profile.frame = CGRectMake(30, 210, 120, 50);
//    [self.btn_profile setTitle:@"个人资料" forState:UIControlStateNormal];
//    self.btn_profile.backgroundColor = [UIColor colorWithRed:50.0/255.0 green:160.0/255.0 blue:80.0/255.0 alpha:1];
//    [self.btn_profile addTarget:self action:@selector(seeDriProfile)forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:self.btn_profile];
//    
//    //See Account
//    self.btn_account = [UIButton buttonWithType:UIButtonTypeCustom];
//    self.btn_account.frame = CGRectMake(160, 210, 120, 50);
//    [self.btn_account setTitle:@"个人账户" forState:UIControlStateNormal];
//    self.btn_account.backgroundColor = [UIColor colorWithRed:50.0/255.0 green:160.0/255.0 blue:80.0/255.0 alpha:1];
//    [self.btn_account addTarget:self action:@selector(seeAccount)forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:self.btn_account];

    //See DriRate
    self.btn_MoMall = [UIButton buttonWithType:UIButtonTypeCustom];
    self.btn_MoMall.frame = CGRectMake(20, 185, 140, 80);
    //[self.btn_MoMall setTitle:@"手机商城" forState:UIControlStateNormal];
    [self.btn_MoMall setBackgroundImage:[UIImage imageNamed:@"momall"] forState:UIControlStateNormal]; 
    //self.btn_infoCentre.titleLabel.textColor = [UIColor colorWithRed:50.0/255.0 green:100.0/255.0 blue:50.0/255.0 alpha:1];
    [self.btn_MoMall setAlpha:0.8];
    [self.btn_MoMall addTarget:self action:@selector(goMoMall)forControlEvents:UIControlEventTouchUpInside];
    self.btn_MoMall.backgroundColor = [UIColor colorWithRed:50.0/255.0 green:160.0/255.0 blue:80.0/255.0 alpha:1];
    [self.view addSubview:self.btn_MoMall];

}

#pragma mark
#pragma mark Load Buttons
-(void)getOrderList
{
    OrderListVC *ol = [[OrderListVC alloc] init];
    [self.navigationController pushViewController:ol animated:YES];

}

-(void)getReserRecords
{

    CurrentOrdered *curod = [[CurrentOrdered alloc] init];
    [self.navigationController pushViewController:curod animated:YES];
}

-(void)gohelpEach
{

    HelpEachVC *helpeach = [[HelpEachVC alloc] init];
    [self.navigationController pushViewController:helpeach animated:YES];
}

-(void)goInfoCentre
{
    
}

-(void)goAdvancedService
{
    AdvServiceVC *advser = [[AdvServiceVC alloc] init];
    [self.navigationController pushViewController:advser animated:YES];

}

-(void)goMoMall
{
    MobileMallVC *momall = [[MobileMallVC alloc] init];
    [self.navigationController pushViewController:momall animated:YES];
    
}

-(void)seeDriProfile
{
    DriProfileVC *rate = [[DriProfileVC alloc] init];
    [self.navigationController pushViewController:rate animated:YES];
}

-(void)seeAccount
{
    AccountVC *AcVC = [[AccountVC alloc] init];
    [self.navigationController pushViewController:AcVC animated:YES];

}

-(void)seeDriRate
{
    DriRateVC *drirate = [[DriRateVC alloc] init];
    [self.navigationController pushViewController:drirate animated:YES];

}

- (void)switchAction:(id)sender
{
    switchCtl = (UISwitch *)sender;
    
    if (switchCtl.isOn==0) {
        
        SevStatus.text = @"服务已关闭";
        //http://abc.4008200972.com/benny_driving/servlet/LocationShareServlet?action=dri-qxdwgx&driid=58
        NSString *URLString = [NSString stringWithFormat:@"http://abc.4008200972.com/benny_driving/servlet/LocationShareServlet"];
        NSURL *url = [NSURL URLWithString:URLString];
        //ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
        //[request addRequestHeader:@"Referer" value:@"http://www.dreamingwish.com/"];
        
        ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
        [request setPostValue:@"dri-qxdwgx" forKey:@"action"];
//        [request setPostValue:[NSString stringWithFormat:@"%f",[SharedObj sharedOBJ].driLog] forKey:@"log"];
//        [request setPostValue:[NSString stringWithFormat:@"%f",[SharedObj sharedOBJ].driLat] forKey:@"lat"];
        [request setPostValue:[SharedObj sharedOBJ].logindriid forKey:@"driid"];
        [request setDelegate:self];
        [request setDidFinishSelector:@selector(GetResult:)];
        [request setDidFailSelector:@selector(GetErr:)];
        
        [request startAsynchronous];

        
        
    }else if(switchCtl.isOn==1)
    {
        SevStatus.text = @"服务已开启";
         NSLog(@"服务已开启，传输经纬度");
        //static NSString * const SwitchOn = NSString  @"http://abc.4008200972.com/benny_driving/servlet/LocationShareServlet?action=dri-dwgx&log=141.123400&lat=22.123400&driid=52";
        NSString *URLString = [NSString stringWithFormat:@"http://abc.4008200972.com/benny_driving/servlet/LocationShareServlet"];
        NSURL *url = [NSURL URLWithString:URLString];
        //ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
        //[request addRequestHeader:@"Referer" value:@"http://www.dreamingwish.com/"];
        
        ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
        [request setPostValue:@"dri-dwgx" forKey:@"action"];
        [request setPostValue:[NSString stringWithFormat:@"%f",[SharedObj sharedOBJ].driLog] forKey:@"log"];
        [request setPostValue:[NSString stringWithFormat:@"%f",[SharedObj sharedOBJ].driLat] forKey:@"lat"];
        [request setPostValue:[SharedObj sharedOBJ].logindriid forKey:@"driid"];
        [request setDelegate:self];
        [request setDidFinishSelector:@selector(GetResult:)];
        [request setDidFailSelector:@selector(GetErr:)];
        
        [request startAsynchronous];
        
        
    }
    
    //NSLog(@"switchAction: value = %d", [sender isOn]);
    [SharedObj sharedOBJ].switchon = [sender isOn];
  
       
}

//获取请求结果
- (void)GetResult:(ASIHTTPRequest *)request{
    //接收字符串数据
    //NSString *str = request.data;
    //NSData *data = request.responseData;
    //NSString *str = [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
    //NSData *data = request.responseData;
    //NSString *str = [request responseString];
    //NSLog(@"%@",str);
    NSString *JSONString = request.responseString;
    //fetchInfodic = [JSONString objectFromJSONString];
    NSLog(@"%@",JSONString);
    //NSLog(@"%@",fetchInfodic);
    
    //接收二进制数据
    //NSData *data = [request responseData];
}

//连接错误调用这个函数
- (void) GetErr:(ASIHTTPRequest *)request{  
    
    [tooles removeHUD];  
    
    [tooles MsgBox:@"网络错误,连接不到服务器"];  
}  


#pragma mark
#pragma mark NavigationBar Right Buttons

-(void)handleHome
{
    NSLog(@"Go Home......");
    [[NSNotificationCenter defaultCenter] postNotificationName:@"goHomeVC" object:nil];
    
}

-(void)gohelp
{
    HelpVC *dri = [[HelpVC alloc] init];
    [self.navigationController pushViewController:dri animated:YES];
    
}


-(void)shareAction{
    
    NSString *textToShare = @"我正在使用";
    UIImage *imageToShare = [UIImage imageNamed:@"icon@2x.png"];
    NSURL *urlToShare = [NSURL URLWithString:@"http://www.4008200972.com"];
    NSArray *activityItems = [NSArray arrayWithObjects:textToShare,imageToShare,urlToShare,nil];
    
    UIActivityViewController *activityVC = [[UIActivityViewController alloc]initWithActivityItems:activityItems applicationActivities:nil];
    //不出现在活动项目
    activityVC.excludedActivityTypes = [NSArray arrayWithObjects: UIActivityTypePrint, UIActivityTypeCopyToPasteboard,
                                        UIActivityTypeAssignToContact,UIActivityTypeSaveToCameraRoll,nil];
    [self presentViewController:activityVC animated:TRUE completion:nil];
    
}

-(void)storeRate
{
    
    StoreRateVC *storeRate = [[StoreRateVC alloc] init];
    [self.navigationController pushViewController:storeRate animated:YES];

}

-(void)seePriceList
{
    PriceListVC *plv = [[PriceListVC alloc] init];
    [self.navigationController pushViewController:plv animated:YES];
}

-(void)goManage
{
   
    CounterActionVC *ca = [[CounterActionVC alloc] init];
    [self.navigationController pushViewController:ca animated:YES];
    
    
}

-(void)dialSerNum
{
    // open a dialog with an OK and cancel button
	UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"拨打服务热线"
                                                             delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:@"4008200972" otherButtonTitles:nil];
	actionSheet.actionSheetStyle = UIActionSheetStyleDefault;
	[actionSheet showInView:self.view]; // show from our table view (pops up in the middle of the table)
	
}

#pragma mark -
#pragma mark - UIActionSheetDelegate

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
	// the user clicked one of the OK/Cancel buttons
	if (buttonIndex == 0)
	{
		NSLog(@"ok");
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"tel://4008200972"]];
	}
	else
	{
		NSLog(@"cancel");
	}
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSLog(@"clickedButtonAtIndex:%d",0);
    //switchCtl.isOn = 1;
    
    if ([CLLocationManager locationServicesEnabled]) { // 检查定位服务是否可用
        locationManager = [[CLLocationManager alloc] init];
        locationManager.delegate = self;
        locationManager.distanceFilter=1000;
        locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        
        [locationManager startUpdatingLocation]; // 开始定位
    }
    
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"定位出错");
}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    [manager stopUpdatingLocation];
    
    NSLog(@"%f,%f",newLocation.coordinate.latitude,newLocation.coordinate.longitude);
    coordinate.latitude = newLocation.coordinate.latitude;
    coordinate.longitude = newLocation.coordinate.longitude;
    [SharedObj sharedOBJ].driLat = coordinate.latitude;
    [SharedObj sharedOBJ].driLog = coordinate.longitude;
    
    NSLog(@"%f,%f",newLocation.coordinate.latitude,newLocation.coordinate.longitude);
    //MKCoordinateSpan span = _mapView.region.span;
    //MKCoordinateRegion region;
    //region.span = span;
    //region.center = _mapView.userLocation.location.coordinate;
    
    //设置显示范围
    //region = MKCoordinateRegionMakeWithDistance(coordinate,10000,10000);
    //[_mapView setRegion:region animated:TRUE];
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
