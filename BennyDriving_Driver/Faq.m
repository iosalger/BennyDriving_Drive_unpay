//
//  ViewController.m
//  BennyDriving_Driver
//
//  Created by 郑 琪 on 13-2-26.
//  Copyright (c) 2013年 郑 琪. All rights reserved.
//

#import "Faq.h"
#import "Cell.h"
#import "SubCateViewController.h"
@interface Faq ()<UITableViewDataSource,UITableViewDelegate,UIFolderTableViewDelegate>
{
    NSMutableArray *_dataList;
    NSMutableArray *_unfoldContent;
    
}
@property (strong, nonatomic) SubCateViewController *subVc;
@property (strong, nonatomic) NSDictionary *currentCate;
@property (assign)BOOL isOpen;
@property (nonatomic,retain)NSIndexPath *selectIndex;
@end

@implementation Faq
@synthesize isOpen,selectIndex;
@synthesize cates=_cates;
@synthesize subVc=_subVc;
@synthesize currentCate=_currentCate;
@synthesize tableView=_tableView;

-(void)viewWillAppear:(BOOL)animated
{
    //self.navigationController.navigationBarHidden=NO;
    self.navigationItem.title = @"常见问题";
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    UIImage *HomeBtnImg = [UIImage imageNamed:@"btn_home.png"];
    UIButton *homeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    homeBtn.frame = CGRectMake(0, 0, 44, 44);
    [homeBtn addTarget:self action:@selector(handleHome) forControlEvents:UIControlEventTouchUpInside];
    
    [homeBtn setImage:HomeBtnImg forState:UIControlStateNormal];
    UIBarButtonItem *homeButton = [[UIBarButtonItem alloc] initWithCustomView:homeBtn];
    self.navigationItem.rightBarButtonItem = homeButton;
    
    [self setBackLeftBarButtonItem];
    
    _tableView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"homebg.png"]];
    self.isOpen = NO;
    _dataList = [NSMutableArray arrayWithObjects:@"问：因网络或者GPS信号不好造成费用异议如何处理？",@"问：贵司对外承诺所派遣的司机均属沪籍，是真的吗？",@"问：贵司服务提供发票吗？",@"问：代驾服务响应速度多久？",@"问：你们的价格优势在于15元/3km，并且最重要的是不分时段，是不是和出租车计费差不多呢？", nil];
    _unfoldContent = [NSMutableArray arrayWithObjects:@"答：公司司机在执行代驾服务中，网络或GPS信号正常的以代驾服务计价器限时收费为准，如因因网络或者GPS信号不好造成费用异议则以司机里程表及司机填写的《代驾服务确认单》信息计算费用为准。",@"答：公司自09年经营代驾服务一直秉承安全的服务，故自始至终都100%选用本地司机。其实这也考虑到了本地司机不仅道路熟悉还是半个导游。",@"答：您支付代驾服务费用中已经包含了发票税收，您可以在发票申请中开到您累积的可开票金额，随时随地可以申请开票，您会在5个工作日内收到到付快递送来的所申请金额的发票。", @"答：直接呼叫司机10分钟内到达，因为我们的代驾司机距离您的位置不超过3km。", @"是的，我们基于出租车的收费模式上做了些调整，让大家能够体验到“代驾服务打车价”的真正实惠。而不是“文字游戏和价格陷进”。",nil];
    
//    UIBarButtonItem *homeButton = [[UIBarButtonItem alloc] initWithTitle:@"主页"                                                                      style:UIBarButtonItemStylePlain target:self action:@selector(handleHome)];
//    self.navigationItem.rightBarButtonItem = homeButton;

    //[self.TableView reloadData];
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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataList.count;
}
- (float)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    Cell *cell = (Cell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell)
    {
        cell = [[[NSBundle mainBundle] loadNibNamed:CellIdentifier owner:self options:nil] objectAtIndex:0];
    }
    NSString *name = [_dataList objectAtIndex:indexPath.row];
    cell.titleLabel.text = name;
    [cell changeArrowWithUp:([self.selectIndex isEqual:indexPath]?YES:NO)];
    
    UILabel *sLine2 = [[UILabel alloc] initWithFrame:CGRectMake(0, 44, 320, 1)];
    sLine2.backgroundColor = [UIColor whiteColor];
    
    //[self.contentView addSubview:sLine1];
    [cell.contentView addSubview:sLine2];
    
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    return cell;
}
#pragma mark - Table view delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Cell *cell = (Cell *)[self.tableView cellForRowAtIndexPath:indexPath];
    //[tableView deselectRowAtIndexPath:indexPath animated:YES];
    [cell changeArrowWithUp:YES];
    SubCateViewController *subVc = [[SubCateViewController alloc]
                                     initWithNibName:NSStringFromClass([SubCateViewController class])
                                     bundle:nil];
    subVc.Info = [_unfoldContent objectAtIndex:indexPath.row];
//    subVc.Info = @"111111111111111111111111111111111111111111111111111111111111111111111111";
    //NSDictionary *cate = [self.cates objectAtIndex:indexPath.row];
    //self.currentCate = cate;
    self.tableView.scrollEnabled = NO;
    UIFolderTableView *folderTableView = (UIFolderTableView *)tableView;
    [folderTableView openFolderAtIndexPath:indexPath WithContentView:subVc.view
                                 openBlock:^(UIView *subClassView, CFTimeInterval duration, CAMediaTimingFunction *timingFunction){
                                     // opening actions
                                     //[self CloseAndOpenACtion:indexPath];
                                 }
                                closeBlock:^(UIView *subClassView, CFTimeInterval duration, CAMediaTimingFunction *timingFunction){
                                    // closing actions
                                    //[self CloseAndOpenACtion:indexPath];
                                    //[cell changeArrowWithUp:NO];
                                }
                           completionBlock:^{
                               // completed actions
                               self.tableView.scrollEnabled = YES;
                               [cell changeArrowWithUp:NO];
                           }];
}

-(void)CloseAndOpenACtion:(NSIndexPath *)indexPath
{
    if ([indexPath isEqual:self.selectIndex]) {
        self.isOpen = NO;
        [self didSelectCellRowFirstDo:NO nextDo:NO];
        self.selectIndex = nil;
    }
    else
    {
        if (!self.selectIndex) {
            self.selectIndex = indexPath;
            [self didSelectCellRowFirstDo:YES nextDo:NO];
            
        }
        else
        {
            [self didSelectCellRowFirstDo:NO nextDo:YES];
        }
    }
}
- (void)didSelectCellRowFirstDo:(BOOL)firstDoInsert nextDo:(BOOL)nextDoInsert
{
    self.isOpen = firstDoInsert;
    
    Cell *cell = (Cell *)[self.tableView cellForRowAtIndexPath:self.selectIndex];
    [cell changeArrowWithUp:firstDoInsert];
    
    if (nextDoInsert) {
        self.isOpen = YES;
        self.selectIndex = [self.tableView indexPathForSelectedRow];
        [self didSelectCellRowFirstDo:YES nextDo:NO];
    }
}

@end
