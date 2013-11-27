//
//  TrafficState.h
//  BennyDriving_Driver
//
//  Created by BennyDriving on 8/29/13.
//  Copyright (c) 2013 BennyDriving. All rights reserved.
//
#import <UIKit/UIKit.h>


@interface TrafficState : UIViewController<UIWebViewDelegate>

@property (nonatomic, retain) UISegmentedControl *standardSegment;

@property(nonatomic,retain)UIWebView *shoWeb;

- (void)loadWebPageWithString;
-(void)loadsegment;
-(void)setBackLeftBarButtonItem;


@end
