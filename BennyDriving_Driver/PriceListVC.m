//
//  PriceListVC.m
//  BennyDriving_Driver
//
//  Created by ZHOUHONG on 8/13/13.
//  Copyright (c) 2013 BennyDriving. All rights reserved.
//

#import "PriceListVC.h"
#import "CounterVC.h"
#import <QuartzCore/QuartzCore.h>

@interface PriceListVC ()

@end

@implementation PriceListVC

@synthesize prlist,prTable,btn_seeCounter,bottomBar;
@synthesize mileValue,dayprice,nightprice,mileZero,mileMax;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
     //self.view.backgroundColor = [UIColor blackColor];
     self.navigationItem.title = @"收费标准";
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
    
    [self loadSlider];
    
}

-(void)loadSlider
{
    self.slider = [[TLTiltSlider alloc] initWithFrame:CGRectMake(5, 300, 300, 50)];
    [self.view addSubview:self.slider];
    
    self.slider.minimumValue = 0;//指定可变最小值
	self.slider.maximumValue = 100;//指定可变最大值
	self.slider.value = 0;//指定初始值
	[self.slider addTarget:self action:@selector(sliderChanged:) forControlEvents:UIControlEventValueChanged];
    
    mileZero = [[UILabel alloc] init];
    mileZero.frame = CGRectMake(10, 330, 300, 40);
    mileZero.textAlignment = NSTextAlignmentLeft;
    mileZero.text = @"0 KM";
    mileZero.textColor = [UIColor colorWithRed:246.0/255.0 green:78.0/255.0 blue:71.0/255.0 alpha:1];
    mileZero.font = [UIFont systemFontOfSize:14.0];
    mileZero.backgroundColor = [UIColor clearColor];
    [self.view addSubview:mileZero];
    
    mileMax = [[UILabel alloc] init];
    mileMax.frame = CGRectMake(10, 285, 290, 40);
    mileMax.textAlignment = NSTextAlignmentRight;
    mileMax.text = @"100 KM";
    mileMax.textColor = [UIColor colorWithRed:246.0/255.0 green:78.0/255.0 blue:71.0/255.0 alpha:1];
    mileMax.font = [UIFont systemFontOfSize:14.0];
    mileMax.backgroundColor = [UIColor clearColor];
    [self.view addSubview:mileMax];
    
    mileValue = [[UILabel alloc] init];
    mileValue.frame = CGRectMake(0, 240, 320, 40);
    mileValue.textAlignment = NSTextAlignmentCenter;
    mileValue.text = [NSString stringWithFormat:@"您所选择的公里数为:  %.0f KM",self.slider.value];
    mileValue.textColor = [UIColor colorWithRed:246.0/255.0 green:78.0/255.0 blue:71.0/255.0 alpha:1];
    mileValue.font = [UIFont systemFontOfSize:14.0];
    mileValue.backgroundColor = [UIColor clearColor];
    [self.view addSubview:mileValue];
    
    dayprice = [[UILabel alloc] init];
    dayprice.frame = CGRectMake(0, 180, 320, 40);
    dayprice.textAlignment = NSTextAlignmentCenter;
    dayprice.textColor = [UIColor colorWithRed:246.0/255.0 green:78.0/255.0 blue:71.0/255.0 alpha:1];
    dayprice.font = [UIFont systemFontOfSize:14.0];
    dayprice.backgroundColor = [UIColor clearColor];
    //dayprice.text = [NSString stringWithFormat:@"白天价格:::%.0f",self.slider.value*4.0];
    if (self.slider.value <= 10) {
        dayprice.text = [NSString stringWithFormat:@"白天价格:   %.0f 元",self.slider.value*2.0];
    }else if( self.slider.value >= 10) {
        dayprice.text = [NSString stringWithFormat:@"白天价格:   %.0f 元",self.slider.value*4.0];
    }
    [self.view addSubview:dayprice];
    
    
    nightprice = [[UILabel alloc] init];
    nightprice.frame = CGRectMake(0, 200, 320, 40);
    nightprice.textAlignment = NSTextAlignmentCenter;
    nightprice.textColor = [UIColor colorWithRed:246.0/255.0 green:78.0/255.0 blue:71.0/255.0 alpha:1];
    nightprice.font = [UIFont systemFontOfSize:14.0];
    nightprice.backgroundColor = [UIColor clearColor];
    if (self.slider.value <= 10){
        nightprice.text = [NSString stringWithFormat:@"夜间价格:   %.0f 元",self.slider.value*4.0];}else if( self.slider.value >= 10)
        {
            nightprice.text = [NSString stringWithFormat:@"夜间价格:   %.0f 元",self.slider.value*6.0];
        }
    [self.view addSubview:nightprice];


}

- (void)sliderChanged:(TLTiltSlider*)sender
{
    mileValue.text = [NSString stringWithFormat:@"您所选择的公里数为:  %.0f KM",sender.value];
    
    if (sender.value<3){
        
        dayprice.text = @"白天价格:  15 元";
    }
    else if (sender.value>=3 && sender.value <= 10) {
        dayprice.text = [NSString stringWithFormat:@"白天价格:   %.0f 元",sender.value*2.0+15];
    }else if( sender.value >= 10) {
        dayprice.text = [NSString stringWithFormat:@"白天价格:   %.0f 元",sender.value*4.0+15];
    }
    
    if (sender.value <3) {
        nightprice.text = @"夜间价格:  15 元";
    }
    if (sender.value>=3 && sender.value <= 10){
        
        nightprice.text = [NSString stringWithFormat:@"夜间价格:   %.0f 元",sender.value*4.0+15];
        
    }else if(sender.value >= 10)
    {
        
        nightprice.text = [NSString stringWithFormat:@"夜间价格:   %.0f 元",sender.value*6.0+15];
    }
    
}


-(void)loadbody
{
//    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(0, 20, 320, 24)];
//    title.text = @"收费标准";
//    title.textAlignment = UITextAlignmentCenter;
//    title.font = [UIFont systemFontOfSize:20.0];
//    [self.view addSubview:title];
    
    prlist = [[UIImageView alloc] initWithFrame:CGRectMake(0, 20, 320, 140)];
    prlist.image = [UIImage imageNamed:@"price_table"];
    [self.view addSubview:prlist];
    
//    UIButton *btn_toCounter = [UIButton buttonWithType:UIButtonTypeCustom];
//    btn_toCounter.frame = CGRectMake(0, self.view.frame.size.height-88, 320, 44);
//    btn_toCounter.backgroundColor = [UIColor colorWithRed:0.0/255.0 green:130.0/255.0 blue:210.0/255.0 alpha:1];
//    [btn_toCounter setTitle:@"计价器" forState:UIControlStateNormal];
//    [btn_toCounter addTarget:self action:@selector(seeCounter)forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:btn_toCounter];
    
    bottomBar = [[UIImageView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height-100, 320, 80)];
    bottomBar.image = [UIImage imageNamed:@"bottombar_bg_opq"];
    
    btn_seeCounter = [UIButton buttonWithType:UIButtonTypeCustom];
    btn_seeCounter.frame = CGRectMake(60, self.view.frame.size.height-90, 200, 32);
    btn_seeCounter.layer.cornerRadius = 3;
    [btn_seeCounter setTitle:@"计价器" forState:UIControlStateNormal];
    btn_seeCounter.titleLabel.font = [UIFont fontWithName:@"Verdana-Bold" size:16.0];
    [btn_seeCounter setBackgroundColor:[UIColor colorWithRed:255.0/255.0 green:100.0/255.0 blue:50.0/255.0 alpha:1]];
    [btn_seeCounter addTarget:self action:@selector(seeCounter) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:bottomBar];
    [self.view addSubview:btn_seeCounter];


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


-(void)seeCounter
{
    CounterVC *counter = [[CounterVC alloc] init];
    [self.navigationController pushViewController:counter animated:YES];
    
}

-(void)handleHome
{
    NSLog(@"Go Home......");
    [[NSNotificationCenter defaultCenter] postNotificationName:@"goHomeVC" object:nil];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
