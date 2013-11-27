//
//  CurrentOrdered.m
//  BennyDriving_Driver
//
//  Created by ZHOUHONG on 9/1/13.
//  Copyright (c) 2013 BennyDriving. All rights reserved.
//

#import "CurrentOrdered.h"
#import "JSONKit.h"
#import "SharedObj.h"
#import "ResevHisList.h"
#import "CounterActionVC.h"
#import <QuartzCore/QuartzCore.h>


@interface CurrentOrdered ()

@end

@implementation CurrentOrdered

@synthesize bottombar,CurOrderTitle,bottomBar,btn_seeHis;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    
    NSString *filePath = [[NSBundle mainBundle]pathForResource:@"driorders" ofType:@"json"];
    NSString *JSONString = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
    NSLog(@"======%@",JSONString);
    
    NSDictionary *dic = [JSONString objectFromJSONString];
    
    NSMutableArray *recArr = [[NSMutableArray alloc] init];
    recArr = [dic objectForKey:@"orderecord"];
    
    CurOrderTitle = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 83)];
    CurOrderTitle.image = [UIImage imageNamed:@"order_yijie"];
    [self.view addSubview:CurOrderTitle];
    
   UIButton *btn_seeCounter = [UIButton buttonWithType:UIButtonTypeCustom];
    btn_seeCounter.frame = CGRectMake(15, 44, 145, 30);
    btn_seeCounter.layer.cornerRadius = 3;
    //[btn_seeCounter setTitle:@"查看历史预约记录" forState:UIControlStateNormal];
    //btn_seeHis.titleLabel.font = [UIFont fontWithName:@"Verdana-Bold" size:16.0];
    [btn_seeCounter setBackgroundColor:[UIColor colorWithRed:255.0/255.0 green:100.0/255.0 blue:50.0/255.0 alpha:0.0]];
    [btn_seeCounter addTarget:self action:@selector(seeCounter) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:btn_seeCounter];

    
    UILabel *nameValue = [[UILabel alloc] initWithFrame:CGRectMake(160,90,80,20)];
    nameValue.text = [NSString
                      stringWithFormat:@"%@",[[recArr objectAtIndex:[SharedObj sharedOBJ].indexPathRow_orders] objectForKey:@"cutname"]];
    nameValue.textColor = [UIColor whiteColor];
    nameValue.backgroundColor = [UIColor clearColor];
    [self.view addSubview:nameValue];
    

    
    UILabel *timeValue = [[UILabel alloc] initWithFrame:CGRectMake(160,120,80,20)];
    timeValue.text = [NSString
                      stringWithFormat:@"%@",[[recArr objectAtIndex:[SharedObj sharedOBJ].indexPathRow_orders] objectForKey:@"time"]];
    timeValue.textColor = [UIColor whiteColor];
    timeValue.backgroundColor = [UIColor clearColor];
    [self.view addSubview:timeValue];    //
    
    
    UILabel *starValue = [[UILabel alloc] initWithFrame:CGRectMake(160,150,80,20)];
    starValue.text = [NSString
                      stringWithFormat:@"%@",[[recArr objectAtIndex:[SharedObj sharedOBJ].indexPathRow_orders] objectForKey:@"start"]];
     starValue.textColor = [UIColor whiteColor];
     starValue.backgroundColor = [UIColor clearColor];

    [self.view addSubview:starValue];
    //
    
    UILabel *destValue = [[UILabel alloc] initWithFrame:CGRectMake(160,180,80,20)];
    destValue.text = [NSString
                      stringWithFormat:@"%@",[[recArr objectAtIndex:[SharedObj sharedOBJ].indexPathRow_orders] objectForKey:@"dest"]];
    destValue.textColor = [UIColor whiteColor];
    destValue.backgroundColor = [UIColor clearColor];
    [self.view addSubview:destValue];
    
    UILabel *esmilesValue = [[UILabel alloc] initWithFrame:CGRectMake(160,210,80,20)];
    esmilesValue.text = [NSString
                         stringWithFormat:@"%@ 公里",[[recArr objectAtIndex:[SharedObj sharedOBJ].indexPathRow_orders] objectForKey:@"esmiles"]];
    esmilesValue.textColor = [UIColor whiteColor];
    esmilesValue.backgroundColor = [UIColor clearColor];
    [self.view addSubview:esmilesValue];
    
    UILabel *espriceValue = [[UILabel alloc] initWithFrame:CGRectMake(160,240,100,20)];
    espriceValue.text = [NSString
                         stringWithFormat:@"RMB %@ 元",[[recArr objectAtIndex:[SharedObj sharedOBJ].indexPathRow_orders] objectForKey:@"esprice"]];
    espriceValue.textColor = [UIColor whiteColor];
    espriceValue.backgroundColor = [UIColor clearColor];
    [self.view addSubview:espriceValue];
    
    
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

    CounterActionVC *CVC = [[CounterActionVC alloc] init];
    [self.navigationController pushViewController:CVC animated:YES];

}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    //self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"tmall_bg_furley.png"]];
    self.view.backgroundColor= [UIColor colorWithPatternImage:[UIImage imageNamed:@"homebg.png"]];
    UIImage *HomeBtnImg = [UIImage imageNamed:@"btn_home.png"];
    UIButton *homeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    homeBtn.frame = CGRectMake(0, 0, 44, 44);
    [homeBtn addTarget:self action:@selector(handleHome) forControlEvents:UIControlEventTouchUpInside];
    
    [homeBtn setImage:HomeBtnImg forState:UIControlStateNormal];
    UIBarButtonItem *homeButton = [[UIBarButtonItem alloc] initWithCustomView:homeBtn];
    self.navigationItem.rightBarButtonItem = homeButton;
    
    [self setBackLeftBarButtonItem];
    
    self.navigationItem.title = @"预约记录";
    
    UILabel *nameTitle = [[UILabel alloc] initWithFrame:CGRectMake(10,90,80,20)];
    nameTitle.text = @"客户姓名:";
    nameTitle.textColor = [UIColor whiteColor];
    nameTitle.backgroundColor = [UIColor clearColor];
    [self.view addSubview:nameTitle];
    
    UILabel *timeTitle = [[UILabel alloc] initWithFrame:CGRectMake(10,130,80,20)];
    timeTitle.text = @"时间:";
    timeTitle.textColor = [UIColor whiteColor];
    timeTitle.backgroundColor = [UIColor clearColor];
    [self.view addSubview:timeTitle];
    
    
    UILabel *startTitle = [[UILabel alloc] initWithFrame:CGRectMake(10,150,80,20)];
    startTitle.text = @"起点:";
    startTitle.textColor = [UIColor whiteColor];
    startTitle.backgroundColor = [UIColor clearColor];
    [self.view addSubview:startTitle];
    
    
    UILabel *desTitle = [[UILabel alloc] initWithFrame:CGRectMake(10,180,80,20)];
    desTitle.text = @"终点:";
    desTitle.textColor = [UIColor whiteColor];
    desTitle.backgroundColor = [UIColor clearColor];
    [self.view addSubview:desTitle];
    
    UILabel *estmileTitle = [[UILabel alloc] initWithFrame:CGRectMake(10,210,80,20)];
    estmileTitle.text = @"预计里程:";
    estmileTitle.textColor = [UIColor whiteColor];
    estmileTitle.backgroundColor = [UIColor clearColor];
    [self.view addSubview:estmileTitle];
    
    UILabel *estpriceTitle = [[UILabel alloc] initWithFrame:CGRectMake(10,240,80,20)];
    estpriceTitle.text = @"预计价格:";
    estpriceTitle.textColor = [UIColor whiteColor];
    estpriceTitle.backgroundColor = [UIColor clearColor];
    [self.view addSubview:estpriceTitle];
    
    
    //UIButton *btn_getorder = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    //btn_getorder.frame = CGRectMake(30, 190, 260, 40);
    //[btn_getorder setTitle:@"确定抢单" forState:UIControlStateNormal];
    //[btn_getorder addTarget:self.cateVC action:@selector(getOrder)forControlEvents:UIControlEventTouchUpInside];
    //[self.view addSubview:btn_getorder];
    
    // init cates show
    //    int total = self.subCates.count;
    //#define ROWHEIHT 70
    //    int rows = (total / COLUMN) + ((total % COLUMN) > 0 ? 1 : 0);
    //
    //    for (int i=0; i<total; i++) {
    //        int row = i / COLUMN;
    //        int column = i % COLUMN;
    //        NSDictionary *data = [self.subCates objectAtIndex:i];
    //
    //        UIView *view = [[[UIView alloc] initWithFrame:CGRectMake(80*column, ROWHEIHT*row, 80, ROWHEIHT)] autorelease];
    //        view.backgroundColor = [UIColor clearColor];
    //       UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    //        btn.frame = CGRectMake(15, 15, 50, 50);
    //        btn.tag = i;
    //        [btn addTarget:self.cateVC
    //                action:@selector(subCateBtnAction:)
    //      forControlEvents:UIControlEventTouchUpInside];
    //
    //        [btn setBackgroundImage:[UIImage imageNamed:[[data objectForKey:@"imageName"] stringByAppendingFormat:@".png"]]
    //                           forState:UIControlStateNormal];
    //
    //        [view addSubview:btn];
    //
    //        UILabel *lbl = [[[UILabel alloc] initWithFrame:CGRectMake(0, 65, 80, 14)] autorelease];
    //        lbl.textAlignment = UITextAlignmentCenter;
    //        lbl.textColor = [UIColor colorWithRed:204/255.0
    //                                        green:204/255.0
    //                                         blue:204/255.0
    //                                        alpha:1.0];
    //        lbl.font = [UIFont systemFontOfSize:12.0f];
    //        lbl.backgroundColor = [UIColor clearColor];
    //        lbl.text = [data objectForKey:@"name"];
    //        [view addSubview:lbl];
    //
    //        [self.view addSubview:view];
    //    }
    //    
    //    CGRect viewFrame = self.view.frame;
    //    viewFrame.size.height = ROWHEIHT * rows + 19;
    //    self.view.frame = viewFrame;
    
//    self.bottombar = [[UIToolbar alloc] initWithFrame:CGRectMake(0,self.view.frame.size.height-88,320,44)];
//    
//    UIBarButtonItem *button2 = [[UIBarButtonItem alloc] initWithTitle:@"查看历史预约记录"
//                                                                style:UIBarButtonItemStyleBordered
//                                                               target:self
//                                                               action:@selector(OrderedRecHis)];
//    [button2 setWidth:300.0];
    
    bottomBar = [[UIImageView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height-100, 320, 80)];
    bottomBar.image = [UIImage imageNamed:@"bottombar_bg_opq"];
    
    btn_seeHis = [UIButton buttonWithType:UIButtonTypeCustom];
    btn_seeHis.frame = CGRectMake(60, self.view.frame.size.height-90, 200, 32);
    btn_seeHis.layer.cornerRadius = 3;
    [btn_seeHis setTitle:@"查看历史预约记录" forState:UIControlStateNormal];
    btn_seeHis.titleLabel.font = [UIFont fontWithName:@"Verdana-Bold" size:16.0];
    [btn_seeHis setBackgroundColor:[UIColor colorWithRed:255.0/255.0 green:100.0/255.0 blue:50.0/255.0 alpha:1]];
    [btn_seeHis addTarget:self action:@selector(OrderedRecHis) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:bottomBar];
    [self.view addSubview:btn_seeHis];

    
    //[button2 ]
    //    UIBarButtonItem *button3 = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"apple_icon.png"]
    //                                                                style:UIBarButtonItemStyleBordered
    //                                                               target:self
    //                                                               action:@selector(buttonClick:)];
//    UIBarButtonItem *button3 = [[UIBarButtonItem alloc] initWithTitle:@"查看完成订单"
//                                                                style:UIBarButtonItemStyleBordered
//                                                               target:self
//                                                               action:@selector(FinSevRec)];
//    [button3 setWidth:150.0];
    
    
    
//    NSArray *buttons = [[NSArray alloc] initWithObjects:button2,nil];
//    [self.bottombar setItems:buttons];
//    [self.view addSubview:self.bottombar];

    
}

-(void)handleHome
{
    NSLog(@"Go Home......");
    [[NSNotificationCenter defaultCenter] postNotificationName:@"goHomeVC" object:nil];
}

-(void)bottomToolbar
{


}

-(void)OrderedRecHis{
    
//    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"查看历史预约记录"
//                                                             delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:@"4008200972" otherButtonTitles:nil];
//	actionSheet.actionSheetStyle = UIActionSheetStyleDefault;
//	[actionSheet showInView:self.view];
    ResevHisList *rhl = [[ResevHisList alloc] init];
    [self.navigationController pushViewController:rhl animated:YES];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
