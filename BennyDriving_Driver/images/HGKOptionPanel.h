//
//  HGKOptionPanel.h
//  iNVASIVE
//
//  Created by Jon Arrien Fernández on 18/08/11.
//  Copyright 2011 Hegaka. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kDefaultMargin 10


@interface HGKOptionPanel : UIView {
    
    UIButton *btnShowHide;
    BOOL isExpanded;
    
}
@property(nonatomic, retain) IBOutlet UIImageView *shouqiLoge;
@property (nonatomic, retain) IBOutlet UIButton *btnShowHide;
@property (nonatomic, retain) IBOutlet UIButton *btnDW;
@property (nonatomic, retain) IBOutlet UIButton *btnSX;
@property (nonatomic, retain) IBOutlet UIButton *btnZY;


@property IBOutlet BOOL isExpanded;
-(IBAction) controlPanelShowHide:(id)sender;


@end
