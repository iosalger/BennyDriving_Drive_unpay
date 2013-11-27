//
//  NewsDetailVC.h
//  BennyDriving_Driver
//
//  Created by BennyDriving on 8/31/13.
//  Copyright (c) 2013 BennyDriving. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewsDetailVC : UIViewController<UIScrollViewDelegate>{
    UIScrollView *NusFullCont;
    UILabel *newsTitle;
}


@property (strong,nonatomic)UIImageView *CoverImage;
@property (strong,nonatomic)UITextView *NewsContent;
@property (strong,nonatomic)UIScrollView *NusFullCont;

@end
