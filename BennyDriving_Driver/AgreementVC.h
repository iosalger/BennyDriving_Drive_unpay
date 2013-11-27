//
//  AgreementVC.h
//  BennyDriving_Driver
//
//  Created by ZHOUHONG on 9/9/13.
//  Copyright (c) 2013 BennyDriving. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AgreementVC : UIViewController
{
    UILabel *pageNumberLabel;
    int pageNumber;
    
    UILabel *numberTitle;
    UIImageView *numberImage;
}

@property (nonatomic, retain) IBOutlet UILabel *pageNumberLabel;

@property (nonatomic, retain) IBOutlet UILabel *numberTitle;
@property (nonatomic, retain) IBOutlet UIImageView *numberImage;

@property (nonatomic,retain)IBOutlet UITextView *agreeTxt;

@property (nonatomic,strong)NSDictionary *fetchInfodic;
@property (nonatomic,strong)NSString *isagrState;

- (id)initWithPageNumber:(int)page;

@end
