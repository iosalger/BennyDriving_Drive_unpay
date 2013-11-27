//
//  AgreementContentController.h
//  BennyDriving_Driver
//
//  Created by ZHOUHONG on 9/9/13.
//  Copyright (c) 2013 BennyDriving. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AgreementContentController : UIViewController<UIScrollViewDelegate>
{   
    NSArray *contentList;
    UIScrollView *scrollView;
	UIPageControl *pageControl;
    NSMutableArray *viewControllers;
    
    // To be used when scrolls originate from the UIPageControl
    BOOL pageControlUsed;
}

@property (nonatomic, retain) NSArray *contentList;

@property (nonatomic, retain) IBOutlet UIScrollView *scrollView;
@property (nonatomic, retain) IBOutlet UIPageControl *pageControl;


@property (nonatomic, retain) NSMutableArray *viewControllers;

@property (nonatomic,strong)NSDictionary *fetchInfodic;
@property (nonatomic,strong)NSString *isagrState;

- (IBAction)changePage:(id)sender;

@end
