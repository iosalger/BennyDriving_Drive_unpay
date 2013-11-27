//
//  MobileMallVC.m
//  BennyDriving_Driver
//
//  Created by BennyDriving on 8/13/13.
//  Copyright (c) 2013 BennyDriving. All rights reserved.
//

#import "MobileMallVC.h"
//#import "ToolDrawerViewB.h"
//#import "InvoiceVC.h"
//#import "ProfileVC.h"
#import "AccountVC.h"
//#import "RecommandVC.h"


@interface MobileMallVC ()

@end

@implementation MobileMallVC

@synthesize dialNum,SerNum,btn_download,bottomBar;

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
    self.view.backgroundColor= [UIColor colorWithPatternImage:[UIImage imageNamed:@"homebg.png"]];
    self.navigationController.navigationBarHidden=NO;
    self.navigationItem.title = @"手机商城";
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
    
    UITextField *mark1 = [[UITextField alloc] initWithFrame:CGRectMake(0, 50, 320, 50)];
    mark1.text = @"使用此功能";
    mark1.textColor = [UIColor whiteColor];
    mark1.textAlignment = NSTextAlignmentCenter;
    mark1.enabled = NO;
    mark1.font = [UIFont systemFontOfSize:28];
    mark1.backgroundColor = [UIColor clearColor];
    [self.view addSubview:mark1];
    
    UITextField *mark2 = [[UITextField alloc] initWithFrame:CGRectMake(0, 120, 320, 50)];
    mark2.text = @"请下载付费版";
    mark2.textColor = [UIColor whiteColor];
    mark2.textAlignment = NSTextAlignmentCenter;
    mark2.enabled = NO;
    mark2.font = [UIFont systemFontOfSize:30];
    mark2.backgroundColor = [UIColor clearColor];
    [self.view addSubview:mark2];
    
    bottomBar = [[UIImageView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height-100, 320, 80)];
    bottomBar.image = [UIImage imageNamed:@"bottombar_bg_opq"];
    
    btn_download = [UIButton buttonWithType:UIButtonTypeCustom];
    btn_download.frame = CGRectMake(60, self.view.frame.size.height-90, 200, 32);
    btn_download.layer.cornerRadius = 3;
    [btn_download setTitle:@"下载付费版" forState:UIControlStateNormal];
    btn_download.titleLabel.font = [UIFont fontWithName:@"Verdana-Bold" size:16.0];
    [btn_download setBackgroundColor:[UIColor colorWithRed:255.0/255.0 green:100.0/255.0 blue:50.0/255.0 alpha:1]];
    [btn_download addTarget:self action:@selector(downloadNOfree) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:bottomBar];
    [self.view addSubview:btn_download];

    //[self loadBottomBar];
    
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


#pragma mark
#pragma mark BottomBar Button Method

-(void)invoice
{
//    InvoiceVC *invoice = [[InvoiceVC alloc] init];
//    [self.navigationController pushViewController:invoice animated:YES];
}

-(void)profile
{
    //ProfileVC *profile = [[ProfileVC alloc] init];
    //[self.navigationController pushViewController:profile animated:YES];
}

-(void)account
{
    AccountVC *account = [[AccountVC alloc] init];
    [self.navigationController pushViewController:account animated:YES];
    
}

-(void)recommand
{
    //RecommandVC *recommand=[[RecommandVC alloc] init];
    //[self.navigationController pushViewController:recommand animated:YES];
    
}

-(void)dialSerNum
{
    // open a dialog with an OK and cancel button
	UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"拨打4008200972"
                                                             delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:@"4008200972" otherButtonTitles:nil];
	actionSheet.actionSheetStyle = UIActionSheetStyleDefault;
	[actionSheet showInView:self.view];
    
    // show from our table view (pops up in the middle of the table)
	
}

#pragma mark -
#pragma mark - UIActionSheetDelegate

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
	// the user clicked one of the OK/Cancel buttons
	if (buttonIndex == 0)
	{
		NSLog(@"ok");
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"tel://4008200972"]];
	}
	else
	{
		NSLog(@"cancel");
	}
}


-(void)handleHome
{
    NSLog(@"Go Home......");
    [[NSNotificationCenter defaultCenter] postNotificationName:@"goHomeVC" object:nil];
}

-(void)downloadNOfree
{

    NSLog(@"Download NonFree Version......");
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
