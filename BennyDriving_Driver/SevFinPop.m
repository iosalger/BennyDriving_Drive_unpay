//
//  SevFinPop.h
//  BennyDriving_Driver
//
//  Created by ZHOUHONG on 9/2/13.
//  Copyright (c) 2013 BennyDriving. All rights reserved.
//

#import "SevFinPop.h"

@interface SevFinPop ()

@end

@implementation SevFinPop

@synthesize delegate;


- (void)closePopup:(id)sender
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(cancelButtonClicked:)]) {
        [self.delegate cancelButtonClicked:self];
    }
}

@end
