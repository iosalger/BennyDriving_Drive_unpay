//
//  SevCenterVC.h
//  BennyDriving_Driver
//
//  Created by BennyDriving on 8/19/13.
//
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "ButtomBarD2.h"

@interface SevCenterVC : ButtomBarD2<UIActionSheetDelegate,UIAlertViewDelegate,CLLocationManagerDelegate>
{
	//UISwitch				*switchCtl;
	//UISlider				*sliderCtl;
    CLLocationManager *locationManager;
    CLLocationCoordinate2D coordinate;

}

@property (nonatomic,strong)UIButton *btn_OrderList;
@property (nonatomic,strong)UIButton *btn_help;
@property (nonatomic,strong)UIButton *btn_Reservison;
@property (nonatomic,strong)UIButton *btn_helpEachother;
@property (nonatomic,strong)UIButton *btn_advancedService;
@property (nonatomic,strong)UIButton *btn_profile;
@property (nonatomic,strong)UIButton *btn_account;
@property (nonatomic,strong)UIButton *btn_MoMall;
@property (nonatomic,strong)UIButton *btn_infoCentre;


@property (nonatomic, retain, readonly) UISwitch *switchCtl;
//@property (nonatomic, retain, readonly) UISlider *sliderCtl;
@property (nonatomic,getter=isOn) BOOL on;
//@property (nonatomic,setter=isOn:) BOOL on;


-(void)switchAction:(id)sender;

@property (strong,nonatomic) UIButton *button;

//@property (nonatomic,strong)UIImageView *SerNum;
@property (nonatomic,strong)UIButton *dialNum;
@property (nonatomic,strong)UILabel *SevStatus;

-(void)loadButtons;

@property (nonatomic,strong) UIButton* btn_rUnfold;
@property (nonatomic,strong) UIButton* btn_rFold;
@property (nonatomic,strong) UIButton* btn_lUnfold;
@property (nonatomic,strong) UIButton* btn_lFold;


@property (nonatomic,strong) UIView * pushView;
@property (nonatomic,strong) UIView * SevNumber;
@property (nonatomic,strong) UIView * LeftMenu;
@property (nonatomic,strong) UIView * RightMenu;


@property (nonatomic,strong)UIImageView *Homepic;


-(void)loadBottomBar;
-(void)loadAnimation;
- (void)setBackLeftBarButtonItem;


@end
