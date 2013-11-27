//
//  CateViewController.m
//  top100
//
//  Created by Dai Cloud on 12-7-11.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "ResevHisList.h"
#import "UnfoldResevHis.h"
#import "ResevHisCell.h"
#import "JSONKit.h"
#import "SharedObj.h"
#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"
#import "UnfoldSevFindRec.h"
//#import "UnfoldFinRec.h"


@interface ResevHisList () <UIFolderTableViewDelegate>

@property (strong, nonatomic) UnfoldResevHis *subVc1;
@property (strong, nonatomic) UnfoldSevFindRec *subVc2;
@property (strong, nonatomic) NSDictionary *currentCate;
@property (strong, nonatomic) UIButton *btn_FinRec;
@property (strong, nonatomic) UIButton *btn_ResevRec;


@end

@implementation ResevHisList

@synthesize cates=_cates;
@synthesize subVc1=_subVc1;
@synthesize subVc2 = _subVc2;
@synthesize currentCate=_currentCate;
@synthesize tableView=_tableView;
@synthesize fin=_fin;
@synthesize resevhis = _resevhis;
@synthesize btn_FinRec = _btn_FinRec;
@synthesize btn_ResevRec = _btn_ResevRec;



- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //self.tableView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"tmall_bg_furley.png"]];
self.view.backgroundColor= [UIColor colorWithPatternImage:[UIImage imageNamed:@"homebg.png"]];
    
    UIImage *HomeBtnImg = [UIImage imageNamed:@"btn_home.png"];
    UIButton *homeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    homeBtn.frame = CGRectMake(0, 0, 44, 44);
    [homeBtn addTarget:self action:@selector(handleHome) forControlEvents:UIControlEventTouchUpInside];
    
    [homeBtn setImage:HomeBtnImg forState:UIControlStateNormal];
    UIBarButtonItem *homeButton = [[UIBarButtonItem alloc] initWithCustomView:homeBtn];
    self.navigationItem.rightBarButtonItem = homeButton;
    
    _tableView.backgroundColor= [UIColor colorWithPatternImage:[UIImage imageNamed:@"homebg.png"]];
    
    [self setBackLeftBarButtonItem];

    
    self.navigationItem.title = @"历史订单";

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

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

-(void)backAction
{
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    //return self.cates.count;
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"cate_cell";

    ResevHisCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[[ResevHisCell alloc] initWithStyle:UITableViewCellStyleSubtitle 
                                      reuseIdentifier:CellIdentifier] autorelease];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
 
    }
    
//    NSDictionary *cate = [self.cates objectAtIndex:indexPath.row];
//    cell.logo.image = [UIImage imageNamed:[[cate objectForKey:@"imageName"] stringByAppendingString:@".png"]];
    //NSString *urlString = [NSString stringWithFormat:@"http://demo.4008200972.com/vip/jk/url.php?driid=291&action=dri-qdc"];

//网络接口
//    NSString *urlString = [NSString stringWithFormat:@"http://demo.4008200972.com/vip/jk/url.php?driid=291&action=dri-yjddcx"];
    
    //NSString *urlString = [NSString stringWithFormat:@"http://www.4008200972.com/vip/jk/url.php?driid=58&action=dri-acc"];
//    NSURL *url = [NSURL URLWithString:urlString];
//    NSLog(@"%@",url);
    
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
//        recArr = [dic1 objectForKey:@"resform"];
//        NSLog(@"xxxxxxx%@",recArr);
//
//        cell.title.text = [NSString
//                                    stringWithFormat:@"订单号：%@",[[recArr objectAtIndex:indexPath.row] objectForKey:@"id"]];
//        
//    }];
//    [request startSynchronous];
//
    //NSMutableArray *btnArray = [[NSMutableArray alloc] init];
    //NSMutableArray *btntagArr = [[NSMutableArray alloc] init];
    //int i = 0;
    //for (i=0; i<5; i++) {
        self.btn_FinRec = [UIButton buttonWithType:UIButtonTypeCustom];
        self.btn_FinRec.frame = CGRectMake(254, 10, 64, 32);
    //    self.btn_Fin.tag = i+1;
        //[SharedObj sharedOBJ].btntag=self.btn_arrow.tag;
        //NSLog(@"Data %d",[SharedObj sharedOBJ].btntag);
        //NSLog(@"self %d",self.btn_arrow.tag);
        //[SharedObj sharedOBJ].indexPathRow = i;
        [self.btn_FinRec addTarget:self action:@selector(FinDetail:) forControlEvents:UIControlEventTouchUpInside];
  //      [btnArray  addObject:self.btn_Fin];
   //     NSNumber *num = [NSNumber numberWithInt:self.btn_Fin.tag];
   //     [btntagArr addObject:num];
        
  //  }
  //
   // NSLog(@"%@",btnArray);
    
    
    //NSLog(@"%@",[btnArray objectAtIndex:[SharedObj sharedOBJ].indexPathRow]);
    //UIButton *btnNext = [UIButton new];
    //btnNext = [btnArray objectAtIndex:indexPath.row];
    //self.btn_Fin = [btnArray objectAtIndex:indexPath.row];
    
    [cell.contentView addSubview:self.btn_FinRec];
    
    self.btn_ResevRec = [UIButton buttonWithType:UIButtonTypeCustom];
    self.btn_ResevRec.frame = CGRectMake(180, 10, 64, 32);
   [self.btn_ResevRec addTarget:self action:@selector(ResvDetail:) forControlEvents:UIControlEventTouchUpInside];
   [cell.contentView addSubview:self.btn_ResevRec];

    
    NSString *filePath = [[NSBundle mainBundle]pathForResource:@"driorders" ofType:@"json"];
    NSString *JSONString = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
    NSLog(@"======%@",JSONString);
    
    NSDictionary *dic = [JSONString objectFromJSONString];

    NSMutableArray *recArr = [[NSMutableArray alloc] init];
    recArr = [dic objectForKey:@"orderecord"];
    
        
    cell.title.text = [NSString
                       stringWithFormat:@"订单号：%@",[[recArr objectAtIndex:indexPath.row] objectForKey:@"sordid"]];
    
 

    
    
    //cell.contentView.frame.size.height = 40;
    
//    NSMutableArray *subTitles = [[NSMutableArray alloc] init];
//    NSArray *subClass = [cate objectForKey:@"subClass"];
//    for (int i=0; i < MIN(4,  subClass.count); i++) {
//        [subTitles addObject:[[subClass objectAtIndex:i] objectForKey:@"name"]];
//    }
//    cell.subTtile.text = [subTitles componentsJoinedByString:@"/"];
//    [subTitles release];
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    [SharedObj sharedOBJ].indexPathRow_orders = indexPath.row;
//
//    NSLog (@"%d",[SharedObj sharedOBJ].indexPathRow_orders);
//    
//    NSLog(@"%d",indexPath.row);
//    
//    UnfoldResevHis *subVc = [[[UnfoldResevHis alloc] 
//                  initWithNibName:NSStringFromClass([UnfoldResevHis class]) 
//                  bundle:nil] autorelease];
//    NSDictionary *cate = [self.cates objectAtIndex:indexPath.row];
//    subVc.subCates = [cate objectForKey:@"subClass"];
//    self.currentCate = cate;
//    subVc.cateVC = self;
//    
//    self.tableView.scrollEnabled = NO;
//    UIFolderTableView *folderTableView = (UIFolderTableView *)tableView;
//    [folderTableView openFolderAtIndexPath:indexPath WithContentView:subVc.view 
//                                 openBlock:^(UIView *subClassView, CFTimeInterval duration, CAMediaTimingFunction *timingFunction){
//                                     // opening actions
//                                 } 
//                                closeBlock:^(UIView *subClassView, CFTimeInterval duration, CAMediaTimingFunction *timingFunction){
//                                    // closing actions
//                                } 
//                           completionBlock:^{
//                               // completed actions
//                               self.tableView.scrollEnabled = YES;
//                           }];
//    
}



-(CGFloat)tableView:(UIFolderTableView *)tableView xForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 10;
}


-(void)FinDetail:(id)sender
{
    
    self.btn_FinRec = (UIButton *)sender;
    //NSInteger tag = self.btn_arrow.tag;
    UITableViewCell *myCell=(UITableViewCell *)[[self.btn_FinRec superview]superview];
    
    
    [SharedObj sharedOBJ].indexPathRow_orders = [self.tableView indexPathForCell:myCell].row;
    
    NSLog (@"%d",[SharedObj sharedOBJ].indexPathRow_orders);
    
    
    NSLog(@"%d",[self.tableView indexPathForCell:myCell].row);
    
    
    
    UnfoldResevHis *subVc = [[[UnfoldResevHis alloc]
                                initWithNibName:NSStringFromClass([UnfoldResevHis class])
                                bundle:nil] autorelease];
    NSDictionary *cate = [self.cates objectAtIndex:[self.tableView indexPathForCell:myCell].row];
    subVc.subCates = [cate objectForKey:@"subClass"];
    self.currentCate = cate;
    subVc.cateVC = self;
    
    self.tableView.scrollEnabled = NO;
    UIFolderTableView *folderTableView = (UIFolderTableView *)_tableView;
    [folderTableView openFolderAtIndexPath:[self.tableView indexPathForCell:myCell] WithContentView:subVc.view
                                 openBlock:^(UIView *subClassView, CFTimeInterval duration, CAMediaTimingFunction *timingFunction){
                                     // opening actions
                                 }
                                closeBlock:^(UIView *subClassView, CFTimeInterval duration, CAMediaTimingFunction *timingFunction){
                                    // closing actions
                                }
                           completionBlock:^{
                               // completed actions
                               self.tableView.scrollEnabled = YES;
                           }];
    
}

-(void)ResvDetail:(id)sender
{
    
    self.btn_ResevRec = (UIButton *)sender;
    //NSInteger tag = self.btn_arrow.tag;
    UITableViewCell *myCell=(UITableViewCell *)[[self.btn_ResevRec superview]superview];
    
    
    [SharedObj sharedOBJ].indexPathRow_orders = [self.tableView indexPathForCell:myCell].row;
    
    NSLog (@"%d",[SharedObj sharedOBJ].indexPathRow_orders);
    
    
    NSLog(@"%d",[self.tableView indexPathForCell:myCell].row);
    
    
    
    UnfoldSevFindRec *subVcFR = [[[UnfoldSevFindRec alloc]
                                initWithNibName:NSStringFromClass([UnfoldSevFindRec class])
                                bundle:nil] autorelease];
    NSDictionary *cate = [self.cates objectAtIndex:[self.tableView indexPathForCell:myCell].row];
    subVcFR.subCates = [cate objectForKey:@"subClass"];
    self.currentCate = cate;
    subVcFR.cateVC = self;
    
    
    self.tableView.scrollEnabled = NO;
    UIFolderTableView *folderTableView = (UIFolderTableView *)_tableView;
    [folderTableView openFolderAtIndexPath:[self.tableView indexPathForCell:myCell] WithContentView:subVcFR.view
                                 openBlock:^(UIView *subClassView, CFTimeInterval duration, CAMediaTimingFunction *timingFunction){
                                     // opening actions
                                 }
                                closeBlock:^(UIView *subClassView, CFTimeInterval duration, CAMediaTimingFunction *timingFunction){
                                    // closing actions
                                }
                           completionBlock:^{
                               // completed actions
                               self.tableView.scrollEnabled = YES;
                           }];
    
}


@end
