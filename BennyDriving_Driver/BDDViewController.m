//
//  BDDViewController.m
//  BennyDriving_Driver
//
//  Created by BennyDriving on 8/19/13.
//  Copyright (c) 2013 BennyDriving. All rights reserved.
//

#import "BDDViewController.h"
#import "LoginVC.h"
#import "StoreRateVC.h"
#import "CounterActionVC.h"
#import "PriceListVC.h"
#import "DriProfileVC.h"
#import <QuartzCore/QuartzCore.h>
#import "SevCenterVC.h"
#import "AccountVC.h"
#import "DriRateVC.h"
#import "SharedObj.h"
#import "JSONKit.h"

@interface BDDViewController ()
{
    DriMapVC *_mapViewController;
}

@end

@implementation BDDViewController

//@synthesize mapView, annotationArray;
@synthesize btn_serNumber,pic_serNumber,SerNum,dialNum;
@synthesize button = _button;
@synthesize Refresh,Location,SerCentre;
@synthesize btn_rUnfold,btn_rFold,btn_lFold,btn_lUnfold;
@synthesize pushView,SevNumber,LeftMenu,RightMenu;
@synthesize mapView=_mapView;
//@synthesize delegate;

- (void)dealloc
{
    [_mapView release];
    [super dealloc];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

-(void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBarHidden = YES;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"Map";
    //self.view.backgroundColor = [UIColor blackColor];
    
//    self.navigationController.navigationBar.titleTextAttributes
//    = @{UITextAttributeFont: [UIFont fontWithName:@"Arial" size:18.0],UITextAttributeTextColor: [UIColor whiteColor]};
    
    if ([CLLocationManager locationServicesEnabled])
    {
        locationManager = [[CLLocationManager alloc] init];
        [locationManager setDelegate:self];
        locationManager.distanceFilter = 1000;
        locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        [locationManager startUpdatingLocation];
    }
    
    
    
    NSDictionary *dic1=[NSDictionary dictionaryWithObjectsAndKeys:@"31.241843",@"latitude",@"121.459393",@"longitude",nil];
    
    NSDictionary *dic2=[NSDictionary dictionaryWithObjectsAndKeys:@"31.260144",@"latitude",@"121.473696‎",@"longitude",nil];
    
    NSDictionary *dic3=[NSDictionary dictionaryWithObjectsAndKeys:@"31.248076",@"latitude",@"121.520162‎",@"longitude",nil];
    
    NSDictionary *dic4=[NSDictionary dictionaryWithObjectsAndKeys:@"31.295622",@"latitude",@"121.400605",@"longitude",nil];
    
    NSDictionary *dic5=[NSDictionary dictionaryWithObjectsAndKeys:@"31.325622",@"latitude",@"121.380605",@"longitude",nil];
    
    NSDictionary *dic6=[NSDictionary dictionaryWithObjectsAndKeys:@"31.335622",@"latitude",@"121.480605",@"longitude",nil];
    
    NSArray *array = [NSArray arrayWithObjects:dic1,dic2,dic3,dic4,dic5,dic6, nil];
    
	_mapViewController = [[DriMapVC alloc] initWithNibName:@"DriMapVC" bundle:nil];
    _mapViewController.delegate = self;
   [self.navigationController pushViewController:_mapViewController animated:YES];
   [self.view addSubview:_mapViewController.view];
   [_mapViewController.view setFrame:self.view.bounds];
   [_mapViewController resetAnnitations:array];
    
    
    //self.mapView.delegate = self;
    //_mapView.delegate = self;
	// 是否显示当前位置
    //self.mapView.showsUserLocation = YES;
    //_mapView.showsUserLocation = YES;
    //self.annotationArray = [[NSMutableArray alloc] init];
    //[_mapView resetAnnitations:array];
    
    //_annotationList = [[NSMutableArray alloc] init];
    
    UIImage *topBarImg = [UIImage imageNamed:@"topbar_bg_opq"];
    //    self.navigationController.navigationBar set
    
    [self.navigationController.navigationBar setBackgroundImage:topBarImg forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setTintColor:[UIColor clearColor]];
    [self.navigationController.navigationBar setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"homebg"]]];
    
    
    //[super loadBottomBar];
    
}

- (void)customMKMapViewDidSelectedWithInfo:(id)info
{
    NSLog(@"%@",info);
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



- (IBAction)Location:(id)sender {
    if ([CLLocationManager locationServicesEnabled]) { // 检查定位服务是否可用
        locationManager = [[CLLocationManager alloc] init];
        locationManager.delegate = self;
        locationManager.distanceFilter=1000;
        locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        [locationManager startUpdatingLocation]; // 开始定位
    }
    
    MKCoordinateSpan span = _mapView.region.span;
    
    MKCoordinateRegion region;
    region.span = span;
    region.center = _mapView.userLocation.location.coordinate;
    
    [self.mapView setRegion:region animated:YES];
    
    NSLog(@"GPS 启动");
    
}

#pragma mark - ButtonAction

- (IBAction)goSevCentre:(id)sender
{
    if([[SharedObj sharedOBJ].logindriid isEqualToString:@""])
    {
    LoginVC *login = [[LoginVC alloc] init];
    [self.navigationController pushViewController:login animated:YES];
    }else if(![[SharedObj sharedOBJ].logindriid isEqualToString:@""])
    {
      SevCenterVC *scVC = [[SevCenterVC alloc] init];
      [self.navigationController pushViewController:scVC animated:YES];
    }
    
    NSLog(@"服务中心");    
}


- (void)viewDidUnload
{
    
    [self setRefresh:nil];
    [self setSerCentre:nil];
    [self setLocation:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
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
    
    NSString *URLString = [NSString stringWithFormat:@"http://abc.4008200972.com/benny_driving/servlet/LocationShareServlet"];
    NSURL *url = [NSURL URLWithString:URLString];
    //ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    //[request addRequestHeader:@"Referer" value:@"http://www.dreamingwish.com/"];
    
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    [request setPostValue:@"hqdw" forKey:@"action"];
    [request setPostValue:[NSString stringWithFormat:@"%f",[SharedObj sharedOBJ].driLat] forKey:@"lat"];
    //[request setPostValue:@"31.272480" forKey:@"lat"];
    [request setPostValue:[NSString stringWithFormat:@"%f",[SharedObj sharedOBJ].driLog] forKey:@"log"];
    //[request setPostValue:@"121.468781"forKey:@"log"];
    //[request setPostValue:[SharedObj sharedOBJ].logindriid forKey:@"driid"];
    [request setDelegate:self];
    [request setDidFinishSelector:@selector(GetResult:)];
    [request setDidFailSelector:@selector(GetErr:)];
    
    [request startAsynchronous];

    
    
}


-(void)shareAction{
    
    NSString *textToShare = @"我正在使用邦尼代驾APP,感觉十分不错,你们也来试试,下载地址http://www.4008200972.com";
    UIImage *imageToShare = [UIImage imageNamed:@"icon@2x.png"];
    NSURL *urlToShare = [NSURL URLWithString:@"http://www.4008200972.com"];
    NSArray *activityItems = [NSArray arrayWithObjects:textToShare,imageToShare,urlToShare,nil];
    
    UIActivityViewController *activityVC = [[UIActivityViewController alloc]initWithActivityItems:activityItems applicationActivities:nil];    //不出现在活动项目
    activityVC.excludedActivityTypes = [NSArray arrayWithObjects: UIActivityTypePrint, UIActivityTypeCopyToPasteboard,
                                         UIActivityTypeAssignToContact,UIActivityTypeSaveToCameraRoll,nil];
    [self presentViewController:activityVC animated:TRUE completion:nil];
    
}

-(void)seePriceList
{
    PriceListVC *plv = [[PriceListVC alloc] init];
    [self.navigationController pushViewController:plv animated:YES];
}

-(void)goManage
{
    if([[SharedObj sharedOBJ].logindriid isEqualToString:@""])
    {
    LoginVC *login = [[LoginVC alloc] init];
        [self.navigationController pushViewController:login animated:YES];
    }
    else if(![[SharedObj sharedOBJ].logindriid isEqualToString:@""])
    {
    CounterActionVC *ca = [[CounterActionVC alloc] init];
    [self.navigationController pushViewController:ca animated:YES];    
    };
    
}

-(void)seeDriProfile
{
    if([[SharedObj sharedOBJ].logindriid isEqualToString:@""])
    {
    LoginVC *login = [[LoginVC alloc] init];
    [self.navigationController pushViewController:login animated:YES];
    }else if(![[SharedObj sharedOBJ].logindriid isEqualToString:@""])
    {
        DriProfileVC *rate = [[DriProfileVC alloc] init];
        [self.navigationController pushViewController:rate animated:YES];
    }
    
}

-(void)seeDriRate
{
    if([[SharedObj sharedOBJ].logindriid isEqualToString:@""])
    {
    LoginVC *login = [[LoginVC alloc] init];
    [self.navigationController pushViewController:login animated:YES];
    }else if(![[SharedObj sharedOBJ].logindriid isEqualToString:@""])
    {
    DriRateVC *drirate = [[DriRateVC alloc] init];
    [self.navigationController pushViewController:drirate animated:YES];
    }
}

-(void)seeAccount
{
    if([[SharedObj sharedOBJ].logindriid isEqualToString:@""])
    {
    LoginVC *login = [[LoginVC alloc] init];
    [self.navigationController pushViewController:login animated:YES];
    }else if(![[SharedObj sharedOBJ].logindriid isEqualToString:@""])
    {
      AccountVC *AcVC = [[AccountVC alloc] init];
     [self.navigationController pushViewController:AcVC animated:YES];
    }
    
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


@end
