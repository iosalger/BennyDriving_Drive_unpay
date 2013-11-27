//
//  LoginVC.m
//  BennyDriving_Driver
//
//  Created by BennyDriving on 9/9/13.
//  Copyright (c) 2013 BennyDriving. All rights reserved.
//

#import "LoginVC.h"
#import "SevCenterVC.h"
#import "JSONKit.h"
#import "SharedObj.h"
#import "AgreementVC.h"
#import "TPKeyboardAvoidingScrollView.h"
#import "BDDViewController.h"
#import "DriMapVC.h"
#import "LoginNotice.h"
#import "UIViewController+MJPopupViewController.h"

@interface LoginVC ()<MJSecondPopupDelegate>{
    
    LoginNotice *LN;
}

-(void) login:(id)sender;  
-(void) GetErr:(ASIHTTPRequest *)request;
-(void) GetResult:(ASIHTTPRequest *)request;  

@end

@implementation LoginVC

@synthesize username,password,loginBox,loginHead,fetchInfodic,scrollView,contentController,lbl_notice;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        //self.view.backgroundColor = [UIColor whiteColor];
        
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBarHidden = NO;
    if (![[SharedObj sharedOBJ].logindriid isEqualToString:@""])
    {
         [self.navigationController popViewControllerAnimated:YES];
        
        //[self.navigationController pop]
    }

}

-(void) login:(id)sender
{  
    //表单提交前的验证
    if (username.text == nil||password.text==nil )
    {
        [tooles MsgBox:@"用户名或密码不能为空！"];  
        return;  
    }  
    //隐藏键盘
    [username resignFirstResponder];  
    [password resignFirstResponder];  
    
    [tooles showHUD:@"正在登陆...."]; 
    NSString *GBKStr1 = @"用户";
    GBKStr1 = [GBKStr1 stringByAddingPercentEscapesUsingEncoding:CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000)];
    NSString *GBKStr2 = @"账号登陆";
    GBKStr2 = [GBKStr1 stringByAddingPercentEscapesUsingEncoding:CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000)];
    //NSString *urlstr =
    //[NSString stringWithFormat:@"http://demo.4008200972.com/vip/jk/url.php?acc=%@&psd=%@&action=dri-login",username.text,password.text];
//    NSString *urlstr =
//    [NSString stringWithFormat:@"http://demo.4008200972.com/vip/jk/url.php?acc=%@&psd=%@&action=dri-login",username.text,password.text];

    NSString *urlstr =
    [NSString stringWithFormat:@"http://abc.4008200972.com/benny_driving/servlet/LoginServlet"];
         
    NSURL *myurl = [NSURL URLWithString:urlstr];  
    NSLog(@"Url=====%@",myurl);
    
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:myurl];  
    //设置表单提交项
    [request setPostValue:@"dri-login" forKey:@"action"];
    [request setPostValue:username.text forKey:@"acc"];
    [request setPostValue:password.text forKey:@"psd"];  
    [request setDelegate:self];  
    [request setDidFinishSelector:@selector(GetResult:)];  
    [request setDidFailSelector:@selector(GetErr:)];  
    
    [request startAsynchronous];  
    
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
fetchInfodic = [JSONString objectFromJSONString];
NSLog(@"%@",JSONString);
NSLog(@"%@",fetchInfodic);
    
    NSString *logindriid = [NSString stringWithFormat:@"%@",[fetchInfodic objectForKey:@"driid"]];
    NSString *loginisagr = [NSString stringWithFormat:@"%@",[fetchInfodic objectForKey:@"isagr"]];
    [SharedObj sharedOBJ].loginisagr = loginisagr;
   
    
    //接收二进制数据
    //NSData *data = [request responseData];
    if (![logindriid isEqualToString:@"-1"]) {
        
        
    [tooles removeHUD];
        
[SharedObj sharedOBJ].logindriid = logindriid;
[SharedObj sharedOBJ].logindrinum = username.text;
        
NSLog(@"self  %@",logindriid);
NSLog(@"share %@",[SharedObj sharedOBJ].logindriid);
NSLog(@"logindrinum %@",[SharedObj sharedOBJ].logindrinum);

    
    if ([[SharedObj sharedOBJ].loginisagr isEqualToString:@"1"]){
        
AgreementContentController *isagr = [[AgreementContentController alloc] init];
[self.navigationController pushViewController:isagr animated:YES];
        
        }
        
    SevCenterVC *scVC = [[SevCenterVC alloc] init];
    [self.navigationController pushViewController:scVC animated:YES];
        
        
    }else if([logindriid isEqualToString:@"-1"])
    {

        [tooles removeHUD];
        
        [tooles MsgBox:@"密码或用户名不正确"];
    }
    
}  

//连接错误调用这个函数  
- (void) GetErr:(ASIHTTPRequest *)request{  
    
    [tooles removeHUD];  
    [tooles MsgBox:@"网络错误,连接不到服务器"];  
}  

- (void)viewDidLoad  
{  
    [super viewDidLoad];  
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"homebg"]];
      [self.navigationItem setTitle:@"登录"];
    UIImage *topBarImg = [UIImage imageNamed:@"topbar_bg_opq"];
    //    self.navigationController.navigationBar set
    
    [self.navigationController.navigationBar setBackgroundImage:topBarImg forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setTintColor:[UIColor clearColor]];
    [self.navigationController.navigationBar setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"homebg"]]];

    
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
    
//    UILabel *txt1 = [[UILabel alloc] initWithFrame:CGRectMake(30,50,70,30)];  
//    [txt1 setText:@"用户名"];  
//    [txt1 setBackgroundColor:[UIColor clearColor]];  
//    [self.view addSubview:txt1];  
//    
//    UILabel *txt2 = [[UILabel alloc] initWithFrame:CGRectMake(30,90,70,30)];  
//    [txt2 setText:@"密   码"];  
//    [txt2 setBackgroundColor:[UIColor clearColor]];  
//    [self.view addSubview:txt2];  
    
    loginBox = [[UIImageView alloc] initWithFrame:CGRectMake(0,20, 320, 201)];
    loginBox.image = [UIImage imageNamed:@"login_bg"];
    [scrollView addSubview:loginBox];
    
    loginHead = [[UIImageView alloc] initWithFrame:CGRectMake(0,30, 320, 60)];
    loginHead.image = [UIImage imageNamed:@"login_head"];
    [scrollView addSubview:loginHead];
    
    username = [[UITextField alloc]initWithFrame:CGRectMake(110,98, 150, 20)];
    username.placeholder = @"请输入您的工号";
    username.font =[UIFont systemFontOfSize:10.5];
    [username setBorderStyle:UITextBorderStyleNone];
    [scrollView addSubview:username];  
    
    password = [[UITextField alloc]initWithFrame:CGRectMake(110,128, 150, 20)];
    password.placeholder = @"请输入您的密码";
    password.font =[UIFont systemFontOfSize:10.5];
    [password setBorderStyle:UITextBorderStyleNone];
    [password setSecureTextEntry:YES];  
    [scrollView addSubview:password];  
    
//    UIButton *btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];  
//    [btn setTitle:@"提交" forState:UIControlStateNormal];  
//    [btn addTarget:self action:@selector(login:) forControlEvents:UIControlEventTouchUpInside];  
//    [btn setFrame:CGRectMake(90, 150, 150, 40)];
//    [self.view addSubview:btn];

    UIButton *btn_submit = [UIButton buttonWithType:UIButtonTypeCustom];
    btn_submit.frame = CGRectMake(60, 165, 200, 40);
    btn_submit.layer.cornerRadius = 3;
    btn_submit.titleLabel.font = [UIFont fontWithName:@"Verdana-Bold" size:16.0];
    [btn_submit setBackgroundColor:[UIColor colorWithRed:200.0/255.0 green:20.0/255.0 blue:70.0/255.0 alpha:1]];
    
    [btn_submit setTitle:@"登录" forState:UIControlStateNormal];
    [btn_submit addTarget:self action:@selector(login:)forControlEvents:UIControlEventTouchUpInside];
    [scrollView addSubview:btn_submit];
    
    
    UIButton *btn_notice = [UIButton buttonWithType:UIButtonTypeCustom];
    btn_notice.frame = CGRectMake(60, 225, 200, 40);
    btn_notice.backgroundColor = [UIColor clearColor];
    btn_notice.layer.cornerRadius = 3;
    btn_notice.titleLabel.font = [UIFont fontWithName:@"Verdana-Bold" size:18.0];
    btn_notice.titleLabel.textColor = [UIColor whiteColor];
    [btn_notice setBackgroundColor:[UIColor colorWithRed:200.0/255.0 green:20.0/255.0 blue:70.0/255.0 alpha:0]];
    [btn_notice addTarget:self action:@selector(showNotice)forControlEvents:UIControlEventTouchUpInside];
    [btn_notice setTitle:@"获取账号密码途径" forState:UIControlStateNormal];
    [scrollView addSubview:btn_notice];
    
    
}

-(void)showNotice
{
    //Login_notice = [[Login_notice alloc] init]
    
    LN = nil;
    LN  = [[LoginNotice alloc] initWithNibName:@"LoginNotice" bundle:nil];
    LN.delegate = self;
    [self presentPopupViewController:LN animationType:MJPopupViewAnimationFade];

}

-(void)cancelButtonClicked:(LoginNotice *)aSecondDetailViewController
{
    [self dismissPopupViewControllerWithanimationType:MJPopupViewAnimationFade];
    LN = nil;
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
    //DriMapVC *root = [[DriMapVC alloc] initWithNibName:@"DriMapVC" bundle:nil];
    //UINavigationController *navHome = [[UINavigationController alloc] initWithRootViewController:root];
    //[self.navigationController popToViewController:navHome animated:YES];
    [self.navigationController popViewControllerAnimated:YES];
    
}

-(void)handleHome
{
    NSLog(@"Go Home......");
    [[NSNotificationCenter defaultCenter] postNotificationName:@"goHomeVC" object:nil];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

@end


