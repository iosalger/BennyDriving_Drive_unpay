//
//  ViewController.m
//  BennyDriving_Driver
//
//  Created by 郑 琪 on 13-2-26.
//  Copyright (c) 2013年 郑 琪. All rights reserved.
//

#import "Terms.h"
#import "Cell.h"
#import "SubCateViewController.h"

@interface Terms ()<UITableViewDataSource,UITableViewDelegate,UIFolderTableViewDelegate>
{
    NSMutableArray *_dataList;
    NSMutableArray *_unfoldContent;
    
}
@property (strong, nonatomic) SubCateViewController *subVc;
@property (strong, nonatomic) NSDictionary *currentCate;
@property (assign)BOOL isOpen;
@property (nonatomic,retain)NSIndexPath *selectIndex;
@end

@implementation Terms
@synthesize isOpen,selectIndex,contentList;
@synthesize cates=_cates;
@synthesize subVc=_subVc;
@synthesize currentCate=_currentCate;
@synthesize tableView=_tableView;

-(void)viewWillAppear:(BOOL)animated
{
    //self.navigationController.navigationBarHidden=NO;
    self.navigationItem.title = @"服务协议";
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    //self.view.backgroundColor= [UIColor colorWithPatternImage:[UIImage imageNamed:@"homebg.png"]];
    _tableView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"homebg.png"]];
    
    UIImage *HomeBtnImg = [UIImage imageNamed:@"btn_home.png"];
    UIButton *homeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    homeBtn.frame = CGRectMake(0, 0, 44, 44);
    [homeBtn addTarget:self action:@selector(handleHome) forControlEvents:UIControlEventTouchUpInside];
    
    [homeBtn setImage:HomeBtnImg forState:UIControlStateNormal];
    UIBarButtonItem *homeButton = [[UIBarButtonItem alloc] initWithCustomView:homeBtn];
    self.navigationItem.rightBarButtonItem = homeButton;
    
    [self setBackLeftBarButtonItem];
    
    self.isOpen = NO;
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"AgreeContent" ofType:@"plist"];
    self.contentList = [NSArray arrayWithContentsOfFile:path];
    
    
    _dataList = [NSMutableArray arrayWithObjects:[[self.contentList objectAtIndex:0] valueForKey:@"nameKey"],[[self.contentList objectAtIndex:1] valueForKey:@"nameKey"],[[self.contentList objectAtIndex:2] valueForKey:@"nameKey"],[[self.contentList objectAtIndex:3] valueForKey:@"nameKey"],[[self.contentList objectAtIndex:4] valueForKey:@"nameKey"], nil];
    _unfoldContent = [NSMutableArray arrayWithObjects:[[self.contentList objectAtIndex:0] valueForKey:@"contentKey"],[[self.contentList objectAtIndex:1] valueForKey:@"contentKey"],[[self.contentList objectAtIndex:2] valueForKey:@"contentKey"],[[self.contentList objectAtIndex:3] valueForKey:@"contentKey"],[[self.contentList objectAtIndex:4] valueForKey:@"contentKey"],nil];
        
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
    
    //cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
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
    //subVc.Info.fon
    
    //@"条款1内容,条款1内容,条款1内容,条款1内容,条款1内容,条款1内容,条款1内容,条款1内容,条款1内容,条款1内容,条款1内容,条款1内容,";
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
