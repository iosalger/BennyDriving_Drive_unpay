//
//  FirstViewController.h
//  BennyDriving_Driver
//
//  Created by Michael Tyson on 14/04/2011.
//  Copyright 2011 A Tasty Pixel. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TPKeyboardAvoidingScrollView;

@interface Feedback : UIViewController <UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate> {

    TPKeyboardAvoidingScrollView *scrollView;
    UITextField *txtSplat;
}
@property (nonatomic, retain) IBOutlet TPKeyboardAvoidingScrollView *scrollView;
@property (nonatomic, retain) IBOutlet UITextField *txtSplat;
@property (nonatomic,strong) UITableView *FBtable;
@property (nonatomic,strong) NSArray *feedArr;
@property (nonatomic,strong) NSDictionary *feedic;
@property (nonatomic,strong) NSArray *fbArr;

-(void)setBackLeftBarButtonItem;


@end
