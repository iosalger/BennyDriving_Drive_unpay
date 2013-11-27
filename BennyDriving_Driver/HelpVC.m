//
//  HelpVC.m
//  BennyDriving_Driver
//
//  Created by BennyDriving on 8/13/13.
//  Copyright (c) 2013 BennyDriving. All rights reserved.
//

#import "HelpVC.h"
#import "Terms.h"
#import "Faq.h"
#import "About.h"
#import "Feedback.h"
#import "StoreRateVC.h"
#import "BDDAppDelegate.h"

@interface HelpVC ()

@end

@implementation HelpVC

@synthesize Homepic,helpList,HelpLst;
@synthesize img_aboutUs,img_terms,img_faq,img_feedback,img_rateSoft,lbl_aboutUs,lbl_terms,lbl_faq,lbl_feedback,lbl_rateSoft;


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
    self.navigationItem.title = @"帮助";
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    img_aboutUs = [[UIImageView alloc] initWithFrame:CGRectMake(5, 5, 100, 35)];
    img_aboutUs.image = [UIImage imageNamed:@"help_about"];
    
    
    img_terms = [[UIImageView alloc] initWithFrame:CGRectMake(5, 5, 100, 35)];
    img_terms.image = [UIImage imageNamed:@"help_terms"];
    
    img_faq = [[UIImageView alloc] initWithFrame:CGRectMake(5, 5, 100, 35)];
    img_faq.image = [UIImage imageNamed:@"help_faq"];


    img_feedback = [[UIImageView alloc] initWithFrame:CGRectMake(5, 5, 100, 35)];
    img_feedback.image = [UIImage imageNamed:@"help_feedback"];
    
    img_rateSoft = [[UIImageView alloc] initWithFrame:CGRectMake(5, 5, 100, 35)];
    img_rateSoft.image = [UIImage imageNamed:@"help_softRate"];
    
    HelpLst = [[NSMutableArray alloc] init];
    
    HelpLst = [NSMutableArray arrayWithObjects:img_aboutUs,img_terms,img_faq,img_feedback,img_rateSoft,nil];
    //[self HelpLstdata];
    
    self.view.backgroundColor= [UIColor colorWithPatternImage:[UIImage imageNamed:@"homebg.png"]];
    
//    Homepic = [[UIImageView alloc] init];
//    Homepic.frame = CGRectMake(0, 0, 320, 480);
//    Homepic.image = [UIImage imageNamed:@"homebg.png"];
//    [self.view addSubview:Homepic];
//    UIBarButtonItem *homeButton = [[UIBarButtonItem alloc] initWithTitle:@"主页"                                                                      style:UIBarButtonItemStylePlain target:self action:@selector(handleHome)];
//    self.navigationItem.rightBarButtonItem = homeButton;
    
    UIImage *HomeBtnImg = [UIImage imageNamed:@"btn_home.png"];
    
    UIButton *homeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    homeBtn.frame = CGRectMake(0, 0, 44, 44);
    [homeBtn addTarget:self action:@selector(handleHome) forControlEvents:UIControlEventTouchUpInside];
    
    [homeBtn setImage:HomeBtnImg forState:UIControlStateNormal];
    UIBarButtonItem *homeButton = [[UIBarButtonItem alloc] initWithCustomView:homeBtn];
    self.navigationItem.rightBarButtonItem = homeButton;
    
    helpList = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 320, self.view.frame.size.height) style:UITableViewStylePlain];
    helpList.dataSource =self;
    helpList.delegate =self;
    helpList.backgroundColor = [UIColor clearColor];
    [self.view addSubview:helpList];
    
    //创建左侧按钮
    [self setBackLeftBarButtonItem];
    
    //[self loadBtn];
    
    
}


-(void)setBackLeftBarButtonItem{
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(0, 0, 44, 44);
    
    [backBtn setImage:[UIImage imageNamed:@"btn_back.png"] forState:UIControlStateNormal];
    [backBtn setImage:[UIImage imageNamed:@"btn_back_tapped.png"] forState:UIControlStateHighlighted];
    
    [backBtn addTarget:self action:@selector(doBack:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    self.navigationItem.leftBarButtonItem = backItem;
    
    
}

-(void)doBack:(UIButton *)bt
{
    [self.navigationController popViewControllerAnimated:YES];
}


-(void)loadBtn
{
    UIButton *btn_aboutUs = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    btn_aboutUs.frame = CGRectMake(30, 20, 260, 50);
    [btn_aboutUs setTitle:@"关于我们" forState:UIControlStateNormal];
    [btn_aboutUs addTarget:self action:@selector(aboutUs)forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn_aboutUs];
    
    UIButton *btn_Terms = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    btn_Terms.frame = CGRectMake(30, 80, 260, 50);
    [btn_Terms setTitle:@"服务协议" forState:UIControlStateNormal];
    [btn_Terms addTarget:self action:@selector(terms)forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn_Terms];
    
    UIButton *btn_FAQ = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    btn_FAQ.frame = CGRectMake(30, 140, 260, 50);
    [btn_FAQ setTitle:@"常见问题" forState:UIControlStateNormal];
    [btn_FAQ addTarget:self action:@selector(FAQ)forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn_FAQ];
    
    
    UIButton *btn_Feedback = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    btn_Feedback.frame = CGRectMake(30, 200, 260, 50);
    [btn_Feedback setTitle:@"意见反馈" forState:UIControlStateNormal];
    [btn_Feedback addTarget:self action:@selector(Feedback)forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn_Feedback];
    
    UIButton *btn_StoreRate = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    btn_StoreRate.frame = CGRectMake(30, 260, 260, 50);
    [btn_StoreRate setTitle:@"软件评分" forState:UIControlStateNormal];
    [btn_StoreRate addTarget:self action:@selector(storeRate)forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn_StoreRate];
    
}

-(void)handleHome
{
    NSLog(@"Go Home......");
    [[NSNotificationCenter defaultCenter] postNotificationName:@"goHomeVC" object:nil];
}

#pragma mark
#pragma mark Bottom Method

-(void)aboutUs
{
    About *about = [[About alloc] init];
    [self.navigationController pushViewController:about animated:YES];

}

-(void)terms
{
    
    Terms *terms = [[Terms alloc] init];
    [self.navigationController pushViewController:terms animated:YES];

}

-(void)FAQ
{
    Faq *faq = [[Faq alloc] init];
    [self.navigationController pushViewController:faq animated:YES];

}

-(void)Feedback
{

    Feedback *fb = [[Feedback alloc] init];
    [self.navigationController pushViewController:fb animated:YES];
}

-(void)storeRate
{
    StoreRateVC *storeRate = [[StoreRateVC alloc] init];
    [self.navigationController pushViewController:storeRate animated:YES];
    
}

#pragma mark - Table View methods

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 5;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    //[cell.contentView addSubview:[[[HelpLstData objectAtIndex:indexPath.section] objectAtIndex: indexPath.row] objectForKey:@"label"]];
    [cell.contentView addSubview:[HelpLst objectAtIndex: indexPath.row]];

    //cell.contentView.backgroundColor = [UIColor clearColor];
    cell.backgroundColor = [UIColor clearColor];
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    UILabel *sLine2 = [[UILabel alloc] initWithFrame:CGRectMake(0, 44, 320, 1)];
    sLine2.backgroundColor = [UIColor whiteColor];
    
    //[self.contentView addSubview:sLine1];
    [cell.contentView addSubview:sLine2];
    
   helpList.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    return cell;
    
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row ==0)
    {
        About *about = [[About alloc] init];
        [self.navigationController pushViewController:about animated:YES];
    }else if (indexPath.row ==1)
    {
        Terms *terms = [[Terms alloc] init];
        [self.navigationController pushViewController:terms animated:YES];
    }else if (indexPath.row ==2)
    {
        Faq *faq = [[Faq alloc] init];
        [self.navigationController pushViewController:faq animated:YES];    }
    else if (indexPath.row ==3)
    {
        Feedback *fb = [[Feedback alloc] init];
        [self.navigationController pushViewController:fb animated:YES];
        
    }else if (indexPath.row ==4)
    {
        StoreRateVC *storeRate = [[StoreRateVC alloc] init];
        [self.navigationController pushViewController:storeRate animated:YES];
        //iRate *storeRate = [[iRate alloc] init];
        //[self.navigationController pushViewController:storeRate animated:YES];
        //NSString *urlstring = [NSString stringWithFormat:@"itms-apps://ax.itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?type=Purple+Software&id=333333"];
        //NSURL *url = [NSURL URLWithString:urlstring];
        //NSURLRequest *request =[NSURLRequest requestWithURL:url];
        //[self loadRequest:request];

    }

}

- (BOOL) webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    
    return YES;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{

    return 45;
}


- (void)didReceiveMemoryWarning
{
    
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
