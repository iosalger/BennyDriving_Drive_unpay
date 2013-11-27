//
//  HGKOptionPanel.m
//  iNVASIVE
//
//  Created by Jon Arrien Fernández on 18/08/11.
//  Copyright 2011 Hegaka. All rights reserved.
//

#import "HGKOptionPanel.h"

#import <QuartzCore/QuartzCore.h>

@implementation HGKOptionPanel

@synthesize btnShowHide,isExpanded,shouqiLoge,btnDW,btnSX,btnZY;



- (id)initWithFrame:(CGRect)frame
{   
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)drawRect:(CGRect)rect{
    [super drawRect:rect];
    isExpanded = YES;
}



-(IBAction) controlPanelShowHide:(id)sender
{

    CGRect frame = self.frame;

    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.4];
    if (!self.isExpanded)
    {
        self.isExpanded = YES;
        
        frame.origin.y -=140;
        self.frame = frame;
        [btnDW setHidden:YES];
        [btnSX setHidden:YES];
        [btnZY setHidden:YES];
        
        
        [shouqiLoge setHidden:NO];
        [self.btnShowHide setImage:[UIImage imageNamed:@"iconCollapse.png"] forState:UIControlStateNormal];
    } else {
        self.isExpanded = NO;
        [btnDW setHidden:NO];
        [btnSX setHidden:NO];
        [btnZY setHidden:NO];

        frame.origin.y +=140;
        self.frame = frame;
        [shouqiLoge setHidden:YES];

        [self.btnShowHide setImage:[UIImage imageNamed:@"iconExpand.png"] forState:UIControlStateNormal];
    }
    [UIView commitAnimations];
    if (self.isExpanded)
        [self.btnShowHide setImage:[UIImage imageNamed:@"iconCollapse.png"] forState:UIControlStateNormal];
    else
        [self.btnShowHide setImage:[UIImage imageNamed:@"iconExpand.png"] forState:UIControlStateNormal];

}

//- (void) dealloc{
//    [super dealloc];
//    [btnShowHide release], btnShowHide = nil;
//    [isExpanded release], isExpanded = nil;
//}

@end
