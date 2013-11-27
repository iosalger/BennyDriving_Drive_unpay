//
//  InfoCentreVC.m
//  BennyDriving_Driver
//
//  Created by BennyDriving on 8/13/13.
//  Copyright (c) 2013 BennyDriving. All rights reserved.
//

#import "InfoCentreVC.h"
#import "CompanyNews.h"
#import "SharedObj.h"

@interface InfoCentreVC ()

@end

@implementation InfoCentreVC

@synthesize InfoList;

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
    self.navigationItem.title = @"信息中心";
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
self.view.backgroundColor= [UIColor colorWithPatternImage:[UIImage imageNamed:@"homebg.png"]];
    
    [self.navigationItem setTitle:@"信息中心"];
    
    UIImage *HomeBtnImg = [UIImage imageNamed:@"btn_home.png"];
    UIButton *homeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    homeBtn.frame = CGRectMake(0, 0, 44, 44);
    [homeBtn addTarget:self action:@selector(handleHome) forControlEvents:UIControlEventTouchUpInside];
    
    [homeBtn setImage:HomeBtnImg forState:UIControlStateNormal];
    UIBarButtonItem *homeButton = [[UIBarButtonItem alloc] initWithCustomView:homeBtn];
    self.navigationItem.rightBarButtonItem = homeButton;
    
    [self setBackLeftBarButtonItem];
    
    InfoList = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 320, self.view.frame.size.height) style:UITableViewStylePlain];
    InfoList.dataSource =self;
    InfoList.delegate =self;
    InfoList.separatorStyle = UITableViewCellSeparatorStyleNone;
    InfoList.backgroundColor = [UIColor clearColor];
    [self.view addSubview:InfoList];
    
    //self.view.backgroundColor= [UIColor whiteColor];
    [self loadBtn];
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


//-(void)loadBtn
//{
//    UIButton *btn_aboutUs = [UIButton buttonWithType:UIButtonTypeRoundedRect];
//    btn_aboutUs.frame = CGRectMake(30, 30, 260, 50);
//    [btn_aboutUs setTitle:@"公司动态" forState:UIControlStateNormal];
//    [btn_aboutUs addTarget:self action:@selector(companyNews)forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:btn_aboutUs];
//    
//    UIButton *btn_Terms = [UIButton buttonWithType:UIButtonTypeRoundedRect];
//    btn_Terms.frame = CGRectMake(30, 100, 260, 50);
//    [btn_Terms setTitle:@"热点新闻" forState:UIControlStateNormal];
//    [btn_Terms addTarget:self action:@selector(Focus)forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:btn_Terms];
//    
//    UIButton *btn_FAQ = [UIButton buttonWithType:UIButtonTypeRoundedRect];
//    btn_FAQ.frame = CGRectMake(30, 170, 260, 50);
//    [btn_FAQ setTitle:@"互动平台" forState:UIControlStateNormal];
//    [btn_FAQ addTarget:self action:@selector(BBS)forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:btn_FAQ];
//    
//}


-(void)companyNews
{
    CompanyNews *cn = [[CompanyNews alloc] init];
    [self.navigationController pushViewController:cn animated:YES];
}

-(void)Focus
{
    CompanyNews *cn = [[CompanyNews alloc] init];
    [self.navigationController pushViewController:cn animated:YES];
    
}

-(void)BBS
{
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"请登录www.4008200972.com访问互动社区"
                                                   delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
	[alert show];
    NSLog(@"访问BBS,请先登陆......");
    
    
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
    
    //cell.contentView.backgroundColor = [UIColor clearColor];
    cell.backgroundColor = [UIColor clearColor];

    [cell setSelectionStyle:UITableViewCellSelectionStyleGray];
    
    return cell;
    
}


-(void)boxchecked:(id)sender
{
    //[checkname removeFromSuperview];
    //    self.checkname.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"cb_mono_on@2x"]];
    
}

-(void)seeDetail
{
    NSLog(@"司机详情");
    
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //BNDetailViewController *detailViewController = [[BNDetailViewController alloc] initWithNibName:@"BNDetailViewController" bundle:nil];
    
    //detailViewController.BNName = [self.tableData objectAtIndex:indexPath.row];
    
    //[self.navigationController pushViewController:detailViewController animated:YES];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 55;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
