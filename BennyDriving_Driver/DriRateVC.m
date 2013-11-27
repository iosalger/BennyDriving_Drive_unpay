//
//  DriRateVC.m
//  BennyDriving_Driver
//
//  Created by ZHOUHONG on 8/20/13.
//  Copyright (c) 2013 BennyDriving. All rights reserved.
//

#import "DriRateVC.h"
#import "JSONKit.h"
#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"

@interface DriRateVC ()

@end

@implementation DriRateVC

@synthesize driInfoArr,driComment,dricomTimeArr,dricomDateArr,dricomContentArr;
@synthesize commentTable,bottombar,commentTitle;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        //self.view.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated
{
   self.navigationController.navigationBarHidden = NO;
   self.navigationItem.title = @"用户评价";
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.view.backgroundColor= [UIColor colorWithPatternImage:[UIImage imageNamed:@"homebg.png"]];

    UIImage *HomeBtnImg = [UIImage imageNamed:@"btn_home.png"];
    UIButton *homeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    homeBtn.frame = CGRectMake(0, 0, 44, 44);
    [homeBtn addTarget:self action:@selector(handleHome) forControlEvents:UIControlEventTouchUpInside];
    
    [homeBtn setImage:HomeBtnImg forState:UIControlStateNormal];
    UIBarButtonItem *homeButton = [[UIBarButtonItem alloc] initWithCustomView:homeBtn];
    self.navigationItem.rightBarButtonItem = homeButton;
    
    [self setBackLeftBarButtonItem];

    //[super loadBottomBar];
    commentTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 130, 320, 360) style:UITableViewStylePlain];
    commentTable.dataSource =self;
    commentTable.delegate =self;
    commentTable.backgroundColor = [UIColor clearColor];
    //commentTable.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"homebg.png"]];
    
    [self.view addSubview:commentTable];
    
    //[super loadBottomBar];
    
    //http://www.4008200972.com/vip/jk/url.php?driid=58&action=dri-xgxx
    
    //NSString *urlString = [NSString stringWithFormat:@"http://demo.4008200972.com/vip/jk/url.php?driid=58&action=dri-lsjlcx"];
    //NSString *urlString = [NSString stringWithFormat:@"http://www.4008200972.com/vip/jk/url.php?driid=58&action=dri-acc"];
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
//        NSLog(@"xxxxxxxxxx%@",JSONString);
//        
//        //NSDictionary *dic1 = [JSONString objectFromJSONString];
//        //NSLog(@"============JSON=================");
//        //NSLog(@"%@====",dic1);
//        
//        //NSLog(@"====%@",[dic1 objectForKey:@"balance"]);
//        //balanValue.text = [dic1 objectForKey:@"balance"];
//        
//        
//    }];
//    [request startSynchronous];
    
    NSString *filePath = [[NSBundle mainBundle]pathForResource:@"drirate"ofType:@"json"];
    NSString *JSONString = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
    NSLog(@"======%@",JSONString);
    
    //NSData *jsonData = [NSData dataWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
    
    NSDictionary *dic1 = [JSONString objectFromJSONString];
    
    //
    NSLog(@"ddddddd%@",dic1);
    
    driInfoArr = [dic1 objectForKey:@"driprofile"];
    NSLog(@"基本信息%@",driInfoArr);
    
    driComment = [dic1 objectForKey:@"dricommet"];
    NSLog(@"用户评价%@",driComment);
    
    commentTitle = [[UIImageView alloc] initWithFrame:CGRectMake(0, 80, 320, 50)];
    commentTitle.image = [UIImage imageNamed:@"commenTitle"];
    [self.view addSubview:commentTitle];
    
 // self.bottombar = [[UIToolbar alloc] initWithFrame:CGRectMake(0,100,320,30)];
 //   self.bottombar.tintColor = [UIColor clearColor];
 //   self.bottombar.backgroundColor = [UIColor clearColor];
 // NSMutableArray *myToolBarItems = [NSMutableArray array];
    
//    UILabel *dricommentTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320, 30)];
//    dricommentTitle.font=[UIFont systemFontOfSize:18];
//    dricommentTitle.backgroundColor = [UIColor clearColor];
//    dricommentTitle.textAlignment= UITextAlignmentCenter;
//    dricommentTitle.text = @"评价内容";
//    dricommentTitle.textColor = [UIColor whiteColor];
//    UIBarButtonItem *myButtonItem = [[UIBarButtonItem alloc]initWithCustomView:dricommentTitle];
//    
//    //NSArray *buttons = [[NSArray alloc] initWithObjects:button2,button3,nil];
//    
//    [myToolBarItems addObject:myButtonItem];
//    [self.bottombar setItems:myToolBarItems animated:YES]; 
//    [self.view addSubview:self.bottombar];
    
    [self loadprofile];

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

-(void)loadprofile
{
    
    UIImageView *drihead = [[UIImageView alloc] initWithFrame:CGRectMake(12,12, 64, 64)];
    drihead.image = [UIImage imageNamed:[[driInfoArr objectAtIndex:0] objectForKey:@"Value"]];
    [self.view addSubview:drihead];
    
    UILabel *nameTitle = [[UILabel alloc] initWithFrame:CGRectMake(80,10,50,30)];
    nameTitle.text =[NSString stringWithFormat:@"%@: ",[[driInfoArr objectAtIndex:1] objectForKey:@"Title"]];
    nameTitle.font = [UIFont systemFontOfSize:12.0];
    nameTitle.textColor = [UIColor whiteColor];
    nameTitle.backgroundColor = [UIColor clearColor];
    
    UILabel *nameValue = [[UILabel alloc] initWithFrame:CGRectMake(114, 10, 50, 30)];
    nameValue.text = [[driInfoArr objectAtIndex:1] objectForKey:@"Value"];
    nameValue.font = [UIFont systemFontOfSize:12.0];
    nameValue.textColor = [UIColor whiteColor];
    nameValue.backgroundColor = [UIColor clearColor];
    
    [self.view addSubview:nameTitle];
    [self.view addSubview:nameValue];
    
    
    UILabel *driexpTitle = [[UILabel alloc] initWithFrame:CGRectMake(180,10,100,30)];
    driexpTitle.text =[NSString stringWithFormat:@"%@: ",[[driInfoArr objectAtIndex:3] objectForKey:@"Title"]];
    driexpTitle.font = [UIFont systemFontOfSize:12.0];
    driexpTitle.backgroundColor = [UIColor clearColor];
    driexpTitle.textColor = [UIColor whiteColor];
    
    UILabel *driexpValue = [[UILabel alloc] initWithFrame:CGRectMake(244, 10, 50, 30)];
    driexpValue.text = [[driInfoArr objectAtIndex:3] objectForKey:@"Value"];
    driexpValue.font = [UIFont systemFontOfSize:12.0];
    driexpValue.backgroundColor = [UIColor clearColor];
    driexpValue.textColor = [UIColor whiteColor];
    
    [self.view addSubview:driexpTitle];
    [self.view addSubview:driexpValue];
    
    
    UILabel *driyrsTitle = [[UILabel alloc] initWithFrame:CGRectMake(80,40,50,30)];
    driyrsTitle.text =[NSString stringWithFormat:@"%@: ",[[driInfoArr objectAtIndex:2] objectForKey:@"Title"]];
    driyrsTitle.font = [UIFont systemFontOfSize:12.0];
    driyrsTitle.backgroundColor = [UIColor clearColor];
    driyrsTitle.textColor = [UIColor whiteColor];
    
    UILabel *driyrsValue = [[UILabel alloc] initWithFrame:CGRectMake(114, 40, 150, 30)];
    driyrsValue.text = [[driInfoArr objectAtIndex:2] objectForKey:@"Value"];
    driyrsValue.font = [UIFont systemFontOfSize:12.0];
    driyrsValue.backgroundColor = [UIColor clearColor];
    driyrsValue.textColor = [UIColor whiteColor];
    
    [self.view addSubview:driyrsTitle];
    [self.view addSubview:driyrsValue];
    
    
    UILabel *starsTitle = [[UILabel alloc] initWithFrame:CGRectMake(145,40,100,30)];
    starsTitle.text =[NSString stringWithFormat:@"%@: ",[[driInfoArr objectAtIndex:4] objectForKey:@"Title"]];
    starsTitle.font = [UIFont systemFontOfSize:12.0];
    starsTitle.backgroundColor = [UIColor clearColor];
    starsTitle.textColor = [UIColor whiteColor];
    
    UILabel *starsValue = [[UILabel alloc] initWithFrame:CGRectMake(274, 40, 150, 30)];
    starsValue.text = [[driInfoArr objectAtIndex:4] objectForKey:@"Value"];
    starsValue.font = [UIFont systemFontOfSize:12.0];
    starsValue.backgroundColor = [UIColor clearColor];
    starsValue.textColor = [UIColor whiteColor];
    
    [self.view addSubview:starsTitle];
    [self.view addSubview:starsValue];

}

-(void)loadcomment
{
    
}



-(void)handleHome
{
    NSLog(@"Go Home......");
    [[NSNotificationCenter defaultCenter] postNotificationName:@"goHomeVC" object:nil];
}

-(void)submit
{
    
}

#pragma mark - Table View methods

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 2;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    cell.backgroundColor = [UIColor clearColor];
    cell.contentView.backgroundColor = [UIColor clearColor];
    
    UILabel *custPhone = [[UILabel alloc] initWithFrame:CGRectMake(10,2,320,20)];
    custPhone.text = [NSString stringWithFormat:@"%@           %@          %@", [[driComment objectAtIndex:indexPath.row] objectForKey:@"custphone"],[[driComment objectAtIndex:indexPath.row] objectForKey:@"comdate"], [[driComment objectAtIndex:indexPath.row] objectForKey:@"comtime"]];
    custPhone.font = [UIFont systemFontOfSize:12];
    custPhone.textColor = [UIColor whiteColor];
    custPhone.backgroundColor = [UIColor clearColor];
    [cell.contentView addSubview:custPhone];
    
//    UILabel *star = [[UILabel alloc] initWithFrame:CGRectMake(10,18,320,20)];
//    star.text = [NSString stringWithFormat:@"%@ 颗星", [[driComment objectAtIndex:indexPath.row] objectForKey:@"stars"]];
//    star.font = [UIFont systemFontOfSize:12];
//    star.backgroundColor = [UIColor clearColor];
//    [cell.contentView addSubview:star];
    
    UILabel *comContent = [[UILabel alloc] initWithFrame:CGRectMake(10,20,320,20)];
    comContent.text = [NSString stringWithFormat:@"%@", [[driComment objectAtIndex:indexPath.row] objectForKey:@"comcontent"]];
    comContent.font = [UIFont systemFontOfSize:12];
    comContent.textColor = [UIColor whiteColor];
    comContent.backgroundColor = [UIColor clearColor];
    [cell.contentView addSubview:comContent];

    
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //BNDetailViewController *detailViewController = [[BNDetailViewController alloc] initWithNibName:@"BNDetailViewController" bundle:nil];
    
    //detailViewController.BNName = [self.tableData objectAtIndex:indexPath.row];
    
    //[self.navigationController pushViewController:detailViewController animated:YES];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{

    return 50;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
