//
//  TrafficState.m
//  BennyDriving_Driver
//
//  Created by BennyDriving on 8/29/13.
//  Copyright (c) 2013 BennyDriving. All rights reserved.
//

#import "TrafficState.h"
#import "BDDAppDelegate.h"

@interface TrafficState ()
@property(nonatomic,strong)UIButton *lkcx_btn;
@property(nonatomic,strong)UIButton *lxcx_btn;
@property(nonatomic,strong)UIButton *wzcx_btn;
@property(nonatomic,strong)UIButton *xczs_btn;
@end

@implementation TrafficState

@synthesize shoWeb,standardSegment,lkcx_btn,lxcx_btn,wzcx_btn,xczs_btn;

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
    self.navigationItem.title = @"信息查询";
//    [self loadsegment];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor= [UIColor colorWithPatternImage:[UIImage imageNamed:@"homebg.png"]];
	// Do any additional setup after loading the view.
    shoWeb.delegate = self;
    
    shoWeb = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, 320, self.view.bounds.size.height)];
    shoWeb.scalesPageToFit = YES;
    
    UIImage *HomeBtnImg = [UIImage imageNamed:@"btn_home.png"];
    UIButton *homeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    homeBtn.frame = CGRectMake(0, 0, 44, 44);
    [homeBtn addTarget:self action:@selector(handleHome) forControlEvents:UIControlEventTouchUpInside];
    
    [homeBtn setImage:HomeBtnImg forState:UIControlStateNormal];
    UIBarButtonItem *homeButton = [[UIBarButtonItem alloc] initWithCustomView:homeBtn];
    self.navigationItem.rightBarButtonItem = homeButton;
    
    [self setBackLeftBarButtonItem];

    
    BDDAppDelegate *delegate = [UIApplication sharedApplication].delegate;
    [delegate addObserver:self forKeyPath:@"ws" options:NSKeyValueObservingOptionNew context:nil];

    [self loadWebPageWithString]; 
    
    [self.view addSubview:shoWeb];
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height-94, self.view.frame.size.width,50)];
    lkcx_btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 64, 49)];
    [lkcx_btn setBackgroundImage:[UIImage imageNamed:@"lukuangchaxun"] forState:UIControlStateNormal];
    lkcx_btn.tag = 100;
    [lkcx_btn addTarget:self action:@selector(standardSegmentValueChanged:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:lkcx_btn];
    
    
    lxcx_btn = [[UIButton alloc]initWithFrame:CGRectMake(85, 0, 54, 49)];
    [lxcx_btn setBackgroundImage:[UIImage imageNamed:@"luxianchaxun"] forState:UIControlStateNormal];
    lxcx_btn.tag = 101;
    [lxcx_btn addTarget:self action:@selector(standardSegmentValueChanged:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:lxcx_btn];
    
    wzcx_btn = [[UIButton alloc]initWithFrame:CGRectMake(170, 0, 64, 49)];
    [wzcx_btn setBackgroundImage:[UIImage imageNamed:@"weizhangchaxun"] forState:UIControlStateNormal];
    wzcx_btn.tag = 102;
    [wzcx_btn addTarget:self action:@selector(standardSegmentValueChanged:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:wzcx_btn];
    
    xczs_btn = [[UIButton alloc]initWithFrame:CGRectMake(250, 0, 64, 49)];
    [xczs_btn setBackgroundImage:[UIImage imageNamed:@"xichezhishu"] forState:UIControlStateNormal];
    xczs_btn.tag = 103;
    [xczs_btn addTarget:self action:@selector(standardSegmentValueChanged:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:xczs_btn];
    
    view.backgroundColor = [UIColor blackColor];
    view.alpha = 0.5;
    [self.view addSubview:view];
    
    
    
    //[self loadsegment];
    //[super loadBottomBar];
    
}
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    [self loadWebPageWithString];
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

-(void)loadsegment
{
    NSArray *objects = [NSArray arrayWithObjects:@"路况查询", @"路线查询", @"违章查询", @"洗车指数", nil];
    standardSegment = [[UISegmentedControl alloc] initWithItems:objects];
	standardSegment.frame = CGRectMake(10, self.view.bounds.size.height-90, 300, 30);
	standardSegment.segmentedControlStyle = UISegmentedControlStyleBar;
	[standardSegment addTarget:self action:@selector(standardSegmentValueChanged:) forControlEvents:UIControlEventValueChanged];
	standardSegment.selectedSegmentIndex = 0;
	standardSegment.autoresizingMask = UIViewAutoresizingFlexibleWidth;
	[self.view addSubview:standardSegment];
    
}

- (void)loadWebPageWithString
{
    NSString *urlstring = [NSString stringWithFormat:@"http://www.hao123.com/tianqi"];
    BDDAppDelegate *delegate = [UIApplication sharedApplication].delegate;
    
    switch (delegate.ws) {
    case web1:
        urlstring = [NSString stringWithFormat:@"http://ditu.mapabc.com/lukuang/shanghailukuang.html"];
        break;
        case web2:
            urlstring = [NSString stringWithFormat:@"http://map.tools.sina.com.cn/jiacheluxian.php"];
            break;
        case web3:
            urlstring = urlstring = [NSString stringWithFormat:@"http://www.weizhangwang.com"];
            break;
        case web4:
            urlstring = [NSString stringWithFormat:@"http://www.hao123.com/tianqi"];
            break;
    default:
        break;
}

    
    
    
    
    NSURL *url = [NSURL URLWithString:urlstring];
    NSURLRequest *request =[NSURLRequest requestWithURL:url];
    [shoWeb loadRequest:request];
    
}


- (BOOL) webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    
    return YES;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    
    CGRect frame = webView.frame;
    
    CGSize fittingSize = [webView sizeThatFits:CGSizeZero];
    
    frame.size = fittingSize;
    
    webView.frame = frame;
    
    //[activityIndicatorView stopAnimating];
    
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    UIAlertView *alterview = [[UIAlertView alloc] initWithTitle:@"" message:[error localizedDescription]  delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
    [alterview show];
    //[alterview release];
}


- (void)standardSegmentValueChanged:(UIButton*)sender {
	
	
    BDDAppDelegate *delegate = [UIApplication sharedApplication].delegate;
    
    if (sender.tag==100) {
        delegate.ws = web1;
        [lkcx_btn setBackgroundImage:[UIImage imageNamed:@"lukuangchaxun_huang"] forState:UIControlStateNormal];
        [lxcx_btn setBackgroundImage:[UIImage imageNamed:@"luxianchaxun"] forState:UIControlStateNormal];
        [wzcx_btn setBackgroundImage:[UIImage imageNamed:@"weizhangchaxun"] forState:UIControlStateNormal];
        [xczs_btn setBackgroundImage:[UIImage imageNamed:@"xichezhishu"] forState:UIControlStateNormal];
//        TrafficState *ts = [[TrafficState alloc] init];
//        delegate.window.rootViewController =ts;
//        [self.navigationController pushViewController:ts animated:YES];
        //[SharedObj sharedOBJ].segmentIndex = control.selectedSegmentIndex;
    }else if (sender.tag==101)
    {
        delegate.ws = web2;
        [lkcx_btn setBackgroundImage:[UIImage imageNamed:@"lukuangchaxun"] forState:UIControlStateNormal];
        [lxcx_btn setBackgroundImage:[UIImage imageNamed:@"luxianchaxun_huang"] forState:UIControlStateNormal];
        [wzcx_btn setBackgroundImage:[UIImage imageNamed:@"weizhangchaxun"] forState:UIControlStateNormal];
        [xczs_btn setBackgroundImage:[UIImage imageNamed:@"xichezhishu"] forState:UIControlStateNormal];
//        Route *rt = [[Route alloc] init];
//        delegate.window.rootViewController =rt;
//        [self.navigationController pushViewController:rt animated:YES];
//        [SharedObj sharedOBJ].segmentIndex = control.selectedSegmentIndex;
        
    }else if (sender.tag==102)
    {
        delegate.ws = web3;
        [lkcx_btn setBackgroundImage:[UIImage imageNamed:@"lukuangchaxun"] forState:UIControlStateNormal];
        [lxcx_btn setBackgroundImage:[UIImage imageNamed:@"luxianchaxun"] forState:UIControlStateNormal];
        [wzcx_btn setBackgroundImage:[UIImage imageNamed:@"weizhangchaxun_huang"] forState:UIControlStateNormal];
        [xczs_btn setBackgroundImage:[UIImage imageNamed:@"xichezhishu"] forState:UIControlStateNormal];
//        BreakLaw *bl = [[BreakLaw alloc] init];
//        [self.navigationController pushViewController:bl animated:YES];
//        [SharedObj sharedOBJ].segmentIndex = control.selectedSegmentIndex;
        
    }else if (sender.tag==103)
    {
        delegate.ws =web4;
        [lkcx_btn setBackgroundImage:[UIImage imageNamed:@"lukuangchaxun"] forState:UIControlStateNormal];
        [lxcx_btn setBackgroundImage:[UIImage imageNamed:@"luxianchaxun"] forState:UIControlStateNormal];
        [wzcx_btn setBackgroundImage:[UIImage imageNamed:@"weizhangchaxun"] forState:UIControlStateNormal];
        [xczs_btn setBackgroundImage:[UIImage imageNamed:@"xichezhishu_huang"] forState:UIControlStateNormal];
//        CanWashcar *cwc = [[CanWashcar alloc] init];
//        [self.navigationController pushViewController:cwc animated:YES];
//        [SharedObj sharedOBJ].segmentIndex = control.selectedSegmentIndex;
    }
    
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
