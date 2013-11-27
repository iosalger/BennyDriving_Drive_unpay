//
//  NewsDetailVC.m
//  BennyDriving_Driver
//
//  Created by BennyDriving on 8/31/13.
//  Copyright (c) 2013 BennyDriving. All rights reserved.
//

#import "NewsDetailVC.h"
#import "JSONKit.h"
#import "SharedObj.h"
#import <QuartzCore/QuartzCore.h>

@interface NewsDetailVC ()

@end

@implementation NewsDetailVC

@synthesize NewsContent,CoverImage,NusFullCont,title;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    NSString *filePath = [[NSBundle mainBundle]pathForResource:@"comnews"ofType:@"json"];
    
    NSString *JSONString = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
    
    NSDictionary *newsDic = [JSONString objectFromJSONString];
    
    NSMutableArray *newsArr = [[NSMutableArray alloc] init];
    
    newsArr = [newsDic objectForKey:@"news"];
    
    CGRect frame = CGRectMake(0, 0, 320, self.view.frame.size.height);
    NusFullCont= [[UIScrollView alloc] initWithFrame:frame];
    NusFullCont.contentSize = CGSizeMake(320, 600);
    [self.view addSubview:NusFullCont];

    CoverImage = [[UIImageView alloc] initWithFrame:CGRectMake(20, 18, 280, 160)];
    CoverImage.image = [UIImage imageNamed:[[newsArr objectAtIndex:[SharedObj sharedOBJ].indexPathRow_news]objectForKey:@"newsImage"]];
    [NusFullCont addSubview:CoverImage];
    
    
    newsTitle = [[UILabel alloc] initWithFrame:CGRectMake(20, 188, 280, 20)];
    newsTitle.text = [[newsArr objectAtIndex:[SharedObj sharedOBJ].indexPathRow_news]objectForKey:@"Title"];
    newsTitle.font = [UIFont systemFontOfSize:16];
    newsTitle.textAlignment = NSTextAlignmentCenter;
    //newsTitle.editable = NO;
    newsTitle.backgroundColor = [UIColor clearColor];
    //[NewsContent addTarget:];
    [NusFullCont addSubview:newsTitle];
    
    
    
    NewsContent = [[UITextView alloc] initWithFrame:CGRectMake(20, 208, 280, self.view.frame.size.height)];
    NewsContent.text = [[newsArr objectAtIndex:[SharedObj sharedOBJ].indexPathRow_news]objectForKey:@"nFullCont"];
    NewsContent.font = [UIFont systemFontOfSize:14];
    NewsContent.editable = NO;
    NewsContent.backgroundColor = [UIColor clearColor];
    //[NewsContent addTarget:];
    [NusFullCont addSubview:NewsContent];


}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
