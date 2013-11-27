//
//  OrderListVC.m
//  BennyDriving_Driver
//
//  Created by ZHOUHONG on 9/9/13.
//  Copyright (c) 2013 BennyDriving. All rights reserved.
//


#import "OrderListVC.h"
#import "OrderUnfold.h"
#import "OrderTableCell.h"
#import "JSONKit.h"
#import "SharedObj.h"
#import "CurrentOrdered.h"
//#import "PullingRefreshTableView.h"
#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"

@interface OrderListVC () <UIFolderTableViewDelegate>

//@property (nonatomic, strong) PullingRefreshTableView* refreshTV;
@property (strong, nonatomic) OrderUnfold *subVc;
@property (strong, nonatomic) NSDictionary *currentCate;


@end

@implementation OrderListVC

//@synthesize cates=_cates;
@synthesize subVc=_subVc;
@synthesize currentCate=_currentCate;
@synthesize tableView=_tableView;
@synthesize Homepic;


//- (void)dealloc
//{
//    //[_cates release];
//    //[_subVc release];
//    //[_currentCate release];
//    //[_tableView release];
//    //[super dealloc];
//}

//-(NSArray *)cates
//{
//    if (_cates == nil){
//        
//        NSURL *url = [[NSBundle mainBundle] URLForResource:@"Category" withExtension:@"plist"];
//        _cates = [[NSArray arrayWithContentsOfURL:url] retain];
//        
//    }
//    
//    return _cates;
//}
-(void)viewWillAppear:(BOOL)animated
{
    [self.navigationItem setTitle:@"抢单池"];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
//    self.navigationController.navigationBar.titleTextAttributes
//    = @{UITextAttributeFont: [UIFont fontWithName:@"Arial" size:18.0],UITextAttributeTextColor: [UIColor whiteColor]};
    [self.navigationItem setTitle:@"抢单池"];

    
    self.view.backgroundColor= [UIColor colorWithPatternImage:[UIImage imageNamed:@"homebg.png"]];
    //self.tableView.backgroundColor = [UIColor clearColor];
    //self.view.backgroundColor = [UIColor blackColor];
    UIImage *HomeBtnImg = [UIImage imageNamed:@"btn_home.png"];
    
    UIButton *homeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    homeBtn.frame = CGRectMake(0, 0, 44, 44);
    [homeBtn addTarget:self action:@selector(handleHome) forControlEvents:UIControlEventTouchUpInside];
    
    [homeBtn setImage:HomeBtnImg forState:UIControlStateNormal];
    UIBarButtonItem *homeButton = [[UIBarButtonItem alloc] initWithCustomView:homeBtn];
    self.navigationItem.rightBarButtonItem = homeButton;
    
    [self setBackLeftBarButtonItem];
}

-(void)setBackLeftBarButtonItem{
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(0, 0, 44, 44);
    
    [backBtn setImage:[UIImage imageNamed:@"btn_back.png"] forState:UIControlStateNormal];
    [backBtn setImage:[UIImage imageNamed:@"btn_back_tapped.png"] forState:UIControlStateHighlighted];
    
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

    OrderTableCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[[OrderTableCell alloc] initWithStyle:UITableViewCellStyleSubtitle 
                                      reuseIdentifier:CellIdentifier] autorelease];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
 
    }
    
//    NSDictionary *cate = [self.cates objectAtIndex:indexPath.row];
//    cell.logo.image = [UIImage imageNamed:[[cate objectForKey:@"imageName"] stringByAppendingString:@".png"]];
    
//网络获取数据
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
//        recArr = [dic1 objectForKey:@"resform"];
//        NSLog(@"xxxxxxx%@",recArr);
//        
//        cell.title.text = [NSString
//                           stringWithFormat:@"订单号：%@                            查看详情",[[recArr objectAtIndex:indexPath.row] objectForKey:@"formid"]];
//        
//    }];
//    [request startSynchronous];

    cell.backgroundColor = [UIColor clearColor];
    cell.contentView.backgroundColor = [UIColor clearColor];

    
    NSString *filePath = [[NSBundle mainBundle]pathForResource:@"driorders" ofType:@"json"];
    NSString *JSONString = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
    NSLog(@"======%@",JSONString);
    
    NSDictionary *dic = [JSONString objectFromJSONString];

    NSMutableArray *recArr = [[NSMutableArray alloc] init];
    recArr = [dic objectForKey:@"orderecord"];
    
    NSLog(@"xxxxxxx%@",recArr);
    
    cell.title.text = [NSString
                       stringWithFormat:@"订单号：%@                 查看详情",[[recArr objectAtIndex:indexPath.row] objectForKey:@"sordid"]];
    cell.title.textColor = [UIColor whiteColor];

    
    
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
    [SharedObj sharedOBJ].indexPathRow_orders = indexPath.row;

    NSLog (@"%d",[SharedObj sharedOBJ].indexPathRow_orders);
    
    NSLog(@"%d",indexPath.row);
    
    OrderUnfold *subVc = [[[OrderUnfold alloc] 
                  initWithNibName:NSStringFromClass([OrderUnfold class]) 
                  bundle:nil] autorelease];
    //NSDictionary *cate = [self.cates objectAtIndex:indexPath.row];
    //subVc.subCates = [cate objectForKey:@"subClass"];
    //self.currentCate = cate;
    //subVc.cateVC = self;
    
    self.tableView.scrollEnabled = NO;
    UIFolderTableView *folderTableView = (UIFolderTableView *)tableView;
    [folderTableView openFolderAtIndexPath:indexPath WithContentView:subVc.view 
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


-(CGFloat)tableView:(UIFolderTableView *)tableView xForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 10;
}

//-(void)subCateBtnAction:(UIButton *)btn
//{
//
//    NSDictionary *subCate = [[self.currentCate objectForKey:@"subClass"] objectAtIndex:btn.tag];
//    NSString *name = [subCate objectForKey:@"name"];
//    UIAlertView *Notpermitted=[[UIAlertView alloc] initWithTitle:@"子类信息"
//                                                         message:[NSString stringWithFormat:@"名称:%@, ID: %@", name, [subCate objectForKey:@"classID"]]
//                                                        delegate:nil
//                                               cancelButtonTitle:@"确认"
//                                               otherButtonTitles:nil];
//    [Notpermitted show];
//    [Notpermitted release];
//}


-(void)getOrder
{
	NSLog(@"你确定要抢单吗？");
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:[NSString stringWithFormat:@"抢单成功"] delegate:self cancelButtonTitle:@"查看当前已接订单" otherButtonTitles:nil];
    alert.tag = 101;
    [alert show];
    
    
}


- (void)alertOKCancelAction
{
	// open a alert with an OK and cancel button
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"抢单确认" message:@"你确定要抢单吗？"
                                                   delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确认", nil];
    alert.tag = 100;
	[alert show];
	
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    NSLog(@"clickedButtonAtIndex:%d",0);
    
    if (alertView.tag == 100 && buttonIndex ==1) {
        
        [self getOrder];
        
    }else if(alertView.tag == 101 && buttonIndex ==0){
        
        CurrentOrdered *curod = [[CurrentOrdered alloc] init];
        [self.navigationController pushViewController:curod animated:YES];
    
    }
        

}

@end
