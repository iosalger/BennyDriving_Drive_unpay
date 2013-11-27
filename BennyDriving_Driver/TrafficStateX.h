//
//  TrafficState.h
//  BennyDriving_Driver
//
//  Created by BennyDriving on 8/29/13.
//  Copyright (c) 2013 BennyDriving. All rights reserved.
//

#import "ButtomBarD2.h"

@interface TrafficState : ButtomBarD2<UIWebViewDelegate>

@property (nonatomic, retain) UISegmentedControl *standardSegment;

@property(nonatomic,retain)UIWebView *shoWeb;

- (void)loadWebPageWithString;
-(void)loadsegment;
-(void)setBackLeftBarButtonItem;


@end
