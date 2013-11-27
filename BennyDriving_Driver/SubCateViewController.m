//
//  SubCateViewController.m
//  BennyDriving_Driver
//
//  Created by 郑 琪 on 13-2-27.
//  Copyright (c) 2013年 郑 琪. All rights reserved.
//

#import "SubCateViewController.h"

@interface SubCateViewController ()
@property (strong, nonatomic) IBOutlet UILabel *label_Info;
@property (strong, nonatomic) IBOutlet UITextView *txt_Info;

@end

@implementation SubCateViewController
@synthesize label_Info,txt_Info;
@synthesize Info;
-(void)DisplayInfo:(NSString *)Info
{
//    label_Info.numberOfLines = 0;
//    CGSize size = [Info sizeWithFont:label_Info.font constrainedToSize:CGSizeMake(320, MAXFLOAT)];
//    if(size.height < label_Info.frame.size.height)
//    {
//        size = CGSizeMake(320, label_Info.frame.size.height);
//    }
//    [label_Info setFrame:CGRectMake(0, 0, 320, size.height)];
//    [self.view setFrame:CGRectMake(0, 0, 320, size.height)];
//    label_Info.text = Info;
    //label_Info.font = [UIFont systemFontOfSize:12.0];
    //Info.font = [UIFont systemFontOfSize:12.0];

}


#pragma ViewController
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
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor= [UIColor colorWithPatternImage:[UIImage imageNamed:@"homebg.png"]];
    
//    label_Info.numberOfLines = 0;
//    CGSize size = [Info sizeWithFont:label_Info.font constrainedToSize:CGSizeMake(320, MAXFLOAT)];
//    if(size.height < label_Info.frame.size.height)
//    {
//        size = CGSizeMake(320, label_Info.frame.size.height);
//    }
//    [label_Info setFrame:CGRectMake(0, 0, 320, size.height)];
//    [self.view setFrame:CGRectMake(0, 0, 320, size.height)];
//    label_Info.text = Info;
//    label_Info.font = [UIFont systemFontOfSize:12.0];
    //self.view.backgroundColor = [UIColor clearColor];
    //txt_Info.numberOfLines = 0;
    //CGSize size = [Info sizeWithFont:txt_Info.font constrainedToSize:CGSizeMake(320, MAXFLOAT)];
    //if(size.height < txt_Info.frame.size.height)
    //{
    //    size = CGSizeMake(320, txt_Info.frame.size.height);
    //}
    [txt_Info setFrame:CGRectMake(0, 0, 320, 180)];
    [self.view setFrame:CGRectMake(0, 0, 320, 180)];
    txt_Info.text = Info;
    txt_Info.font = [UIFont systemFontOfSize:12.0];
    txt_Info.editable = NO;

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
