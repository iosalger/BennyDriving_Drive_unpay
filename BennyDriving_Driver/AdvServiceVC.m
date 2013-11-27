//
//  AdvServiceVC.m
//  BennyDriving_Driver
//
//  Created by BennyDriving on 8/13/13.
//  Copyright (c) 2013 BennyDriving. All rights reserved.
//

#import "AdvServiceVC.h"
#import "TrafficState.h"
#import "MapViewController.h"
#import "Aid.h"

@interface AdvServiceVC ()

@end

@implementation AdvServiceVC

@synthesize AdvSVTable;
@synthesize AdvSVLst;
@synthesize img_Aid,img_InqueryInfo,img_Searchmap;

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
    self.navigationItem.title = @"高级服务";
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"homebg.png"]];

    img_Searchmap = [[UIImageView alloc] initWithFrame:CGRectMake(5, 5, 100, 35)];
    img_Searchmap.image = [UIImage imageNamed:@"ADSV_Searchmap"];
    
    
    img_InqueryInfo = [[UIImageView alloc] initWithFrame:CGRectMake(5, 5, 100, 35)];
    img_InqueryInfo.image = [UIImage imageNamed:@"ADSV_InqueryInfo"];
    
    img_Aid = [[UIImageView alloc] initWithFrame:CGRectMake(5, 5, 100, 35)];
    img_Aid.image = [UIImage imageNamed:@"ADSV_Aid"];
    
    AdvSVLst = [[NSMutableArray alloc] init];
    AdvSVLst = [NSMutableArray arrayWithObjects:img_Searchmap,img_InqueryInfo,img_Aid,nil];
    
    AdvSVTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 320, self.view.frame.size.height) style:UITableViewStylePlain];
    AdvSVTable.dataSource =self;
    AdvSVTable.delegate =self;
    AdvSVTable.backgroundColor = [UIColor clearColor];
    [self.view addSubview:AdvSVTable];

    UIImage *HomeBtnImg = [UIImage imageNamed:@"btn_home.png"];
    UIButton *homeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    homeBtn.frame = CGRectMake(0, 0, 44, 44);
    [homeBtn addTarget:self action:@selector(handleHome) forControlEvents:UIControlEventTouchUpInside];
    
    [homeBtn setImage:HomeBtnImg forState:UIControlStateNormal];
    UIBarButtonItem *homeButton = [[UIBarButtonItem alloc] initWithCustomView:homeBtn];
    self.navigationItem.rightBarButtonItem = homeButton;
    
    [self setBackLeftBarButtonItem];

    //[self loadBtn];
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


-(void)loadBtn
{
    UIButton *btn_searchMap = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    btn_searchMap.frame = CGRectMake(30, 30, 260, 50);
    [btn_searchMap setTitle:@"搜寻服务" forState:UIControlStateNormal];
    [btn_searchMap addTarget:self action:@selector(searchMap)forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn_searchMap];
    
    UIButton *btn_infoInquery = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    btn_infoInquery.frame = CGRectMake(30, 100, 260, 50);
    [btn_infoInquery setTitle:@"信息查询" forState:UIControlStateNormal];
    [btn_infoInquery addTarget:self action:@selector(infoInqurey)forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn_infoInquery];
    
    UIButton *btn_aid = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    btn_aid.frame = CGRectMake(30, 170, 260, 50);
    [btn_aid setTitle:@"车辆救援" forState:UIControlStateNormal];
    [btn_aid addTarget:self action:@selector(aid)forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn_aid];
    
    
}

-(void)handleHome
{
    NSLog(@"Go Home......");
    [[NSNotificationCenter defaultCenter] postNotificationName:@"goHomeVC" object:nil];
}


-(void)searchMap
{

    MapViewController  *sm = [[MapViewController alloc] init];
    [self.navigationController pushViewController:sm animated:YES];
    
    
}

-(void)infoInqurey
{
    TrafficState *ts = [[TrafficState alloc] init];
    [self.navigationController pushViewController:ts animated:YES];

}

-(void)aid
{
    Aid *infoInqurey = [[Aid alloc] init];
    [self.navigationController pushViewController:infoInqurey animated:YES];

}

#pragma mark - Table View methods

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 3;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    //[cell.contentView addSubview:[[[HelpLstData objectAtIndex:indexPath.section] objectAtIndex: indexPath.row] objectForKey:@"label"]];
    [cell.contentView addSubview:[AdvSVLst objectAtIndex: indexPath.row]];
    
    //cell.contentView.backgroundColor = [UIColor clearColor];
    cell.backgroundColor = [UIColor clearColor];
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    UILabel *sLine2 = [[UILabel alloc] initWithFrame:CGRectMake(0, 44, 320, 1)];
    sLine2.backgroundColor = [UIColor whiteColor];
    
    //[self.contentView addSubview:sLine1];
    [cell.contentView addSubview:sLine2];
    
    AdvSVTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    return cell;
    
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row ==0)
    {
        MapViewController  *sm = [[MapViewController alloc] init];
        [self.navigationController pushViewController:sm animated:YES];

    }else if (indexPath.row ==1)
    {
        TrafficState *ts = [[TrafficState alloc] init];
        [self.navigationController pushViewController:ts animated:YES];
    }else if (indexPath.row ==2)
    {
        Aid *infoInqurey = [[Aid alloc] init];
        [self.navigationController pushViewController:infoInqurey animated:YES];    }
     
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
