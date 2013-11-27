//
//  WithConfirmPopVC.m
//  BennyDriving_Driver
//
//  Created by Martin Juhasz on 24.06.12.
//  Copyright (c) 2012 martinjuhasz.de. All rights reserved.
//

#import "WithConfirmPopVC.h"

@interface WithConfirmPopVC ()

@end

@implementation WithConfirmPopVC

@synthesize delegate;


- (void)closePopup:(id)sender
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(cancelButtonClicked:)]) {
        [self.delegate cancelButtonClicked:self];
    }
}

@end
