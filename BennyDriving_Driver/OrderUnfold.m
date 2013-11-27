//
//  OrderUnfold.m
//  BennyDriving_Driver
//
//  Created by ZHOUHONG on 9/9/13.
//  Copyright (c) 2013 BennyDriving. All rights reserved.
//

#import "OrderUnfold.h"
#import "JSONKit.h"
#import "SharedObj.h"
#import <QuartzCore/QuartzCore.h>
//#define COLUMN 4

@interface OrderUnfold ()

@end

@implementation OrderUnfold

@synthesize subCates=_subCates;
@synthesize cateVC=_cateVC;

- (void)dealloc
{
    //[_subCates release];
    //[_cateVC release];
    //[super dealloc];
}


- (void)viewWillAppear:(BOOL)animated
{
    
    NSString *filePath = [[NSBundle mainBundle]pathForResource:@"driorders" ofType:@"json"];
    NSString *JSONString = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
    NSLog(@"======%@",JSONString);
    
    NSDictionary *dic = [JSONString objectFromJSONString];
    
    NSMutableArray *recArr = [[NSMutableArray alloc] init];
    recArr = [dic objectForKey:@"orderecord"];
    
    UILabel *nameValue = [[UILabel alloc] initWithFrame:CGRectMake(160,10,80,20)];
    nameValue.text = [NSString
                      stringWithFormat:@"%@",[[recArr objectAtIndex:[SharedObj sharedOBJ].indexPathRow_orders] objectForKey:@"cutname"]];
    nameValue.textColor = [UIColor whiteColor];
    nameValue.backgroundColor = [UIColor clearColor];
    [self.view addSubview:nameValue];    
    
    
    UILabel *timeValue = [[UILabel alloc] initWithFrame:CGRectMake(160,40,80,20)];
    timeValue.text = [NSString
                      stringWithFormat:@"%@",[[recArr objectAtIndex:[SharedObj sharedOBJ].indexPathRow_orders] objectForKey:@"time"]];
    timeValue.textColor = [UIColor whiteColor];
    timeValue.backgroundColor = [UIColor clearColor];
    [self.view addSubview:timeValue];    //
    
    
    UILabel *starValue = [[UILabel alloc] initWithFrame:CGRectMake(160,70,80,20)];
    starValue.text = [NSString
                      stringWithFormat:@"%@",[[recArr objectAtIndex:[SharedObj sharedOBJ].indexPathRow_orders] objectForKey:@"start"]];
    starValue.textColor = [UIColor whiteColor];
    starValue.backgroundColor = [UIColor clearColor];
    [self.view addSubview:starValue]; 
    //
    
    UILabel *destValue = [[UILabel alloc] initWithFrame:CGRectMake(160,100,80,20)];
    destValue.text = [NSString
                      stringWithFormat:@"%@",[[recArr objectAtIndex:[SharedObj sharedOBJ].indexPathRow_orders] objectForKey:@"dest"]];
    destValue.textColor = [UIColor whiteColor];
    destValue.backgroundColor = [UIColor clearColor];
    [self.view addSubview:destValue]; 
    
    UILabel *esmilesValue = [[UILabel alloc] initWithFrame:CGRectMake(160,130,80,20)];
    esmilesValue.text = [NSString
                      stringWithFormat:@"%@ 公里",[[recArr objectAtIndex:[SharedObj sharedOBJ].indexPathRow_orders] objectForKey:@"esmiles"]];
    esmilesValue.textColor = [UIColor whiteColor];
    esmilesValue.backgroundColor = [UIColor clearColor];
    [self.view addSubview:esmilesValue]; 
    
    UILabel *espriceValue = [[UILabel alloc] initWithFrame:CGRectMake(160,160,100,20)];
    espriceValue.text = [NSString
                         stringWithFormat:@"RMB %@ 元",[[recArr objectAtIndex:[SharedObj sharedOBJ].indexPathRow_orders] objectForKey:@"esprice"]];
    espriceValue.textColor = [UIColor whiteColor];
    espriceValue.backgroundColor = [UIColor clearColor];
    [self.view addSubview:espriceValue]; 

}


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    //self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"tmall_bg_furley.png"]];
    self.view.backgroundColor= [UIColor colorWithPatternImage:[UIImage imageNamed:@"homebg.png"]];
    
    UILabel *nameTitle = [[UILabel alloc] initWithFrame:CGRectMake(10,10,80,20)];
    nameTitle.text = @"客户姓名:";
    nameTitle.textColor = [UIColor whiteColor];
    nameTitle.backgroundColor = [UIColor clearColor];
    [self.view addSubview:nameTitle];
    
    UILabel *timeTitle = [[UILabel alloc] initWithFrame:CGRectMake(10,40,80,20)];
    timeTitle.text = @"时间:";
    timeTitle.textColor = [UIColor whiteColor];
    timeTitle.backgroundColor = [UIColor clearColor];
    [self.view addSubview:timeTitle];
    
    
    UILabel *startTitle = [[UILabel alloc] initWithFrame:CGRectMake(10,70,80,20)];
    startTitle.text = @"起点:";
    startTitle.textColor = [UIColor whiteColor];
    startTitle.backgroundColor = [UIColor clearColor];
    [self.view addSubview:startTitle];
    
    
    UILabel *desTitle = [[UILabel alloc] initWithFrame:CGRectMake(10,100,80,20)];
    desTitle.text = @"终点:";
    desTitle.textColor = [UIColor whiteColor];
    desTitle.backgroundColor = [UIColor clearColor];
    [self.view addSubview:desTitle];
    
    UILabel *estmileTitle = [[UILabel alloc] initWithFrame:CGRectMake(10,130,80,20)];
    estmileTitle.text = @"预计里程:";
    estmileTitle.textColor = [UIColor whiteColor];
    estmileTitle.backgroundColor = [UIColor clearColor];
    [self.view addSubview:estmileTitle];
    
    
    UILabel *estpriceTitle = [[UILabel alloc] initWithFrame:CGRectMake(10,160,80,20)];
    estpriceTitle.text = @"预计价格:";
    estpriceTitle.textColor = [UIColor whiteColor];
    estpriceTitle.backgroundColor = [UIColor clearColor];
    [self.view addSubview:estpriceTitle];
    
    
    UIButton *btn_getorder = [UIButton buttonWithType:UIButtonTypeCustom];
    btn_getorder.frame = CGRectMake(30, 190, 260, 40);
    btn_getorder.layer.cornerRadius = 3;
    btn_getorder.titleLabel.font = [UIFont fontWithName:@"Verdana-Bold" size:16.0];
    [btn_getorder setBackgroundColor:[UIColor colorWithRed:200.0/255.0 green:20.0/255.0 blue:70.0/255.0 alpha:1]];

    [btn_getorder setTitle:@"确定抢单" forState:UIControlStateNormal];
    [btn_getorder addTarget:self.cateVC action:@selector(alertOKCancelAction)forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn_getorder];    
    
    
}

-(void)getOrder
{
    
    
}


@end
