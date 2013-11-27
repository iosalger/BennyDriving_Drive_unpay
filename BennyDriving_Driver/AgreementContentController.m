//
//  AgreementContentController.m
//  BennyDriving_Driver
//
//  Created by ZHOUHONG on 9/9/13.
//  Copyright (c) 2013 BennyDriving. All rights reserved.
//

#import "AgreementContentController.h"
#import <QuartzCore/QuartzCore.h>
#import "AgreementVC.h"
#import "ASIHttpHeaders.h"
#import "ASIFormDataRequest.h"
#import "SharedObj.h"
#import "JSONKit.h"
#import "SevCenterVC.h"

static NSUInteger kNumberOfPages = 5;

static NSString *NameKey = @"nameKey";
//static NSString *ImageKey = @"imageKey";
static NSString *ContentKey = @"contentKey";

@interface AgreementContentController (PrivateMethods)
- (void)loadScrollViewWithPage:(int)page;
- (void)scrollViewDidScroll:(UIScrollView *)sender;
@end

@implementation AgreementContentController

@synthesize scrollView, pageControl, viewControllers,contentList;
@synthesize fetchInfodic,isagrState;


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    // load our data from a plist file inside our app bundle
    NSString *path = [[NSBundle mainBundle] pathForResource:@"AgreeContent" ofType:@"plist"];
    self.contentList = [NSArray arrayWithContentsOfFile:path];
    
    // view controllers are created lazily
    // in the meantime, load the array with placeholders which will be replaced on demand
    NSMutableArray *controllers = [[NSMutableArray alloc] init];
    for (unsigned i = 0; i < kNumberOfPages; i++)
   {
		[controllers addObject:[NSNull null]];
   }
   self.viewControllers = controllers;
    //[controllers release];
    
    // a page is the width of the scroll view
    scrollView.pagingEnabled = YES;
    scrollView.contentSize = CGSizeMake(scrollView.frame.size.width * kNumberOfPages, scrollView.frame.size.height);
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.scrollsToTop = NO;
    scrollView.delegate = self;
    
    pageControl.numberOfPages = kNumberOfPages;
    pageControl.currentPage = 0;
//    
//    // pages are created on demand
//    // load the visible page
//    // load the page on either side to avoid flashes when the user starts scrolling
//    //
//    
//    
    [self loadScrollViewWithPage:0];
    [self loadScrollViewWithPage:1];
    
    //底部背景条
    UIImageView *bottomBar = [[UIImageView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height-60, 320, 80)];
    bottomBar.image = [UIImage imageNamed:@"bottombar_bg_opq"];    
    [self.view addSubview:bottomBar];  
    
    //自定义按钮
    
    UIButton *btn_download = [UIButton buttonWithType:UIButtonTypeCustom];
    btn_download.frame = CGRectMake(60, self.view.frame.size.height-44, 200, 32);
    btn_download.layer.cornerRadius = 3;
    [btn_download setTitle:@"已阅读并同意遵守" forState:UIControlStateNormal];
    btn_download.titleLabel.font = [UIFont fontWithName:@"Verdana-Bold" size:16.0];
    [btn_download setBackgroundColor:[UIColor colorWithRed:200.0/255.0 green:20.0/255.0 blue:70.0/255.0 alpha:1]];
    [btn_download addTarget:self action:@selector(agree) forControlEvents:UIControlEventTouchDown];
    
    [self.view addSubview:btn_download];
}

-(void)agree
{
        NSString *urlstr =
        [NSString stringWithFormat:@"http://abc.4008200972.com/benny_driving/servlet/LocationShareServlet?driid=%@&agrid=4&action=dri-qdxy",[SharedObj sharedOBJ].logindriid];
        NSURL *myurl = [NSURL URLWithString:urlstr];
        NSLog(@"Url=====%@",myurl);
        
        
        ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:myurl];
        [request setCompletionBlock:^{
            NSString *JSONString = request.responseString;
            fetchInfodic = [JSONString objectFromJSONString];
            NSLog(@"ttttt%@",JSONString);
            NSLog(@"%@",fetchInfodic);
            isagrState = [fetchInfodic objectForKey:@"state"];
            NSLog(@"%@",isagrState);
            [SharedObj sharedOBJ].loginisagr = isagrState;
            
        }];
        
        
        UIAlertView *alertA = [[UIAlertView alloc] initWithTitle:@"" message:@"确定已经仔细阅读并同意协议条款"
                                                        delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil];
   alertA.tag = 100;
    	[alertA show];
        
        [request startAsynchronous];
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSLog(@"clickedButtonAtIndex:%d",0);

    SevCenterVC *svc = [[SevCenterVC alloc] init];
    [self.navigationController pushViewController:svc animated:YES];

}

- (void)loadScrollViewWithPage:(int)page
{
    if (page < 0)
        return;
    if (page >= kNumberOfPages)
        return;
    
    // replace the placeholder if necessary
    AgreementVC *controller = [viewControllers objectAtIndex:page];
    if ((NSNull *)controller == [NSNull null])
    {
        controller = [[AgreementVC alloc] initWithPageNumber:page];
        [viewControllers replaceObjectAtIndex:page withObject:controller];
        //[controller release];
    }
    
    // add the controller's view to the scroll view
    if (controller.view.superview == nil)
    {
        //if (![page ==5] ) {
        CGRect frame = scrollView.frame;
        frame.origin.x = frame.size.width * page;
        frame.origin.y = 0;
        controller.view.frame = frame;
        [scrollView addSubview:controller.view];
        
        NSDictionary *numberItem = [self.contentList objectAtIndex:page];
        //controller.numberImage.image = [UIImage imageNamed:[numberItem valueForKey:ImageKey]];
        controller.agreeTxt.text = [numberItem valueForKey:ContentKey];
        controller.agreeTxt.editable = NO;
        controller.numberTitle.text = [numberItem valueForKey:NameKey];
        
        //}
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)sender
{
    // We don't want a "feedback loop" between the UIPageControl and the scroll delegate in
    // which a scroll event generated from the user hitting the page control triggers updates from
    // the delegate method. We use a boolean to disable the delegate logic when the page control is used.
    if (pageControlUsed)
    {
        // do nothing - the scroll was initiated from the page control, not the user dragging
        return;
    }
	
    // Switch the indicator when more than 50% of the previous/next page is visible
    CGFloat pageWidth = scrollView.frame.size.width;
    int page = floor((scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    pageControl.currentPage = page;
    
    // load the visible page and the page on either side of it (to avoid flashes when the user starts scrolling)
    [self loadScrollViewWithPage:page - 1];
    [self loadScrollViewWithPage:page];
    [self loadScrollViewWithPage:page + 1];
    
    // A possible optimization would be to unload the views+controllers which are no longer visible
}

// At the begin of scroll dragging, reset the boolean used when scrolls originate from the UIPageControl
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    pageControlUsed = NO;
}

// At the end of scroll animation, reset the boolean used when scrolls originate from the UIPageControl
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    pageControlUsed = NO;
}

- (IBAction)changePage:(id)sender
{
    int page = pageControl.currentPage;
	
    // load the visible page and the page on either side of it (to avoid flashes when the user starts scrolling)
    [self loadScrollViewWithPage:page - 1];
    [self loadScrollViewWithPage:page];
    [self loadScrollViewWithPage:page + 1];
    
	// update the scroll view to the appropriate page
    CGRect frame = scrollView.frame;
    frame.origin.x = frame.size.width * page;
    frame.origin.y = 0;
    [scrollView scrollRectToVisible:frame animated:YES];
    
	// Set the boolean used when scrolls originate from the UIPageControl. See scrollViewDidScroll: above.
    pageControlUsed = YES;
}


- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;

}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

@end
