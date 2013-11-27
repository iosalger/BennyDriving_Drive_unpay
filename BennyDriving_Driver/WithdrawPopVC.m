//
//  MJSecondDetailViewController.m
//  BennyDriving_Driver
//
//  Created by Martin Juhasz on 24.06.12.
//  Copyright (c) 2012 martinjuhasz.de. All rights reserved.
//

#import "WithdrawPopVC.h"

@interface WithdrawPopVC ()

@end

@implementation WithdrawPopVC

@synthesize delegate;


- (void)closePopup:(id)sender
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(cancelButtonClicked:)]) {
        [self.delegate cancelButtonClicked:self];
    }
}

@end
