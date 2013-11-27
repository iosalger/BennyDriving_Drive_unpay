//
//  FirstViewController.m
//  BennyDriving_Driver
//
//  Created by Michael Tyson on 14/04/2011.
//  Copyright 2011 A Tasty Pixel. All rights reserved.
//

#import "Feedback.h"
#import "TPKeyboardAvoidingScrollView.h"
#import "JSONKit.h"
#import "ASIHttpHeaders.h"
#import "ASIFormDataRequest.h"
#import <QuartzCore/QuartzCore.h>

@implementation Feedback
@synthesize txtSplat,FBtable,feedic,feedArr,fbArr;
@synthesize scrollView;


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor= [UIColor colorWithPatternImage:[UIImage imageNamed:@"homebg.png"]];
    self.navigationItem.title = @"意见反馈";
    
    UIImage *HomeBtnImg = [UIImage imageNamed:@"btn_home.png"];
    
    UIButton *homeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    homeBtn.frame = CGRectMake(0, 0, 44, 44);
    [homeBtn addTarget:self action:@selector(handleHome) forControlEvents:UIControlEventTouchUpInside];
    
    [homeBtn setImage:HomeBtnImg forState:UIControlStateNormal];
    UIBarButtonItem *homeButton = [[UIBarButtonItem alloc] initWithCustomView:homeBtn];
    self.navigationItem.rightBarButtonItem = homeButton;
    
    [self setBackLeftBarButtonItem];

    NSString *filePath = [[NSBundle mainBundle]pathForResource:@"drifeedback" ofType:@"json"];
    NSString *JSONString = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
    NSLog(@"======%@",JSONString);
    
    //NSData *jsonData = [NSData dataWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
    NSDictionary *dic1 = [JSONString objectFromJSONString];
    //
    NSLog(@"ddddddd%@",dic1);
    
    fbArr = [[NSMutableArray alloc] init];
    
    fbArr =[dic1 objectForKey:@"sug"];
    
    NSLog(@"iiiiiii%@",fbArr);

    
// 网络接口
//    NSString *urlString = [NSString stringWithFormat:@"http://www.4008200972.com/vip/jk/url.php?userid=53&action=user-hqyyfk"];
//    NSURL *url = [NSURL URLWithString:urlString];
//    NSLog(@"%@",url);
//    
//    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
//    [request setCompletionBlock:^{
//        //        NSError *error = nil;
//        
//        
//        //    request.responseDat/Volumes/KINGSTON/邦尼驾驶项目/code/客户端/BennyDriving130822/BennyDriving/Feedback.ma = [request.responseData stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//        
//        NSString *JSONString = request.responseString;
//        
//        JSONString =[JSONString stringByReplacingOccurrencesOfString:@"\'" withString:@"\""];
//        JSONString =[JSONString stringByReplacingOccurrencesOfString:@"sug" withString:@"\"sug\""];
//        JSONString =[JSONString stringByReplacingOccurrencesOfString:@"content" withString:@"\"content\""];
//        JSONString =[JSONString stringByReplacingOccurrencesOfString:@"time" withString:@"\"time\""];
//        JSONString =[JSONString stringByReplacingOccurrencesOfString:@"usertel" withString:@"\"usertel\""];
//        
//        JSONString =[JSONString stringByReplacingOccurrencesOfString:@"r\"content\"" withString:@"\"rcontent\""];
//        JSONString =[JSONString stringByReplacingOccurrencesOfString:@"r\"time\"" withString:@"\"rtime\""];
//        NSLog(@"%@",JSONString);
//        
//        self.feedic = [JSONString objectFromJSONString];
//        
//        self.feedArr = [[self.feedic objectForKey:@"sug"] objectAtIndex:0];
//        
//        
//        NSLog(@"============JSON=================");
//        NSLog(@"%@====",self.feedic);
//        NSLog(@"%@====",self.feedArr);
        
        
//    }];
//    [request startSynchronous];

    
    self.FBtable = [[UITableView alloc] initWithFrame:CGRectMake(15, 20, 290, 150) style:UITableViewStylePlain];
    self.FBtable.dataSource = self;
    self.FBtable.delegate = self;
    self.FBtable.backgroundColor = [UIColor clearColor];
    [scrollView addSubview:FBtable];
    
    UILabel *CusFeedback = [[UILabel alloc] init];
    CusFeedback.frame = CGRectMake(15, 10, 200, 20);
    CusFeedback.text = @"意见反馈";
    CusFeedback.backgroundColor = [UIColor clearColor];
    CusFeedback.textColor = [UIColor whiteColor];
    CusFeedback.font = [UIFont systemFontOfSize:16.0];
    //[scrollView addSubview:CusFeedback];
    
    UILabel *FBboxTitle = [[UILabel alloc] init];
    FBboxTitle.frame = CGRectMake(0, 210, 320, 20);
    FBboxTitle.text = @"为了提升我们的服务质量，请填写您的建议：";
    FBboxTitle.backgroundColor = [UIColor clearColor];
    FBboxTitle.textColor = [UIColor whiteColor];
    FBboxTitle.textAlignment = NSTextAlignmentCenter;
    FBboxTitle.font = [UIFont systemFontOfSize:14.0];
    [scrollView addSubview:FBboxTitle];

    txtSplat.frame = CGRectMake(20, 235, 280, 100);
    
    UIButton *submit = [UIButton buttonWithType:UIButtonTypeCustom];
    submit.frame = CGRectMake(30, 355, 260, 40);
    [submit setTitle:@"提交" forState:UIControlStateNormal];
    submit.layer.cornerRadius = 3;
    submit.titleLabel.font = [UIFont fontWithName:@"Verdana-Bold" size:16.0];
    [submit setBackgroundColor:[UIColor colorWithRed:255.0/240.0 green:100.0/255.0 blue:50.0/255.0 alpha:1]];
    [submit addTarget:self action:@selector(submit)forControlEvents:UIControlEventTouchUpInside];
    [scrollView addSubview:submit];
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



- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}


- (void)viewDidUnload
{

    [self setTxtSplat:nil];
    [super viewDidUnload];

    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}



-(BOOL)textFieldShouldReturn:(UITextField *)textField {


  [txtSplat resignFirstResponder];
    
    return YES;
    
}

-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    [scrollView adjustOffsetToIdealIfNeeded];
    
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
    
    UILabel *usermobile = [UILabel new];
    usermobile.frame =CGRectMake(0,5,320,15);
    usermobile.text = [NSString stringWithFormat:@"%@:",[[fbArr objectAtIndex:indexPath.row] objectForKey:@"usertel"]];   
    usermobile.font = [UIFont systemFontOfSize:14.0];
    usermobile.textColor = [UIColor whiteColor];
    usermobile.backgroundColor = [UIColor clearColor];
    [cell.contentView addSubview:usermobile];
    
    UITextView *comment = [UITextView new];
    comment.frame =CGRectMake(0,16,320,55);
    comment.text = [[fbArr objectAtIndex:indexPath.row] objectForKey:@"content"];   
    comment.font = [UIFont systemFontOfSize:14.0];
    comment.textColor = [UIColor whiteColor];
    comment.backgroundColor = [UIColor clearColor];
    comment.editable = NO;
    [cell.contentView addSubview:comment];
    
//    UILabel *rname = [UILabel new];
//    rname.frame =CGRectMake(0,40,320,15);
//    rname.text = [NSString stringWithFormat:@"%@:",[[fbArr objectAtIndex:indexPath.row] objectForKey:@"usertel"]];   
//    rname.font = [UIFont fontWithName:@"黑体" size:12];
//    rname.textColor = [UIColor whiteColor];
//    rname.backgroundColor = [UIColor clearColor];
//    [cell.contentView addSubview:rname];
    
    
    UITextView *rcomment = [UITextView new];
    rcomment.frame =CGRectMake(0,45,320,55);
    rcomment.text = [NSString stringWithFormat:@"答: %@",[[fbArr objectAtIndex:indexPath.row] objectForKey:@"rcontent"]];   
    rcomment.font = [UIFont systemFontOfSize:14.0];
    rcomment.textColor = [UIColor whiteColor];
    rcomment.backgroundColor = [UIColor clearColor];
    rcomment.editable = NO;
    [cell.contentView addSubview:rcomment];
    
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
    return 80;
    
}

-(void)submit
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:[NSString stringWithFormat:@"意见已提交，我们将在24小时内完成审核并回复。"] delegate:self cancelButtonTitle:@"返回" otherButtonTitles:nil];
    alert.tag = 101;
    [alert show];    
}

-(void)handleHome
{
    NSLog(@"Go Home......");
    [[NSNotificationCenter defaultCenter] postNotificationName:@"goHomeVC" object:nil];
}


@end
