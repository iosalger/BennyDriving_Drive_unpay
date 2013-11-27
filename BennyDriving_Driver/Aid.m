//
//  Aid.m
//  BennyDriving_Driver
//
//  Created by ZHOU HONG on 8/15/13.
//  Copyright (c) 2013 BennyDriving. All rights reserved.
//

#import "Aid.h"
#import <QuartzCore/QuartzCore.h>

@implementation Aid

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
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
}
*/

-(void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBarHidden=NO;
    self.navigationItem.title = @"车辆救援";
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor= [UIColor colorWithPatternImage:[UIImage imageNamed:@"homebg.png"]];
    
    
    
    UIImage *HomeBtnImg = [UIImage imageNamed:@"btn_home.png"]; 
    UIButton *homeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    homeBtn.frame = CGRectMake(0, 0, 44, 44);
    [homeBtn addTarget:self action:@selector(handleHome) forControlEvents:UIControlEventTouchUpInside];
    
    [homeBtn setImage:HomeBtnImg forState:UIControlStateNormal];
    UIBarButtonItem *homeButton = [[UIBarButtonItem alloc] initWithCustomView:homeBtn];
    self.navigationItem.rightBarButtonItem = homeButton;
    
    [self setBackLeftBarButtonItem];
    
    CALayer *bglayer = [CALayer layer];
    bglayer.backgroundColor = [UIColor colorWithRed: 0.0 green:0.0 blue:0.0 alpha:0.3].CGColor;
    bglayer.shadowOffset = CGSizeMake(0, 2);
    bglayer.shadowRadius = 3.0;
    bglayer.shadowColor = [UIColor lightGrayColor].CGColor;
    bglayer.shadowOpacity = 1;
    bglayer.frame = CGRectMake(15, 15, 290, self.view.frame.size.height-75);
    //sublayer.borderColor = [UIColor blackColor].CGColor;
    //sublayer.borderWidth = 1.0;
    bglayer.cornerRadius = 5.0;
    [self.view.layer addSublayer:bglayer];
    
    
    UITextField *mark4 = [[UITextField alloc] initWithFrame:CGRectMake(0, 60, 320, 50)];
    mark4.text = @"需要车辆救援服务,请点击按钮拨打";
    mark4.textAlignment = NSTextAlignmentCenter;
    mark4.enabled = NO;
    mark4.font = [UIFont systemFontOfSize:14];
    mark4.backgroundColor = [UIColor clearColor];
    mark4.textColor = [UIColor whiteColor];
    [self.view addSubview:mark4];
    
    UIButton *btn_dialAidNum = [UIButton buttonWithType:UIButtonTypeCustom];
    btn_dialAidNum.frame = CGRectMake(40, 100, 240, 44);
    [btn_dialAidNum setTitle:@"拨打4008208889" forState:UIControlStateNormal];
    btn_dialAidNum.layer.cornerRadius = 3;
    btn_dialAidNum.titleLabel.font = [UIFont fontWithName:@"Verdana-Bold" size:16.0];
    [btn_dialAidNum setBackgroundColor:[UIColor colorWithRed:255.0/255.0 green:100.0/255.0 blue:50.0/255.0 alpha:1]];

    [btn_dialAidNum addTarget:self action:@selector(dialAidNum)forControlEvents:UIControlEventTouchUpInside];
    
    //btn_download = [UIButton buttonWithType:UIButtonTypeCustom];
    //btn_download.frame = CGRectMake(60, self.view.frame.size.height-90, 200, 32);
    //btn_download.layer.cornerRadius = 3;
    //[btn_download setTitle:@"下载付费版" forState:UIControlStateNormal];
    //btn_download.titleLabel.font = [UIFont fontWithName:@"Verdana-Bold" size:16.0];
    //[btn_download setBackgroundColor:[UIColor colorWithRed:255.0/255.0 green:100.0/255.0 blue:50.0/255.0 alpha:1]];
    //[btn_download addTarget:self action:@selector(downloadNOfree) forControlEvents:UIControlEventTouchDown];
    
    [self.view addSubview:btn_dialAidNum];
    
    UITextField *mark1 = [[UITextField alloc] initWithFrame:CGRectMake(0, 180, 320, 50)];
    mark1.text = @"车辆救援服务收费300元/次";
    mark1.textAlignment = NSTextAlignmentCenter;
    mark1.enabled = NO;
    mark1.font = [UIFont systemFontOfSize:20];
    mark1.backgroundColor = [UIColor clearColor];
    mark1.textColor = [UIColor whiteColor];
    [self.view addSubview:mark1];
    
    UITextField *mark2 = [[UITextField alloc] initWithFrame:CGRectMake(0, 230, 320, 50)];
    mark2.text = @"购“驾车宝典”车主卡";
    mark2.textAlignment = NSTextAlignmentCenter;
    mark2.enabled = NO;
    mark2.font = [UIFont systemFontOfSize:20];
    mark2.backgroundColor = [UIColor clearColor];
    mark2.textColor =[UIColor whiteColor];
    [self.view addSubview:mark2];
    
    UITextField *mark3 = [[UITextField alloc] initWithFrame:CGRectMake(0, 260, 320, 50)];
    mark3.text = @"享免费车辆救援服务";
    mark3.textAlignment = NSTextAlignmentCenter;
    mark3.enabled = NO;
    mark3.font = [UIFont systemFontOfSize:20];
    mark3.backgroundColor = [UIColor clearColor];
    mark3.textColor = [UIColor whiteColor];
    [self.view addSubview:mark3];


    
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


-(void)dialAidNum
{
    // open a dialog with an OK and cancel button
	UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"拨打车辆救援电话"
                                                             delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:@"4008208889" otherButtonTitles:nil];
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
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"tel://4008208889"]];
	}
	else
	{
		NSLog(@"cancel");
	}
}


- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

@end
