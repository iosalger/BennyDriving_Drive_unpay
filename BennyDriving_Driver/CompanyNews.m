//
//  CompanyNews.m
//  BennyDriving_Driver
//
//  Created by BennyDriving on 8/31/13.
//  Copyright (c) 2013 BennyDriving. All rights reserved.
//

#import "CompanyNews.h"
#import "NewsDetailVC.h"
#import <QuartzCore/QuartzCore.h>
#import "JSONKit.h"
#import "SharedObj.h"

@interface CompanyNews ()

@end

@implementation CompanyNews

@synthesize NewsTable,CoverImage,NewsContent;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        //self.view.backgroundColor = [UIColor lightGrayColor];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.view.backgroundColor= [UIColor colorWithPatternImage:[UIImage imageNamed:@"homebg.png"]];
    
    NewsTable = [[UITableView alloc] init];
    NewsTable.frame = self.view.bounds;
    NewsTable.dataSource = self;
    NewsTable.delegate = self;
    [self.view addSubview:NewsTable];
    
    UIBarButtonItem *homeButton = [[UIBarButtonItem alloc] initWithTitle:@"主页"                                                                      style:UIBarButtonItemStylePlain target:self action:@selector(handleHome)];
    self.navigationItem.rightBarButtonItem = homeButton;

}

#pragma mark - Table View methods

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 4;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    //cell.contentView.backgroundColor = [UIColor lightGrayColor];
    cell.backgroundColor = [UIColor clearColor];
    
        CALayer *sublayercard = [CALayer layer];
        sublayercard.backgroundColor = [UIColor colorWithRed: 1.0 green:1.0 blue:1.0 alpha:1].CGColor;
        sublayercard.shadowOffset = CGSizeMake(0, 2);
        sublayercard.shadowRadius = 3.0;
       sublayercard.shadowColor = [UIColor lightGrayColor].CGColor;
        sublayercard.shadowOpacity = 1;
        sublayercard.frame = CGRectMake(60, 12, 200, 200);
        //sublayer.borderColor = [UIColor blackColor].CGColor;
        //sublayer.borderWidth = 1.0;
        sublayercard.cornerRadius = 5.0;
        [cell.contentView.layer addSublayer:sublayercard];
    //cell.textLabel.text = @"dddddddd";
    //[cell.contentView addSubview:sublayercard];
    NewsTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    
    NSString *filePath = [[NSBundle mainBundle]pathForResource:@"comnews"ofType:@"json"];
    
    NSString *JSONString = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
    
    NSDictionary *newsDic = [JSONString objectFromJSONString];
    
    NSMutableArray *newsArr = [[NSMutableArray alloc] init];
    newsArr = [newsDic objectForKey:@"news"];
    
    NSLog(@"iiiiiiiii%@",[[newsArr objectAtIndex:indexPath.row]objectForKey:@"newsImage"]);
    
    NSLog(@"ttttttttt%@",[[newsArr objectAtIndex:indexPath.row]objectForKey:@"Title"]);
    
    NSLog(@"bbbbbbbbb%@",[[newsArr objectAtIndex:indexPath.row]objectForKey:@"nBrieCont"]);
    
    
    
    CoverImage = [[UIImageView alloc] initWithFrame:CGRectMake(67, 18, 186, 98)];
    CoverImage.image = [UIImage imageNamed:[[newsArr objectAtIndex:indexPath.row]objectForKey:@"newsImage"]];
    [cell.contentView addSubview:CoverImage];
    
    NewsContent = [[UITextView alloc] initWithFrame:CGRectMake(67, 122, 186, 98)];
    NewsContent.text = [[newsArr objectAtIndex:indexPath.row]objectForKey:@"nBrieCont"];
    NewsContent.font = [UIFont systemFontOfSize:12];
    NewsContent.editable = NO;
    NewsContent.backgroundColor = [UIColor clearColor];
    //[NewsContent addTarget:];
    [cell.contentView addSubview:NewsContent];
    
    [cell setSelectionStyle:UITableViewCellSelectionStyleGray];
    
    return cell;
    
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [SharedObj sharedOBJ].indexPathRow_news = indexPath.row;
    
    NewsDetailVC *nd = [[NewsDetailVC alloc] init];
    [self.navigationController pushViewController:nd animated:YES];
    NSLog(@"传司机电话");
    
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 220;
    
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

@end
