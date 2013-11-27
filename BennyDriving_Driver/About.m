//
//  AboutViewController.m
//  BennyDriving_Driver
//
//

#import "About.h"
#import <QuartzCore/QuartzCore.h>

#define kConfigPlistName @"about"

@interface About ()

@end

@implementation About
@synthesize imageViewAbout;
@synthesize titleAbout;
@synthesize textAbout;
//@synthesize Homepic;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.view.backgroundColor= [UIColor colorWithPatternImage:[UIImage imageNamed:@"homebg.png"]];

        self.navigationItem.title = @"关于我们";
    
    }
    return self;
}

//Returns NSDictionary with iformations about hotel from plist with given name.
- (NSDictionary*)aboutInfoFromPlistNamed:(NSString*)plistName {
    NSString *path = [[NSBundle mainBundle] pathForResource:plistName ofType:@"plist"];
    NSDictionary *dictionary = [NSDictionary dictionaryWithContentsOfFile:path];
    dictionary = [dictionary objectForKey:@"Root"];
    dictionary = [dictionary objectForKey:@"About"];
    return dictionary;
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
//    UIBarButtonItem *homeButton = [[UIBarButtonItem alloc] initWithTitle:@"主页"                                                                      style:UIBarButtonItemStylePlain target:self action:@selector(handleHome)];
//    self.navigationItem.rightBarButtonItem = homeButton;
    
//    Homepic = [[UIImageView alloc] init];
//    Homepic.frame = CGRectMake(0, 0, 320, 480);
//    Homepic.image = [UIImage imageNamed:@"homebg.png"];
//    [self.view addSubview:Homepic];
    
    UIImage *HomeBtnImg = [UIImage imageNamed:@"btn_home.png"];
    UIButton *homeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    homeBtn.frame = CGRectMake(0, 0, 44, 44);
    [homeBtn addTarget:self action:@selector(handleHome) forControlEvents:UIControlEventTouchUpInside];
    
    [homeBtn setImage:HomeBtnImg forState:UIControlStateNormal];
    UIBarButtonItem *homeButton = [[UIBarButtonItem alloc] initWithCustomView:homeBtn];
    self.navigationItem.rightBarButtonItem = homeButton;
    
    [self setBackLeftBarButtonItem];
    
    
    CALayer *bglayer = [CALayer layer];
    bglayer.backgroundColor = [UIColor colorWithRed: 0.0 green:0.0 blue:0.0 alpha:0.3].CGColor;
    bglayer.shadowOffset = CGSizeMake(0, 2);
    bglayer.shadowRadius = 3.0;
    bglayer.shadowColor = [UIColor lightGrayColor].CGColor;
    bglayer.shadowOpacity = 1;
    bglayer.frame = CGRectMake(15, 15, 290, self.view.frame.size.height-75);
    //sublayer.borderColor = [UIColor blackColor].CGColor;
    //sublayer.borderWidth = 1.0;
    bglayer.cornerRadius = 5.0;
    [self.view.layer addSublayer:bglayer];


    aboutInfo = [[NSMutableDictionary alloc] init ];
    [aboutInfo setDictionary:[self aboutInfoFromPlistNamed:kConfigPlistName]];
    
    self.textAbout = [UITextView new];
    self.textAbout.frame = CGRectMake(20,40,280,self.view.frame.size.height);
    [self.textAbout setText:[aboutInfo objectForKey:@"text"]];
    self.textAbout.editable = NO;
    self.textAbout.backgroundColor = [UIColor clearColor];
    self.textAbout.textColor = [UIColor whiteColor];
    [self.view addSubview:textAbout];
    
    self.titleAbout = [[UILabel alloc] init];
    self.titleAbout.frame = CGRectMake(20, 20, 280, 30);
    self.titleAbout.textAlignment = NSTextAlignmentCenter;
    self.titleAbout.font = [UIFont systemFontOfSize:16.0];
    self.titleAbout.backgroundColor = [UIColor clearColor];
    self.titleAbout.textColor = [UIColor whiteColor];
    [self.titleAbout setText:[aboutInfo objectForKey:@"title"]];
    [self.view addSubview:titleAbout];
    
//    self.imageViewAbout = [[UIImageView alloc] init];
//    self.imageViewAbout.frame = CGRectMake(0, 0, 320, 215);
//    [self.imageViewAbout setImage:[UIImage imageNamed:[aboutInfo objectForKey:@"image"]]];
//    [self.view addSubview:self.imageViewAbout];
    

    
	// Do any additional setup after loading the view.
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

- (void)viewDidUnload
{
    [self setImageViewAbout:nil];
    [self setTitleAbout:nil];
    [self setTextAbout:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}



@end
