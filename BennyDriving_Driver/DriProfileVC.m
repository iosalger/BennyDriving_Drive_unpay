//
//  ProfileViewController.m
//  BennyDriving_Driver
//
//  Created by BennyDriving on 8/12/13.
//  Copyright (c) 2013 BennyDriving. All rights reserved.
//

#import "DriProfileVC.h"
#import "JSONKit.h"
#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"
#import "SharedObj.h"
#import "MBProgressHUD.h"
#import "CheckNetwork.h"

@interface DriProfileVC ()

@end

@implementation DriProfileVC

@synthesize driPhoto,gender,licenType,idcardNum,drilicenNum,idcardAddress,liveAddress,ergContName,ergContactPhone;
@synthesize driproTable;
@synthesize driProArr=_driProArr;
@synthesize checkname,Checkbtn;
@synthesize btn_submit,bottomBar,profiledic,titleArr,valueArr,btnArray,photoCKbtn;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        //self.navigationController.navigationBarHidden= NO;
        self.navigationItem.title = @"个人资料";
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated
{
self.navigationController.navigationBarHidden=NO;

    //_reloading = YES;
    [self.driproTable reloadData];
    //[photoCKbtn removeFromSuperview];
    
    photoCKbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    photoCKbtn.frame = CGRectMake(5,25,22,22);
    photoCKbtn.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"cb_mono_off"]];
    //[chekname setBackgroundImage:[UIImage imageNamed:@"sesame_more_ico@2x"] forState:UIControlStateNormal];
    photoCKbtn.tag = 0;
    [photoCKbtn addTarget:self action:@selector(boxchecked:)forControlEvents:UIControlEventTouchUpInside];

    
    btnArray = [[NSMutableArray alloc] init];
    NSMutableArray *btntagArr = [[NSMutableArray alloc] init];
    int i = 0;
    for (i=0; i<11; i++) {
        Checkbtn = [UIButton buttonWithType:UIButtonTypeCustom];
        Checkbtn.frame = CGRectMake(5,5,22,22);
        Checkbtn.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"cb_mono_off"]];
        //[chekname setBackgroundImage:[UIImage imageNamed:@"sesame_more_ico@2x"] forState:UIControlStateNormal];
        Checkbtn.tag = i;
        [Checkbtn addTarget:self action:@selector(boxchecked:)forControlEvents:UIControlEventTouchUpInside];
        [btnArray  addObject:Checkbtn];
        NSNumber *num = [NSNumber numberWithInt:Checkbtn.tag];
        [btntagArr addObject:num];
        
    }



}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor= [UIColor colorWithPatternImage:[UIImage imageNamed:@"homebg.png"]];
    UIImage *HomeBtnImg = [UIImage imageNamed:@"btn_home.png"];
    UIButton *homeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    homeBtn.frame = CGRectMake(0, 0, 44, 44);
    [homeBtn addTarget:self action:@selector(handleHome) forControlEvents:UIControlEventTouchUpInside];
    
    [homeBtn setImage:HomeBtnImg forState:UIControlStateNormal];
    UIBarButtonItem *homeButton = [[UIBarButtonItem alloc] initWithCustomView:homeBtn];
    self.navigationItem.rightBarButtonItem = homeButton;
    
    [self setBackLeftBarButtonItem];

    driproTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 320, self.view.frame.size.height) style:UITableViewStylePlain];
    driproTable.backgroundColor = [UIColor clearColor];
    driproTable.dataSource =self;
    driproTable.delegate =self;
    [self.view addSubview:driproTable];
    driproTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    //[super loadBottomBar];
    
//本地数据
    NSString *filePath = [[NSBundle mainBundle]pathForResource:@"driprofile"ofType:@"json"];
    
    NSString *JSONString = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
    NSLog(@"======%@",JSONString);
    
    //NSData *jsonData = [NSData dataWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
    NSDictionary *dic1 = [JSONString objectFromJSONString];
    
        NSLog(@"ddddddd%@",dic1);
    _driProArr = [dic1 objectForKey:@"driverprofile"];
    NSLog(@"ddddddddddd%@",_driProArr);
    

    titleArr = [NSArray arrayWithObjects:@"",@"姓名",@"性别",@"手机",@"准驾车型",@"身份证号",@"驾驶证号",@"身份证地址",@"居住地址",@"紧急联系人",@"紧急联系人电话", nil];
//NSString *a = [NSString stringWithFormat:];
       
    //[profiledic objectForKey:@"name"];
    
    
//    NSLog(@"valeArr  %@",valueArr);
    
//    driPhoto = [[UIImageView alloc] initWithFrame:CGRectMake(5, 5, 60, 60)];
//    driPhoto.image = [UIImage imageNamed:@"photo_3333"];
//    [self.view addSubview:driPhoto];
    
    //    gender = [[UILabel alloc] init];
    //    gender.frame = CGRectMake(90, 20, 320, 40);
    //    [self.view addSubview:gender];
    //
    //    licenType = [[UILabel alloc] init];
    //    licenType.frame = CGRectMake(90, 20, 320, 40);
    //    [self.view addSubview:licenType];
    //
    //    idcardNum = [[UILabel alloc] init];
    //    idcardNum.frame = CGRectMake(90, 20, 320, 40);
    //    [self.view addSubview:idcardNum];
    //
    //    drilicenNum = [[UILabel alloc] init];
    //    drilicenNum.frame = CGRectMake(90, 20, 320, 40);
    //    [self.view addSubview:drilicenNum];
    //
    //    idcardAddress = [[UILabel alloc] init];
    //    idcardAddress.frame = CGRectMake(90, 20, 320, 40);
    //    [self.view addSubview:idcardAddress];
    //
    //    liveAddress = [[UILabel alloc] init];
    //    liveAddress.frame = CGRectMake(90, 20, 320, 40);
    //    [self.view addSubview:liveAddress];
    //
    //    ergContName = [[UILabel alloc] init];
    //    ergContName.frame = CGRectMake(90, 20, 320, 40);
    //    [self.view addSubview:ergContName];
    //
    //    ergContactPhone = [[UILabel alloc] init];
    //    ergContactPhone.frame = CGRectMake(90, 20, 320, 40);
    //    [self.view addSubview:ergContactPhone];
    
    
//    UIButton *submit = [UIButton buttonWithType:UIButtonTypeRoundedRect];
//    submit.frame = CGRectMake(40, self.view.frame.size.height-140, 240, 36);
//    [submit setTitle:@"信息变更申请" forState:UIControlStateNormal];
//    [self.view addSubview:submit];
    
    bottomBar = [[UIImageView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height-100, 320, 80)];
    bottomBar.image = [UIImage imageNamed:@"bottombar_bg_opq"];
    
    btn_submit = [UIButton buttonWithType:UIButtonTypeCustom];
    btn_submit.frame = CGRectMake(60, self.view.frame.size.height-90, 200, 32);
    btn_submit.layer.cornerRadius = 3;
    [btn_submit setTitle:@"信息变更申请" forState:UIControlStateNormal];
    btn_submit.titleLabel.font = [UIFont fontWithName:@"Verdana-Bold" size:16.0];
    [btn_submit setBackgroundColor:[UIColor colorWithRed:255.0/255.0 green:100.0/255.0 blue:50.0/255.0 alpha:1]];
    [btn_submit addTarget:self action:@selector(submit) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:bottomBar];
    [self.view addSubview:btn_submit];
    
    [self loadrefreshead];
}

-(void)loadrefreshead
{
	if (_refreshHeaderView == nil) {
		
		EGORefreshTableHeaderView *view = [[EGORefreshTableHeaderView alloc] initWithFrame:CGRectMake(0.0f, 0.0f - self.driproTable.bounds.size.height, self.view.frame.size.width, self.driproTable.bounds.size.height)];
		view.delegate = self;
		[self.driproTable addSubview:view];
		_refreshHeaderView = view;
		//[view release];
		
	}
	
	//  update the last update date
	[_refreshHeaderView refreshLastUpdatedDate];


}

-(void)submit
{
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:[NSString stringWithFormat:@"信息变更申请已提交，我们将在12小时内为您修改您的个人信息。"] delegate:self cancelButtonTitle:@"返回" otherButtonTitles:nil];
    alert.tag = 101;
    [alert show];
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
    
    return 11;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    if (indexPath.row == 0) {
        

        //Checkbtn.frame = CGRectMake(5,20,22,22);
 
        //photobtn = [btnArray objectAtIndex:0];
        //cell.contentView.contentVerticalAlignment= UIControlContentVerticalAlignmentCenter;
        [cell.contentView addSubview:photoCKbtn];
        
        
        UIImageView *drihead = [[UIImageView alloc] initWithFrame:CGRectMake(30,10, 50, 50)];
        drihead.image = [UIImage imageNamed:[[_driProArr objectAtIndex:0] objectForKey:@"Value"]];
        [cell.contentView addSubview:drihead];

    }    
    
    else if (indexPath.row !=0&&indexPath.row <12) {
        
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.mode = MBProgressHUDModeCustomView;
        hud.labelText = @"Loading";
        
        NSString *urlString = [NSString stringWithFormat:@"http://demo.4008200972.com/vip/jk/url.php?driid=%@&action=dri-grzlcx",[SharedObj sharedOBJ].logindriid];
        //NSString *urlString = [NSString stringWithFormat:@"http://www.4008200972.com/vip/jk/url.php?driid=58&action=dri-acc"];
        NSURL *url = [NSURL URLWithString:urlString];
        NSLog(@"uuuuuuuu%@",url);
        
        ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
        [request setCompletionBlock:^{
            NSString *JSONStr = request.responseString;
            //JSONString =[JSONString stringByReplacingOccurrencesOfString:@"\'" withString:@"\""];
            // JSONString =[JSONString stringByReplacingOccurrencesOfString:@"balance" withString:@"\"balance\""];
            NSLog(@"xxxxxxx%@",JSONStr);
            profiledic = [JSONStr objectFromJSONString];
            
            NSLog(@"============JSON=================");
            NSLog(@"%@====",profiledic);
            // NSLog(@"aaaaaa %@",[profiledic objectForKey:@"name"]);
            
            //        NSString *nameValue = [profiledic objectForKey:@"name"];
            //        NSLog(@"aaaaaa %@",[profiledic objectForKey:@"name"]);
            //        NSString *sexValue = [profiledic objectForKey:@"sex"];
            //        NSLog(@"bbbbbb %@",[profiledic objectForKey:@"sex"]);
            
            valueArr = [NSArray arrayWithObjects:@"",[profiledic objectForKey:@"name"],[profiledic objectForKey:@"sex"],[profiledic objectForKey:@"tel"],[profiledic objectForKey:@"cdri"],[profiledic objectForKey:@"cid"],[profiledic objectForKey:@"did"],[profiledic objectForKey:@"cadd"],[profiledic objectForKey:@"ladd"],[profiledic objectForKey:@"ename"],[profiledic objectForKey:@"etel"],nil];
            NSLog(@"%@",valueArr);
            
            //NSLog(@"====%@",[profiledic objectForKey:@"balance"]);
            
            // _driProArr = [profiledic objectForKey:@"driverprofile"];
        }];
        
cell.textLabel.text = [NSString stringWithFormat:@"      %@:  %@",[titleArr objectAtIndex:indexPath.row],[valueArr objectAtIndex:indexPath.row]] ;
    [request startSynchronous];
        
    [MBProgressHUD hideHUDForView:self.view animated:YES]; 

    cell.textLabel.font = [UIFont systemFontOfSize:14.0];
    cell.textLabel.textColor = [UIColor whiteColor];
       
//        for (UIButton *btn in btnArray) {
//            [btn removeFromSuperview];
//        }  
        
        Checkbtn = [btnArray objectAtIndex:indexPath.row];
        [cell.contentView addSubview:Checkbtn];  

    }
        

    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    return cell;
    
}


-(void)boxchecked:(id)sender
{
    //[checkname removeFromSuperview]
    Checkbtn = (UIButton *)sender;
    
    Checkbtn.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"cb_mono_on"]];
    [Checkbtn addTarget:self action:@selector(boxUnchecked:)forControlEvents:UIControlEventTouchUpInside];
    
}

-(void)boxUnchecked:(id)sender
{
    //[checkname removeFromSuperview];
    Checkbtn = (UIButton *)sender;
    Checkbtn.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"cb_mono_off"]];
    [Checkbtn addTarget:self action:@selector(boxchecked:)forControlEvents:UIControlEventTouchUpInside];
    
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    

    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row == 0)
    {
        return 60;
    }
    return 28;
}

#pragma mark -
#pragma mark Data Source Loading / Reloading Methods

- (void)reloadTableViewDataSource{
	
	//  should be calling your tableviews data source model to reload
	//  put here just for demo
    
	_reloading = YES;
    
//    if ([CheckNetwork isExistenceNetwork]) {
//        
//        NSString *urlString = [NSString stringWithFormat:@"http://demo.4008200972.com/vip/jk/url.php?driid=%@&action=dri-grzlcx",[SharedObj sharedOBJ].logindriid];
//        //NSString *urlString = [NSString stringWithFormat:@"http://www.4008200972.com/vip/jk/url.php?driid=58&action=dri-acc"];
//        NSURL *url = [NSURL URLWithString:urlString];
//        NSLog(@"uuuuuuuu%@",url);
//        
//        ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
//        [request setCompletionBlock:^{
//            NSString *JSONStr = request.responseString;
//            //JSONString =[JSONString stringByReplacingOccurrencesOfString:@"\'" withString:@"\""];
//            // JSONString =[JSONString stringByReplacingOccurrencesOfString:@"balance" withString:@"\"balance\""];
//            NSLog(@"xxxxxxx%@",JSONStr);
//            profiledic = [JSONStr objectFromJSONString];
//            
//            NSLog(@"============JSON=================");
//            NSLog(@"%@====",profiledic);
//            // NSLog(@"aaaaaa %@",[profiledic objectForKey:@"name"]);
//            
//            //        NSString *nameValue = [profiledic objectForKey:@"name"];
//            //        NSLog(@"aaaaaa %@",[profiledic objectForKey:@"name"]);
//            //        NSString *sexValue = [profiledic objectForKey:@"sex"];
//            //        NSLog(@"bbbbbb %@",[profiledic objectForKey:@"sex"]);
//            
//            valueArr = [NSArray arrayWithObjects:@"",[profiledic objectForKey:@"name"],[profiledic objectForKey:@"sex"],[profiledic objectForKey:@"tel"],[profiledic objectForKey:@"cdri"],[profiledic objectForKey:@"cid"],[profiledic objectForKey:@"did"],[profiledic objectForKey:@"cadd"],[profiledic objectForKey:@"ladd"],[profiledic objectForKey:@"ename"],[profiledic objectForKey:@"etel"],nil];
//            NSLog(@"%@",valueArr);
//            
//            //NSLog(@"====%@",[profiledic objectForKey:@"balance"]);
//            
//            // _driProArr = [profiledic objectForKey:@"driverprofile"];
//        }];
//        
////        driproTable.cell.textLabel.text = [NSString stringWithFormat:@"      %@:  %@",[titleArr objectAtIndex:indexPath.row],[valueArr objectAtIndex:indexPath.row]] ;
//        [request startSynchronous];
//	}
	
}

- (void)doneLoadingTableViewData
{
	
    //[photoCKbtn removeFromSuperview]; 
    
    //Checkbtn = (UIButton *)sender;
    //NSLog(@"%@",btnArray);
    //for (Checkbtn in btnArray)
    //{
    //    [Checkbtn removeFromSuperview];
    //}   

	//  model should call this when its done loading
	_reloading = NO;
	[_refreshHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:self.driproTable];
    [self.driproTable reloadData];
    
//UITableViewCell *myCell=(UITableViewCell *)[[Checkbtn superview]superview];
//if (![self.driproTable indexPathForCell:myCell].row==0) {
//            [[btnArray objectAtIndex:[self.driproTable indexPathForCell:(UITableViewCell *)[[Checkbtn superview]superview]].row] removeFromSuperview];
//    }

    
    //UITableViewCell *myCell=(UITableViewCell *)[[Checkbtn superview]superview];

//    Checkbtn = [btnArray objectAtIndex:[self.driproTable indexPathForCell:(UITableViewCell *)[[Checkbtn superview]superview]].row];
//    [Checkbtn removeFromSuperview];


    
}


#pragma mark -
#pragma mark UIScrollViewDelegate Methods

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{	
	
	[_refreshHeaderView egoRefreshScrollViewDidScroll:scrollView];
    
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
	
	[_refreshHeaderView egoRefreshScrollViewDidEndDragging:scrollView];
	
}


#pragma mark -
#pragma mark EGORefreshTableHeaderDelegate Methods

- (void)egoRefreshTableHeaderDidTriggerRefresh:(EGORefreshTableHeaderView*)view{
	
	[self reloadTableViewDataSource];
	[self performSelector:@selector(doneLoadingTableViewData) withObject:nil afterDelay:3.0];
	
}

- (BOOL)egoRefreshTableHeaderDataSourceIsLoading:(EGORefreshTableHeaderView*)view{
	
	return _reloading; // should return if data source model is reloading
	
}

- (NSDate*)egoRefreshTableHeaderDataSourceLastUpdated:(EGORefreshTableHeaderView*)view{
	
	return [NSDate date]; // should return date data source was last changed
	
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
