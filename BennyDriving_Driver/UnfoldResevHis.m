//
//  SubCateViewController.m
//  top100
//
//  Created by Dai Cloud on 12-7-13.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "UnfoldResevHis.h"
#import "JSONKit.h"
#import "SharedObj.h"
#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"

//#define COLUMN 4

@interface UnfoldResevHis ()

@end

@implementation UnfoldResevHis

@synthesize subCates=_subCates;
@synthesize cateVC=_cateVC;


- (void)dealloc
{
    [_subCates release];
    [_cateVC release];
    [super dealloc];
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
    
    [self.view addSubview:nameValue];
    
    
    UILabel *timeValue = [[UILabel alloc] initWithFrame:CGRectMake(160,40,80,20)];
    [self.view addSubview:timeValue];    //
    
    
    UILabel *starValue = [[UILabel alloc] initWithFrame:CGRectMake(160,70,80,20)];

    [self.view addSubview:starValue];
    //
    
    UILabel *destValue = [[UILabel alloc] initWithFrame:CGRectMake(160,100,80,20)];
    [self.view addSubview:destValue];
    
    UILabel *esmilesValue = [[UILabel alloc] initWithFrame:CGRectMake(160,130,80,20)];
    [self.view addSubview:esmilesValue];
    
    UILabel *espriceValue = [[UILabel alloc] initWithFrame:CGRectMake(160,160,100,20)];
    [self.view addSubview:espriceValue];

    
//    NSString *urlString = [NSString stringWithFormat:@"http://demo.4008200972.com/vip/jk/url.php?driid=291&action=dri-qdc"];
//    //NSString *urlString = [NSString stringWithFormat:@"http://www.4008200972.com/vip/jk/url.php?driid=58&action=dri-acc"];
//    NSURL *url = [NSURL URLWithString:urlString];
//    NSLog(@"%@",url);
//    
//    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
//    [request setCompletionBlock:^{
//        
//        NSString *JSONString = request.responseString;
//        //JSONString =[JSONString stringByReplacingOccurrencesOfString:@"\'" withString:@"\""];
//        //JSONString =[JSONString stringByReplacingOccurrencesOfString:@"balance" withString:@"\"balance\""];
//        
//        NSLog(@"========%@",JSONString);
//        
//        NSDictionary *dic1 = [JSONString objectFromJSONString];
//        NSLog(@"============JSON=================");
//        NSLog(@"%@cccccccc",dic1);
//        
//        //NSLog(@"====%@",[dic1 objectForKey:@"balance"]);
//        //balanValue.text = [dic1 objectForKey:@"balance"];
//        NSMutableArray *recArr = [[NSMutableArray alloc] init];
//        //recArr = [dic1 objectForKey:@"resform"];
//        recArr = [dic1 objectForKey:@"resform"];
//        NSLog(@"xxxxxxx%@",recArr);
//        
////        nameValue.text = [NSString
////                          stringWithFormat:@"%@",[[recArr objectAtIndex:[SharedObj sharedOBJ].indexPathRow_orders] objectForKey:@"cutname"]];
//        
//            nameValue.text = [NSString
//                                 stringWithFormat:@"%@",[[recArr objectAtIndex:[SharedObj sharedOBJ].indexPathRow_orders] objectForKey:@"username"]];
//
//        
//        
//        starValue.text = [NSString
//                          stringWithFormat:@"%@",[[recArr objectAtIndex:[SharedObj sharedOBJ].indexPathRow_orders] objectForKey:@"start"]];
//        
//        destValue.text = [NSString
//                          stringWithFormat:@"%@",[[recArr objectAtIndex:[SharedObj sharedOBJ].indexPathRow_orders] objectForKey:@"dest"]];
//        
//        esmilesValue.text = [NSString
//                             stringWithFormat:@"%@ 公里",[[recArr objectAtIndex:[SharedObj sharedOBJ].indexPathRow_orders] objectForKey:@"esmiles"]];
//        
//        espriceValue.text = [NSString
//                             stringWithFormat:@"RMB %@ 元",[[recArr objectAtIndex:[SharedObj sharedOBJ].indexPathRow_orders] objectForKey:@"esprice"]];
//        
//        
//        
//        
//    }];
//    [request startSynchronous];
    

    nameValue.text = [NSString
                      stringWithFormat:@"%@",[[recArr objectAtIndex:[SharedObj sharedOBJ].indexPathRow_orders] objectForKey:@"cutname"]];
    nameValue.backgroundColor = [UIColor clearColor];
    nameValue.textColor = [UIColor whiteColor];
    
    timeValue.text = [NSString
                      stringWithFormat:@"%@",[[recArr objectAtIndex:[SharedObj sharedOBJ].indexPathRow_orders] objectForKey:@"time"]];
    timeValue.backgroundColor = [UIColor clearColor];
    timeValue.textColor = [UIColor whiteColor];
    
    starValue.text = [NSString
                      stringWithFormat:@"%@",[[recArr objectAtIndex:[SharedObj sharedOBJ].indexPathRow_orders] objectForKey:@"start"]];
    starValue.backgroundColor = [UIColor clearColor];
    starValue.textColor = [UIColor whiteColor];
    
    destValue.text = [NSString
                      stringWithFormat:@"%@",[[recArr objectAtIndex:[SharedObj sharedOBJ].indexPathRow_orders] objectForKey:@"dest"]];
    destValue.backgroundColor = [UIColor clearColor];
    destValue.textColor = [UIColor whiteColor];
    
    esmilesValue.text = [NSString
                         stringWithFormat:@"%@ 公里",[[recArr objectAtIndex:[SharedObj sharedOBJ].indexPathRow_orders] objectForKey:@"esmiles"]];
    esmilesValue.backgroundColor = [UIColor clearColor];
    esmilesValue.textColor = [UIColor whiteColor];
    
    espriceValue.text = [NSString
                         stringWithFormat:@"RMB %@ 元",[[recArr objectAtIndex:[SharedObj sharedOBJ].indexPathRow_orders] objectForKey:@"esprice"]];
    espriceValue.backgroundColor = [UIColor clearColor];
    espriceValue.textColor = [UIColor whiteColor];
    

}


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    //self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"tmall_bg_furley.png"]];
    self.view.backgroundColor= [UIColor colorWithPatternImage:[UIImage imageNamed:@"homebg.png"]];
    
    UILabel *nameTitle = [[UILabel alloc] initWithFrame:CGRectMake(10,10,80,20)];
    nameTitle.text = @"客户姓名:";
    nameTitle.backgroundColor = [UIColor clearColor];
    nameTitle.textColor = [UIColor whiteColor];
    [self.view addSubview:nameTitle];
    
    UILabel *timeTitle = [[UILabel alloc] initWithFrame:CGRectMake(10,40,80,20)];
    timeTitle.text = @"时间:";
    timeTitle.backgroundColor = [UIColor clearColor];
    timeTitle.textColor = [UIColor whiteColor];
    [self.view addSubview:timeTitle];
    
    
    UILabel *startTitle = [[UILabel alloc] initWithFrame:CGRectMake(10,70,80,20)];
    startTitle.text = @"起点:";
    startTitle.backgroundColor = [UIColor clearColor];
    startTitle.textColor = [UIColor whiteColor];
    [self.view addSubview:startTitle];
    
    
    UILabel *desTitle = [[UILabel alloc] initWithFrame:CGRectMake(10,100,80,20)];
    desTitle.text = @"终点:";
    desTitle.backgroundColor = [UIColor clearColor];
    desTitle.textColor = [UIColor whiteColor];
    [self.view addSubview:desTitle];
    
    UILabel *estmileTitle = [[UILabel alloc] initWithFrame:CGRectMake(10,130,80,20)];
    estmileTitle.text = @"预计里程:";
    estmileTitle.backgroundColor = [UIColor clearColor];
    estmileTitle.textColor = [UIColor whiteColor];
    [self.view addSubview:estmileTitle];
    
    
    UILabel *estpriceTitle = [[UILabel alloc] initWithFrame:CGRectMake(10,160,80,20)];
    estpriceTitle.text = @"预计价格:";
    estpriceTitle.backgroundColor = [UIColor clearColor];
    estpriceTitle.textColor = [UIColor whiteColor];
    [self.view addSubview:estpriceTitle];
    
    
//    UIButton *btn_getorder = [UIButton buttonWithType:UIButtonTypeRoundedRect];
//    btn_getorder.frame = CGRectMake(30, 190, 260, 40);
//    [btn_getorder setTitle:@"确定抢单" forState:UIControlStateNormal];
//    [btn_getorder addTarget:self.cateVC action:@selector(getOrder)forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:btn_getorder];    
    
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
    
}


@end
