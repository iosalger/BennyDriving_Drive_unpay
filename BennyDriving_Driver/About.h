//
//  AboutViewController.h
//  BennyDriving_Driver
//
//

#import <UIKit/UIKit.h>

@interface About : UIViewController {
    NSMutableDictionary *aboutInfo;
}

@property (strong, nonatomic) UIImageView *imageViewAbout;
@property (strong, nonatomic) UILabel *titleAbout;
@property (strong, nonatomic) UITextView *textAbout;
//@property (nonatomic,strong)UIImageView *Homepic;

@end
