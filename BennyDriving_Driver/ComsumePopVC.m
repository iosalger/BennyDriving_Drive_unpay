//
//  MJSecondDetailViewController.m
//  BennyDriving_Driver
//
//  Created by BennyDriving on 8/29/13.
//  Copyright (c) 2013 BennyDriving. All rights reserved.
//

#import "ComsumePopVC.h"

@interface ComsumePopVC ()

@end

@implementation ComsumePopVC

@synthesize delegate;


- (void)closePopup:(id)sender
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(cancelButtonClicked:)]) {
        [self.delegate cancelButtonClicked:self];
    }
}

@end
