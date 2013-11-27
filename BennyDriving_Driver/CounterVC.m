//
//  CounterVC.m
//  BennyDriving_Driver
//
//  Created by ZHOUHONG on 8/22/13.
//  Copyright (c) 2013 BennyDriving. All rights reserved.
//

#import "CounterVC.h"
#import "PriceListVC.h"
#import <QuartzCore/QuartzCore.h>

@interface CounterVC ()

@end

@implementation CounterVC

@synthesize counterbg,btn_seePrice,bottomBar;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        //self.view.backgroundColor = [UIColor whiteColor];
        self.navigationItem.title = @"计价器";
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBarHidden=NO;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.view.backgroundColor= [UIColor colorWithPatternImage:[UIImage imageNamed:@"price_bg"]];
    
    UIImage *HomeBtnImg = [UIImage imageNamed:@"btn_home.png"];
    UIButton *homeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    homeBtn.frame = CGRectMake(0, 0, 44, 44);
    [homeBtn addTarget:self action:@selector(handleHome) forControlEvents:UIControlEventTouchUpInside];
    
    [homeBtn setImage:HomeBtnImg forState:UIControlStateNormal];
    UIBarButtonItem *homeButton = [[UIBarButtonItem alloc] initWithCustomView:homeBtn];
    self.navigationItem.rightBarButtonItem = homeButton;
    
    [self setBackLeftBarButtonItem];
    
    [self loadbody];

}

-(void)loadbody
{
    self.counterbg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 348)];
    self.counterbg.image = [UIImage imageNamed:@"counterA"];
    [self.view addSubview:self.counterbg];
    
//    UIButton *btn_toCounter = [UIButton buttonWithType:UIButtonTypeCustom];
//    btn_toCounter.frame = CGRectMake(0, self.view.frame.size.height-88, 320, 44);
//    btn_toCounter.backgroundColor = [UIColor colorWithRed:0.0/255.0 green:130.0/255.0 blue:210.0/255.0 alpha:1];
//    [btn_toCounter setTitle:@"收费标准" forState:UIControlStateNormal];
//    [btn_toCounter addTarget:self action:@selector(seePricelist)forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:btn_toCounter];
    
    
    bottomBar = [[UIImageView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height-100, 320, 80)];
    bottomBar.image = [UIImage imageNamed:@"bottombar_bg_opq"];
    
    btn_seePrice = [UIButton buttonWithType:UIButtonTypeCustom];
    btn_seePrice.frame = CGRectMake(60, self.view.frame.size.height-90, 200, 32);
    btn_seePrice.layer.cornerRadius = 3;
    [btn_seePrice setTitle:@"收费标准" forState:UIControlStateNormal];
    btn_seePrice.titleLabel.font = [UIFont fontWithName:@"Verdana-Bold" size:16.0];
    [btn_seePrice setBackgroundColor:[UIColor colorWithRed:255.0/255.0 green:100.0/255.0 blue:50.0/255.0 alpha:1]];
    [btn_seePrice addTarget:self action:@selector(seePricelist) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:bottomBar];
    [self.view addSubview:btn_seePrice];
    
    
//    UIButton *btn_pause = [UIButton buttonWithType:UIButtonTypeRoundedRect];
//    btn_pause.frame = CGRectMake(50, 315, 60, 36);
//    [btn_pause setTitle:@"暂停" forState:UIControlStateNormal];
//    [btn_pause addTarget:self action:@selector(doPause)forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:btn_pause];
//
//    
//    UIButton *btn_start = [UIButton buttonWithType:UIButtonTypeRoundedRect];
//    btn_start.frame=CGRectMake(130, 315, 60, 36);
//    [btn_start setTitle:@"结束" forState:UIControlStateNormal];
//    [btn_start addTarget:self action:@selector(doStart)forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:btn_start];
//    
//    
//    UIButton *btn_finish = [UIButton buttonWithType:UIButtonTypeRoundedRect];
//    btn_finish.frame = CGRectMake(210, 315, 60, 36);
//    [btn_finish setTitle:@"开始" forState:UIControlStateNormal];
//    [btn_finish addTarget:self action:@selector(doFinish)forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:btn_finish];

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


-(void)seePricelist
{
   // PriceListVC *plvc = [[PriceListVC alloc] init];
   //[self.navigationController pushViewController:plvc animated:YES];
    [self.navigationController popViewControllerAnimated:YES];

}


-(void)handleHome
{
    NSLog(@"Go Home......");
    [[NSNotificationCenter defaultCenter] postNotificationName:@"goHomeVC" object:nil];
}


#pragma mark
#pragma mark Buttons Method
-(void)doPause
{


}

-(void)doStart
{


}

-(void)doFinish
{

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
