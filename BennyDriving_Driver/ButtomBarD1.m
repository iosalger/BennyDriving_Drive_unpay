//
//  ButtomBarD1.m
//  BennyDriving_Driver
//
//  Created by ZHOUHONG on 8/25/13.
//  Copyright (c) 2013 BennyDriving. All rights reserved.
//

#import "ButtomBarD1.h"
#import <QuartzCore/QuartzCore.h>

@implementation ButtomBarD1

@synthesize btn_rUnfold,btn_rFold,btn_lFold,btn_lUnfold;
@synthesize pushView,SevNumber,LeftMenu,RightMenu;


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    //[self loadBottomBar];
    
}

#pragma mark -
#pragma mark - UIActionSheetDelegate


-(void)loadBottomBar{

    UIImageView *barbg = [[UIImageView alloc] init];
    barbg.frame = CGRectMake(0, self.view.frame.size.height-50, 320, 50);
    barbg.image = [UIImage imageNamed:@"bottombar_bg_opq.png"];
   [self.view addSubview:barbg];
    
    btn_rUnfold = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn_rUnfold setFrame:CGRectMake(290, self.view.frame.size.height-40, 34, 34)]; 
    [btn_rUnfold setBackgroundImage:[UIImage imageNamed:@"sesame_more_ico@2x"] forState:UIControlStateNormal];   
    [btn_rUnfold addTarget:self action:@selector(unfoldRbar)forControlEvents:UIControlEventTouchUpInside];
    btn_rUnfold.hidden = NO;
    
    
    btn_rFold = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn_rFold setFrame:CGRectMake(290, self.view.frame.size.height-40, 34, 34)];
    //btn_rUnfold.image = [UIImage imageNamed:@"sesame_more_ico@2x"];     
    [btn_rFold setBackgroundImage:[UIImage imageNamed:@"sesame_more_ico_reverse@2x.png"] forState:UIControlStateNormal];    //[btn_rUnfold setImage:image forState:UIControlStateNormal];    
    [btn_rFold addTarget:self action:@selector(foldRbar)forControlEvents:UIControlEventTouchUpInside]; 
    btn_rFold.hidden = YES;
    
    [self.view addSubview:btn_rUnfold];
    [self.view addSubview:btn_rFold];
    
    
    btn_lUnfold = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn_lUnfold setFrame:CGRectMake(10, self.view.frame.size.height-40, 34, 34)]; 
    [btn_lUnfold setBackgroundImage:[UIImage imageNamed:@"sesame_more_ico_reverse@2x.png"] forState:UIControlStateNormal];   
    [btn_lUnfold addTarget:self action:@selector(unfoldLbar)forControlEvents:UIControlEventTouchUpInside];
    btn_lUnfold.hidden = NO;
    
    
    btn_lFold = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn_lFold setFrame:CGRectMake(10, self.view.frame.size.height-40, 34, 34)];  
    [btn_lFold setBackgroundImage:[UIImage imageNamed:@"sesame_more_ico@2x"] forState:UIControlStateNormal];    
    [btn_lFold addTarget:self action:@selector(foldLbar)forControlEvents:UIControlEventTouchUpInside]; 
    btn_lFold.hidden = YES;
    
    [self.view addSubview:btn_lUnfold];
    [self.view addSubview:btn_lFold];
    
    [self loadAnimation];
}

-(void)loadAnimation
{ 
    pushView = [[UIView alloc] initWithFrame:CGRectMake(41,self.view.frame.size.height-50,238,50)]; 
    [self.view addSubview:pushView];
    
    
    SevNumber = [[UIView alloc] initWithFrame:CGRectMake(0,5,238,44)];
    SevNumber.hidden = NO;
    [pushView addSubview:SevNumber];
    
    UIImageView *svnum = [[UIImageView alloc] initWithFrame:CGRectMake(100,0,44,44)];
    svnum.image = [UIImage imageNamed:@"bottombar_400.png"];
    [SevNumber addSubview:svnum];
    
    UIButton *btn_sevNumber = [UIButton buttonWithType:UIButtonTypeCustom];
    btn_sevNumber.frame = CGRectMake(0,0,240,44);
    btn_sevNumber.backgroundColor = [UIColor clearColor];
    [btn_sevNumber addTarget:self action:@selector(dialSerNum)forControlEvents:UIControlEventTouchUpInside];
    [SevNumber addSubview:btn_sevNumber];
    
    
    RightMenu =[[UIView alloc] initWithFrame:CGRectMake(5,5,238,44)];  
    RightMenu.hidden = YES;
    [pushView addSubview:RightMenu];    
    
    UIImageView *rmenu = [[UIImageView alloc] initWithFrame:CGRectMake(0,0,238,44)];
    rmenu.image = [UIImage imageNamed:@"bottombar_dri_rmenu.png"];
    [RightMenu addSubview:rmenu];
    
    UIButton *btn_DriProfile = [UIButton buttonWithType:UIButtonTypeCustom];
    btn_DriProfile.frame = CGRectMake(0,0,78,40);
    btn_DriProfile.backgroundColor = [UIColor clearColor];
    [btn_DriProfile addTarget:self action:@selector(seeDriProfile)forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *btn_DriAccount = [UIButton buttonWithType:UIButtonTypeCustom];
    btn_DriAccount.frame = CGRectMake(80,0,78,40);
    btn_DriAccount.backgroundColor = [UIColor clearColor];
    [btn_DriAccount addTarget:self action:@selector(seeAccount
                                                    )forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *btn_DriRate = [UIButton buttonWithType:UIButtonTypeCustom];
    btn_DriRate.frame = CGRectMake(160,0,78,40);
    btn_DriRate.backgroundColor = [UIColor clearColor];
    [btn_DriRate addTarget:self action:@selector(seeDriRate)forControlEvents:UIControlEventTouchUpInside];
    
    [RightMenu addSubview:rmenu];
    [RightMenu addSubview:btn_DriRate];
    [RightMenu addSubview:btn_DriAccount];
    [RightMenu addSubview:btn_DriProfile];

    
    LeftMenu =[[UIView alloc] initWithFrame:CGRectMake(5,5,238,44)];  
    LeftMenu.hidden = YES;
    [pushView addSubview:LeftMenu];    
    
    UIImageView *lmenu = [[UIImageView alloc] initWithFrame:CGRectMake(0,0,238,44)];
    lmenu.image = [UIImage imageNamed:@"bottombar_dri_lmenu.png"];
    [LeftMenu addSubview:lmenu];
    
    UIButton *btn_seeprice = [UIButton buttonWithType:UIButtonTypeCustom];
    btn_seeprice.frame = CGRectMake(0,0,78,40);
    btn_seeprice.backgroundColor = [UIColor clearColor];
    [btn_seeprice addTarget:self action:@selector(seePriceList)forControlEvents:UIControlEventTouchUpInside];
    [LeftMenu addSubview:btn_seeprice];
    
    UIButton *btn_seecounter = [UIButton buttonWithType:UIButtonTypeCustom];
    btn_seecounter.frame = CGRectMake(80,0,78,40);
    btn_seecounter.backgroundColor = [UIColor clearColor];
    [btn_seecounter addTarget:self action:@selector(goManage)forControlEvents:UIControlEventTouchUpInside];
    [LeftMenu addSubview:btn_seecounter];
    
    
    UIButton *btn_share = [UIButton buttonWithType:UIButtonTypeCustom];
    btn_share.frame = CGRectMake(160,0,78,40);
    btn_share.backgroundColor = [UIColor clearColor];
    [btn_share addTarget:self action:@selector(shareAction)forControlEvents:UIControlEventTouchUpInside];
    [LeftMenu addSubview:btn_share];

    
    //[self.view addSubview:pushView];
    
}



-(void)unfoldRbar
{

    btn_rUnfold.hidden = YES;
    btn_rFold.hidden = NO;
    btn_lUnfold.enabled = NO;
    
    CATransition *animation = [CATransition animation];
    animation.delegate = self;
    animation.duration = 0.3;
    //animation.timingFunction = [CAMediaTimingFunctionfunctionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animation.timingFunction = UIViewAnimationCurveEaseInOut;
    animation.type = kCATransitionPush;
    animation.subtype = kCATransitionFromRight;

    
    NSUInteger number = [[pushView subviews] indexOfObject:SevNumber];
    NSUInteger rimenu = [[pushView subviews] indexOfObject:RightMenu];
    [pushView exchangeSubviewAtIndex:number withSubviewAtIndex:rimenu];
    
    [[pushView layer] addAnimation:animation forKey:@"animation"];   
    
    SevNumber.hidden = YES;
    RightMenu.hidden = NO;
}

-(void)foldRbar
{
    
    btn_rFold.hidden = YES;
    btn_rUnfold.hidden = NO;
    btn_lUnfold.enabled = YES;
    
    CATransition *animation = [CATransition animation];
    animation.delegate = self;
    animation.duration = 0.3;
    //animation.timingFunction = [CAMediaTimingFunctionfunctionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animation.timingFunction = UIViewAnimationCurveEaseInOut;
    animation.type = kCATransitionPush;
    animation.subtype = kCATransitionFromLeft;
    
    
    NSUInteger number = [[pushView subviews] indexOfObject:SevNumber];
    NSUInteger rimenu = [[pushView subviews] indexOfObject:RightMenu];
    [pushView exchangeSubviewAtIndex:number withSubviewAtIndex:rimenu];
    
    [[pushView layer] addAnimation:animation forKey:@"animation"];   
    
    SevNumber.hidden = NO;
    RightMenu.hidden = YES;

    
}

-(void)unfoldLbar
{
    
    btn_lUnfold.hidden = YES;
    btn_lFold.hidden = NO;
    btn_rUnfold.enabled = NO;
    
    CATransition *animation = [CATransition animation];
    animation.delegate = self;
    animation.duration = 0.3;
    //animation.timingFunction = [CAMediaTimingFunctionfunctionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animation.timingFunction = UIViewAnimationCurveEaseInOut;
    animation.type = kCATransitionPush;
    animation.subtype = kCATransitionFromLeft;
    
    
    NSUInteger number = [[pushView subviews] indexOfObject:SevNumber];
    NSUInteger lemenu = [[pushView subviews] indexOfObject:LeftMenu];
    [pushView exchangeSubviewAtIndex:number withSubviewAtIndex:lemenu];
    
    [[pushView layer] addAnimation:animation forKey:@"animation"];   
    
    SevNumber.hidden = YES;
    LeftMenu.hidden = NO;


}

-(void)foldLbar
{
    
    btn_lFold.hidden = YES;
    btn_lUnfold.hidden = NO;
    btn_rUnfold.enabled = YES;
    
    CATransition *animation = [CATransition animation];
    animation.delegate = self;
    animation.duration = 0.3;
    //animation.timingFunction = [CAMediaTimingFunctionfunctionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animation.timingFunction = UIViewAnimationCurveEaseInOut;
    animation.type = kCATransitionPush;
    animation.subtype = kCATransitionFromRight;
    
    
    NSUInteger number = [[pushView subviews] indexOfObject:SevNumber];
    NSUInteger lemenu = [[pushView subviews] indexOfObject:LeftMenu];
    [pushView exchangeSubviewAtIndex:number withSubviewAtIndex:lemenu];
    
    [[pushView layer] addAnimation:animation forKey:@"animation"];   
    
    SevNumber.hidden = NO;
    LeftMenu.hidden = YES;

}



- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

@end
