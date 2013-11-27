//
//  SubCateViewController.h
//  top100
//
//  Created by Dai Cloud on 12-7-13.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "SevFindRecList.h"
#import "ResevHisList.h"

@interface UnfoldSevFindRec : UIViewController

@property (strong, nonatomic) NSArray *subCates;
@property (strong, nonatomic) ResevHisList *cateVC;

-(void)getOrder;

@end
