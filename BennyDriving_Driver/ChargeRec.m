//
//  ChargeRec.m
//  BennyDriving_Driver
//
//  Created by BennyDriving on 8/29/13.
//  Copyright (c) 2013 BennyDriving. All rights reserved.
//

#import "ChargeRec.h"
#import "JSONKit.h"
#import "UIViewController+MJPopupViewController.h"
#import "ChargePopVC.h"

@interface ChargeRec ()<MJSecondPopupDelegate>{
    ChargePopVC *chargePopVC;
}

@end

@implementation ChargeRec

@synthesize chargeRecList,recordInfoArr;

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
    self.navigationItem.title = @"充值记录";
    //self.view.backgroundColor= [UIColor colorWithPatternImage:[UIImage imageNamed:@"homebg.png"]];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    //self.view.backgroundColor= [UIColor colorWithPatternImage:[UIImage imageNamed:@"homebg.png"]];
    self.view.backgroundColor= [UIColor colorWithPatternImage:[UIImage imageNamed:@"homebg.png"]];
    
    UIImage *HomeBtnImg = [UIImage imageNamed:@"btn_home.png"]; 
    UIButton *homeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    homeBtn.frame = CGRectMake(0, 0, 44, 44);
    [homeBtn addTarget:self action:@selector(handleHome) forControlEvents:UIControlEventTouchUpInside];
    
    [homeBtn setImage:HomeBtnImg forState:UIControlStateNormal];
    UIBarButtonItem *homeButton = [[UIBarButtonItem alloc] initWithCustomView:homeBtn];
    self.navigationItem.rightBarButtonItem = homeButton;
    
    [self setBackLeftBarButtonItem];
    
    
    UIImageView *title = [[UIImageView alloc] initWithFrame:CGRectMake(0, 3, 320, 21)];
    title.image = [UIImage imageNamed:@"charge_title"];
    [self.view addSubview:title];
    
    chargeRecList = [[UITableView alloc] initWithFrame:CGRectMake(0, 25, 320, self.view.frame.size.height) style:UITableViewStylePlain];
    chargeRecList.backgroundColor= [UIColor clearColor];
    chargeRecList.dataSource = self;
    chargeRecList.delegate =self;
    [self.view addSubview:chargeRecList];
    
    NSString *filePath = [[NSBundle mainBundle]pathForResource:@"driCharecords" ofType:@"json"];
    NSString *JSONString = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
    NSLog(@"======%@",JSONString);
    
    //NSData *jsonData = [NSData dataWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
    NSDictionary *dic1 = [JSONString objectFromJSONString];
    //
    NSLog(@"ddddddd%@",dic1);
    
    recordInfoArr = [[NSMutableArray alloc] init];
    
    recordInfoArr=[dic1 objectForKey:@"chargeRec"];
    
    NSLog(@"iiiiiii%@",recordInfoArr);

    
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
    
    cell.backgroundColor = [UIColor clearColor];
    UILabel *recbrief = [[UILabel alloc] initWithFrame:CGRectMake(10,2,320,20)];
    recbrief.text = [NSString stringWithFormat:@"%@               %@元                  %@             查看详情", [[recordInfoArr objectAtIndex:indexPath.row] objectForKey:@"crdate"],[[recordInfoArr objectAtIndex:indexPath.row] objectForKey:@"cramount"], [[recordInfoArr objectAtIndex:indexPath.row] objectForKey:@"crstatus"]];
    recbrief.font = [UIFont systemFontOfSize:12];
    recbrief.textColor = [UIColor whiteColor];
    recbrief.backgroundColor = [UIColor clearColor];
    [cell.contentView addSubview:recbrief];
    
    UILabel *time = [[UILabel alloc] initWithFrame:CGRectMake(10,18,320,20)];
    time.text = [NSString stringWithFormat:@"%@ ", [[recordInfoArr objectAtIndex:indexPath.row] objectForKey:@"crtime"]];
    time.font = [UIFont systemFontOfSize:12];
    time.textColor = [UIColor whiteColor];
    time.backgroundColor = [UIColor clearColor];
    [cell.contentView addSubview:time];
    
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    return cell;
    
}



-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    

    chargePopVC = nil;
    chargePopVC = [[ChargePopVC alloc] initWithNibName:@"ChargePopVC" bundle:nil];
    chargePopVC.delegate = self;
    [self presentPopupViewController:chargePopVC animationType:MJPopupViewAnimationFade];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{

    return 40;
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}


// This is just a sample how you could use a popup when you need some userinteraction in it. Use a ivar so it gets not dealloced after fade in
//- (void)popupWithUserInteraction:(id)sender
//{
//    chargePopVC = nil;
//    chargePopVC = [[ChargePopVC alloc] initWithNibName:@"ChargePopVC" bundle:nil];
//    chargePopVC.delegate = self;
//    [self presentPopupViewController:chargePopVC animationType:MJPopupViewAnimationFade];
//}

- (void)cancelButtonClicked:(ChargePopVC *)aSecondDetailViewController
{
    [self dismissPopupViewControllerWithanimationType:MJPopupViewAnimationFade];
    chargePopVC = nil;
}




- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
