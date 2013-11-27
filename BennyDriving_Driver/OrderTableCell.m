//
//  OrderTableCell.m
//  BennyDriving_Driver
//
//  Created by ZHOUHONG on 9/9/13.
//  Copyright (c) 2013 BennyDriving. All rights reserved.
//

#import "OrderTableCell.h"

@implementation OrderTableCell

@synthesize logo=_logo;
@synthesize title=_title;
@synthesize subTtile=_subTtile;

- (void)dealloc
{
    [_logo release];
    [_title release];
    [_subTtile release];
    [super dealloc];
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        //self.contentView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"tmall_bg_main"]];
        //self.backgroundColor = [UIColor clearColor];
//        self.logo = [[[UIImageView alloc] initWithFrame:CGRectMake(5, 5, 70, 70)] autorelease];
//        self.logo.backgroundColor = [UIColor clearColor];
//        [self.contentView addSubview:self.logo];
//        self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"homebg.png"]];
        self.backgroundColor = [UIColor clearColor];
        self.contentView.backgroundColor = [UIColor clearColor];
        
        
        self.title = [[[UILabel alloc] initWithFrame:CGRectMake(10, 15, 320, 20)] autorelease];
        self.title.font = [UIFont systemFontOfSize:16.0f];
        self.title.backgroundColor = [UIColor clearColor];
        self.title.opaque = YES;
        [self.contentView addSubview:self.title];
        
        
//        self.subTtile = [[[UILabel alloc] initWithFrame:CGRectMake(80, 40, 230, 14)] autorelease];
//        self.subTtile.font = [UIFont systemFontOfSize:12.0f];
//        self.subTtile.textColor = [UIColor colorWithRed:158/255.0 
//                                                  green:158/255.0 
//                                                   blue:158/255.0 
//                                                  alpha:1.0];
//        self.subTtile.backgroundColor = [UIColor clearColor];
//        self.subTtile.opaque = NO;
//        [self.contentView addSubview:self.subTtile];
        
        
        
        
//        UILabel *sLine1 = [[[UILabel alloc] initWithFrame:CGRectMake(0, 48, 320, 1)] autorelease];
//        sLine1.backgroundColor = [UIColor colorWithRed:198/255.0
//                                                 green:198/255.0 
//                                                  blue:198/255.0 
//                                                 alpha:0.6];
        UILabel *sLine2 = [[[UILabel alloc] initWithFrame:CGRectMake(0, 49, 320, 1)] autorelease];
        sLine2.backgroundColor = [UIColor whiteColor];
        
        //[self.contentView addSubview:sLine1];
        [self.contentView addSubview:sLine2];
        
    }
    
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
