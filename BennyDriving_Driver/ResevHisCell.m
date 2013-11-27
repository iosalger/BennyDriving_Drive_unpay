//
//  CateTableCell.m
//  top100
//
//  Created by Dai Cloud on 12-7-17.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "ResevHisCell.h"

@implementation ResevHisCell

@synthesize fin=_fin;
@synthesize resevhis = _resevhis;
@synthesize title=_title;
@synthesize subTtile=_subTtile;

//- (void)dealloc
//{
//    //[_logo release];
//    [_title release];
//    [_subTtile release];
//    [super dealloc];
//}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        //self.contentView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"tmall_bg_main"]];
        self.contentView.backgroundColor = [UIColor clearColor];
        
        self.fin = [[UIImageView alloc] initWithFrame:CGRectMake(254, 10, 64, 32)];
        self.fin.image = [UIImage imageNamed:@"btn_FinDitl"];
        //self.fin.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:self.fin];
        
        self.resevhis = [[UIImageView alloc] initWithFrame:CGRectMake(180, 10, 64, 32)];
        self.resevhis.image = [UIImage imageNamed:@"btn_ResvDitl"];
        //self.fin.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:self.resevhis];
        
    //NSMutableArray *btnArray = [[NSMutableArray alloc] init];
    //NSMutableArray *btntagArr = [[NSMutableArray alloc] init];
        //int i = 0;
        //for (i=0; i<5; i++) {
            //self.btn_fin = [UIButton buttonWithType:UIButtonTypeCustom];
            //self.btn_fin.frame = CGRectMake(280, 10, 36, 36);
            //self.btn_fin.tag = i+1;
            //[SharedObj sharedOBJ].btntag=self.btn_arrow.tag;
            //NSLog(@"Data %d",[SharedObj sharedOBJ].btntag);
            //NSLog(@"self %d",self.btn_arrow.tag);
            //[SharedObj sharedOBJ].indexPathRow = i;
            //[self.btn_fin addTarget:self action:@selector(FinDetail:) forControlEvents:UIControlEventTouchUpInside];
            //[btnArray  addObject:self.btn_fin];
            //NSNumber *num = [NSNumber numberWithInt:self.btn_fin.tag];
            //[btntagArr addObject:num];
            
       // }
        
        //NSLog(@"%@",btnArray);
        
        
        //NSLog(@"%@",[btnArray objectAtIndex:[SharedObj sharedOBJ].indexPathRow]);
        //UIButton *btnNext = [UIButton new];
        //btnNext = [btnArray objectAtIndex:indexPath.row];
        //self.btn_fin = [btnArray objectAtIndex:[SharedObj sharedOBJ].indexPathRow_orders];
        
        //[self.contentView addSubview:self.btn_fin];
    
        self.title = [[[UILabel alloc] initWithFrame:CGRectMake(10, 15, 320, 20)] autorelease];
        self.title.font = [UIFont systemFontOfSize:16.0f];
        self.title.backgroundColor = [UIColor clearColor];
        self.title.textColor = [UIColor whiteColor];
        self.title.opaque = NO;
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
        
        
        
        
        UILabel *sLine1 = [[[UILabel alloc] initWithFrame:CGRectMake(0, 48, 320, 1)] autorelease];
        sLine1.backgroundColor = [UIColor colorWithRed:198/255.0 
                                                 green:198/255.0 
                                                  blue:198/255.0 
                                                 alpha:1.0];
        UILabel *sLine2 = [[[UILabel alloc] initWithFrame:CGRectMake(0, 49, 320, 1)] autorelease];
        sLine2.backgroundColor = [UIColor whiteColor];
        
        [self.contentView addSubview:sLine1];
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
