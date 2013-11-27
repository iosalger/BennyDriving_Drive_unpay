//
//  AgreementVC.m
//  BennyDriving_Driver
//
//  Created by ZHOUHONG on 9/9/13.
//  Copyright (c) 2013 BennyDriving. All rights reserved.
//

#import "AgreementVC.h"

@implementation AgreementVC

@synthesize pageNumberLabel, numberTitle, numberImage,agreeTxt,fetchInfodic,isagrState;

// load the view nib and initialize the pageNumber ivar
- (id)initWithPageNumber:(int)page
{
    if (self = [super initWithNibName:@"AgreementView" bundle:nil])
    {
        pageNumber = page;
    }
    return self;
}

- (void)dealloc
{
    [pageNumberLabel release];
    [numberTitle release];
    [numberImage release];
    
    [super dealloc];
}

// set the label and background color when the view has finished loading
- (void)viewDidLoad
{
    pageNumberLabel.text = [NSString stringWithFormat:@"Page %d", pageNumber + 1];
}

@end
