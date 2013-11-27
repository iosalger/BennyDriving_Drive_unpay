//
//  AccountViewController.m
//  BennyDriving_Driver
//
//  Created by BennyDriving on 8/12/13.
//  Copyright (c) 2013 BennyDriving. All rights reserved.
//

#import "AccountVC.h"
#import "JSONKit.h"
#include <sys/socket.h> // Per msqr
#include <sys/sysctl.h>
#include <net/if.h>
#include <net/if_dl.h>
//#import "UPViewController.h"
#import "UPPayPlugin.h"
#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"
#import "ChargeRec.h"
#import "WithdrawRec.h"
#import "ComsueRec.h"
#import "TPKeyboardAvoidingScrollView.h"
#import "UIViewController+MJPopupViewController.h"
#import "WithConfirmPopVC.h"
#import "SharedObj.h"
#import "tooles.h"


#define KBtn_width        200
#define KBtn_height       80
#define KXOffSet          (self.view.frame.size.width - KBtn_width) / 2
#define KYOffSet          80

#define kVCTitle          @"TN测试"
#define kBtnFirstTitle    @"新控件测试"
#define kBtnSecondTitle   @"老控件测试"
#define kWaiting          @"正在获取TN,请稍后..."
#define kNote             @"提示"
#define kConfirm          @"确定"
#define kErrorNet         @"网络错误"
#define kResult           @"支付结果：%@"

#define kConfigTnUrl      @"http://218.80.192.213:1725/clsun/getLaa?id=2"
//#define kNormalTnUrl      @"http://mpay.unionpay.com/sim/gettn"
#define kNormalTnUrl      @"http://222.66.233.198:8080/sim/gettn"
//120.204.69.167:10306
//222.66.233.198:8080
//172.17.254.198:10306


@interface AccountVC ()<MJSecondPopupDelegate>{
    WithConfirmPopVC *withConfirmPopVC;
}

@end

@implementation AccountVC

@synthesize input_withdraw,bgbox,scrollView,dic;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBarHidden=NO;
    self.navigationItem.title = @"个人账户";
    self.view.backgroundColor= [UIColor colorWithPatternImage:[UIImage imageNamed:@"homebg.png"]];

}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    UIImage *HomeBtnImg = [UIImage imageNamed:@"btn_home.png"];
    UIButton *homeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    homeBtn.frame = CGRectMake(0, 0, 44, 44);
    [homeBtn addTarget:self action:@selector(handleHome) forControlEvents:UIControlEventTouchUpInside];
    
    [homeBtn setImage:HomeBtnImg forState:UIControlStateNormal];
    UIBarButtonItem *homeButton = [[UIBarButtonItem alloc] initWithCustomView:homeBtn];
    self.navigationItem.rightBarButtonItem = homeButton;
    
    [self setBackLeftBarButtonItem];
    
    scrollView = [[TPKeyboardAvoidingScrollView alloc] init];
    scrollView.frame = self.view.bounds;
    [self.view addSubview:scrollView];
    
    bgbox = [[UIImageView alloc] initWithFrame:CGRectMake(0, 3, 320, 256)];
    bgbox.image = [UIImage imageNamed:@"acount_box"];
    [scrollView addSubview:bgbox];
    
    UILabel *balanValue = [[UILabel alloc] initWithFrame:CGRectMake(180, 30, 200, 50)];
    //balanValue.text = [dic1 objectForKey:@"balance"];
    //NSLog(@"xxxxx%@",[NSString stringWithFormat:@"%@",[dic1 objectForKey:@"balance"]]);
    //balanValue.text = [NSString stringWithFormat:@"%@",[dic1 objectForKey:@"balance"]];
    balanValue.backgroundColor = [UIColor clearColor];
    //balanValue.text = @"100元";
    [scrollView addSubview:balanValue];

    
    //NSString *filePath = [[NSBundle mainBundle]pathForResource:@"accbalance" ofType:@"json"];
    //NSString *JSONString = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
    //NSLog(@"======%@",JSONString);
    
    //NSData *jsonData = [NSData dataWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
    //NSDictionary *dic1 = [JSONString objectFromJSONString];
    //
    //    NSLog(@"ddddddd%@",dic1);
    //_driProArr = [dic1 objectForKey:@"driverprofile"];
   // NSLog(@"%@",_driProArr);
    
//    UILabel *balanTitle = [[UILabel alloc] initWithFrame:CGRectMake(30, 50, 100, 50)];
//    balanTitle.text = [dic1 objectForKey:@"Title"];
//    balanTitle.backgroundColor = [UIColor clearColor];
//    [self.view addSubview:balanTitle];

    
    NSString *urlString = [NSString stringWithFormat:@"http://demo.4008200972.com/vip/jk/url.php?driid=%@&action=dri-acc",[SharedObj sharedOBJ].logindriid];
    NSURL *url = [NSURL URLWithString:urlString];
    NSLog(@"%@",url);
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    [request setCompletionBlock:^{
        NSString *JSONString = request.responseString;
        NSLog(@"%@",JSONString);
        dic = [JSONString objectFromJSONString];
        NSLog(@"============JSON=================");
        NSLog(@"%@====",dic);
        NSLog(@"====%@",[dic objectForKey:@"balance"]);
        balanValue.text = [dic objectForKey:@"balance"];

    }];
        [request startSynchronous];
    
        
    UIButton *btn_charge = [UIButton buttonWithType:UIButtonTypeCustom];
    btn_charge.frame = CGRectMake(15,90, 280, 36);
    [btn_charge addTarget:self action:@selector(normalPayAction:) forControlEvents:UIControlEventTouchUpInside];
    [scrollView addSubview:btn_charge];
    
    input_withdraw = [[UITextField alloc] initWithFrame:CGRectMake(88, 180, 180, 35)];
    input_withdraw.borderStyle = UITextBorderStyleNone;
    input_withdraw.placeholder = @"请输入您提现的金额";
    input_withdraw.font =[UIFont systemFontOfSize:12.0];
    input_withdraw.delegate = self;
    [scrollView addSubview:input_withdraw];
    
    UIButton *btn_withdraw = [UIButton buttonWithType:UIButtonTypeCustom];
    btn_withdraw.frame = CGRectMake(15, 220, 280, 36);
    [btn_withdraw addTarget:self action:@selector(goWithdraw)forControlEvents:UIControlEventTouchUpInside];
    [scrollView addSubview:btn_withdraw];
    
    UIButton *seechargeRec = [UIButton buttonWithType:UIButtonTypeCustom];
    seechargeRec.frame = CGRectMake(30, 265, 260, 40);
    [seechargeRec setTitle:@"查看充值记录" forState:UIControlStateNormal];
    seechargeRec.layer.cornerRadius = 3;
    seechargeRec.titleLabel.font = [UIFont fontWithName:@"Verdana-Bold" size:16.0];
    [seechargeRec setBackgroundColor:[UIColor colorWithRed:255.0/255.0 green:100.0/255.0 blue:50.0/255.0 alpha:1]];
    [seechargeRec addTarget:self action:@selector(seeChargeRec)forControlEvents:UIControlEventTouchUpInside];
    [scrollView addSubview:seechargeRec];    
    
    UIButton *seewithdrawRec = [UIButton buttonWithType:UIButtonTypeCustom];
    seewithdrawRec.frame = CGRectMake(30, 315, 260, 40);
    [seewithdrawRec setTitle:@"查看提现记录" forState:UIControlStateNormal];
    seewithdrawRec.layer.cornerRadius = 3;
    seewithdrawRec.titleLabel.font = [UIFont fontWithName:@"Verdana-Bold" size:16.0];
    [seewithdrawRec setBackgroundColor:[UIColor colorWithRed:255.0/255.0 green:100.0/255.0 blue:50.0/255.0 alpha:1]];
    [seewithdrawRec addTarget:self action:@selector(seeWithdrowRec)forControlEvents:UIControlEventTouchUpInside];
    [scrollView addSubview:seewithdrawRec];
    
    UIButton *seecomsuRec = [UIButton buttonWithType:UIButtonTypeCustom];
    seecomsuRec.frame = CGRectMake(30, 365, 260, 40);
    [seecomsuRec setTitle:@"查看消费记录" forState:UIControlStateNormal];
    seecomsuRec.layer.cornerRadius = 3;
    seecomsuRec.titleLabel.font = [UIFont fontWithName:@"Verdana-Bold" size:16.0];
    [seecomsuRec setBackgroundColor:[UIColor colorWithRed:255.0/255.0 green:100.0/255.0 blue:50.0/255.0 alpha:1]];
    [seecomsuRec addTarget:self action:@selector(seeComsueRec)forControlEvents:UIControlEventTouchUpInside];
    [scrollView addSubview:seecomsuRec];
    
    //[super loadBottomBar];
}

-(void)setBackLeftBarButtonItem{
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(0, 0, 44, 44);
    
    [backBtn setImage:[UIImage imageNamed:@"btn_back.png"] forState:UIControlStateNormal];
    
    
    [backBtn addTarget:self action:@selector(doBack:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    self.navigationItem.leftBarButtonItem = backItem;
    
    
}

-(void)doBack:(UIButton *)bt
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)handleHome
{
    
    NSLog(@"Go Home......");
    [[NSNotificationCenter defaultCenter] postNotificationName:@"goHomeVC" object:nil];
}

-(void)goWithdraw
{
//    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"请登录www.4008200972.com绑定银行卡或支付宝账户"
//                                                   delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
//	[alert show];	
    
    withConfirmPopVC = nil;
    withConfirmPopVC = [[WithConfirmPopVC alloc] initWithNibName:@"WithConfirmPopVC" bundle:nil];
    withConfirmPopVC.delegate = self;
    [self presentPopupViewController:withConfirmPopVC animationType:MJPopupViewAnimationFade];    


}


- (void)cancelButtonClicked:(WithConfirmPopVC *)aSecondDetailViewController
{
    [self dismissPopupViewControllerWithanimationType:MJPopupViewAnimationFade];
    withConfirmPopVC = nil;
}

-(void)seeChargeRec
{
    ChargeRec *cr = [[ChargeRec alloc] init];
    [self.navigationController pushViewController:cr animated:YES];
}

-(void)seeWithdrowRec
{
    WithdrawRec *wdr = [[WithdrawRec alloc] init];
    [self.navigationController pushViewController:wdr animated:YES];
    
}

-(void)seeComsueRec
{

    ComsueRec *csr = [[ComsueRec alloc] init];
    [self.navigationController pushViewController:csr animated:YES];

}


-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    
    [input_withdraw resignFirstResponder];
    
    return YES;
    
}

-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    [scrollView adjustOffsetToIdealIfNeeded];
    
}


//- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
//{
//    [input_withdraw resignFirstResponder];
//    return YES;
//
//}

//- (BOOL)textFieldShouldReturn:(UITextField *)textField
//{
//    [input_withdraw resignFirstResponder];
//    return YES;
//}

#pragma mark - Alert

- (void)showAlertWait
{
    mAlert = [[UIAlertView alloc] initWithTitle:kWaiting message:nil delegate:self cancelButtonTitle:nil otherButtonTitles: nil];
    [mAlert show];
    UIActivityIndicatorView* aiv = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    aiv.center = CGPointMake(mAlert.frame.size.width / 2.0f - 15, mAlert.frame.size.height / 2.0f + 10 );
    [aiv startAnimating];
    [mAlert addSubview:aiv];
    [aiv release];
    [mAlert release];
}

- (void)showAlertMessage:(NSString*)msg
{
    mAlert = [[UIAlertView alloc] initWithTitle:kNote message:msg delegate:nil cancelButtonTitle:kConfirm otherButtonTitles:nil, nil];
    [mAlert show];
    [mAlert release];
}
- (void)hideAlert
{
    if (mAlert != nil)
    {
        [mAlert dismissWithClickedButtonIndex:0 animated:YES];
        mAlert = nil;
    }
}

#pragma mark - UPPayPlugin Test


- (void)userPayAction:(id)sender
{
    NSString* urlString = [NSString stringWithFormat:kConfigTnUrl];
    NSURL* url = [NSURL URLWithString:urlString];
    
    NSMutableURLRequest * urlRequest=[NSMutableURLRequest requestWithURL:url];
    NSURLConnection* urlConn = [[NSURLConnection alloc] initWithRequest:urlRequest delegate:self];
    [urlConn start];
    [self showAlertWait];
}


- (void)normalPayAction:(id)sender
{
    NSURL* url = [NSURL URLWithString:kNormalTnUrl];
	NSMutableURLRequest * urlRequest=[NSMutableURLRequest requestWithURL:url];
    NSURLConnection* urlConn = [[NSURLConnection alloc] initWithRequest:urlRequest delegate:self];
    [urlConn start];
    [self showAlertWait];
}


- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse*)response
{
    NSHTTPURLResponse* rsp = (NSHTTPURLResponse*)response;
    int code = [rsp statusCode];
    if (code != 200)
    {
        [self hideAlert];
        [self showAlertMessage:kErrorNet];
        [connection cancel];
        [connection release];
        connection = nil;
    }
    else
    {
        if (mData != nil)
        {
            [mData release];
            mData = nil;
        }
        mData = [[NSMutableData alloc] init];
    }
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [mData appendData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    [self hideAlert];
    NSString* tn = [[NSMutableString alloc] initWithData:mData encoding:NSUTF8StringEncoding];
    if (tn != nil && tn.length > 0)
    {
        NSLog(@"tn=%@",tn);
        [UPPayPlugin startPay:tn sysProvide:@"12345678" spId:@"1234" mode:@"01" viewController:self delegate:self];
    }
    [tn release];
    [connection release];
    connection = nil;
    
}

-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    [self hideAlert];
    [self showAlertMessage:kErrorNet];
    [connection release];
    connection = nil;
}

- (void)UPPayPluginResult:(NSString *)result
{
    NSString* msg = [NSString stringWithFormat:kResult, result];
    [self showAlertMessage:msg];
}

//get mac

- (NSString*)currentUID
{
    int                 mib[6];
    size_t              len;
    char                *buf;
    unsigned char       *ptr;
    struct if_msghdr    *ifm;
    struct sockaddr_dl  *sdl;
    
    mib[0] = CTL_NET;
    mib[1] = AF_ROUTE;
    mib[2] = 0;
    mib[3] = AF_LINK;
    mib[4] = NET_RT_IFLIST;
    
    NSString* noUID = @"";
    
    if ((mib[5] = if_nametoindex("en0")) == 0) {
        return noUID;
    }
    
    if (sysctl(mib, 6, NULL, &len, NULL, 0) < 0) {
        return noUID;
    }
    
    if ((buf = (char*)malloc(len)) == NULL) {
        return noUID;
    }
    
    if (sysctl(mib, 6, buf, &len, NULL, 0) < 0) {
        free(buf);
        return noUID;
    }
    
    ifm = (struct if_msghdr *)buf;
    sdl = (struct sockaddr_dl *)(ifm + 1);
    ptr = (unsigned char *)LLADDR(sdl);
    NSString *outstring = [NSString stringWithFormat:@"%02x%02x%02x%02x%02x%02x",
                           *ptr, *(ptr+1), *(ptr+2), *(ptr+3), *(ptr+4), *(ptr+5)];
    free(buf);
    
    return outstring;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
