//
//  BDDViewController.h
//  BennyDriving_Driver
//
//  Created by BennyDriving on 8/19/13.
//  Copyright (c) 2013 BennyDriving. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>
#import "ButtomBarD1.h"
#import "DriMapVC.h"


@interface BDDViewController : ButtomBarD1<CLLocationManagerDelegate,MKMapViewDelegate,MapViewControllerDidSelectDelegate,UIActionSheetDelegate>
{
    MKMapView *_mapView;
    CLLocationManager *locationManager;
    CLLocationCoordinate2D coordinate;
    CLGeocoder *geoCoder;
   //NSMutableArray *annotationArray;

}

@property (strong, nonatomic) IBOutlet UIButton *Refresh;
@property (strong, nonatomic) IBOutlet UIButton *Location;
@property (strong, nonatomic) IBOutlet UIButton *SerCentre;


@property (nonatomic, retain) IBOutlet MKMapView *mapView;

@property (nonatomic, retain) NSMutableArray *annotationArray;
- (void)locationAddressWithLocation:(CLLocation *)locationGps;


@property (nonatomic,strong)UIButton *btn_serNumber;
@property (nonatomic,strong)UIImageView *pic_serNumber;
@property (nonatomic,strong)UIImageView *SerNum;
@property (nonatomic,strong)UIButton *dialNum;

@property (strong,nonatomic) UIButton *button;

@property (nonatomic,strong) UIButton* btn_rUnfold;
@property (nonatomic,strong) UIButton* btn_rFold;
@property (nonatomic,strong) UIButton* btn_lUnfold;
@property (nonatomic,strong) UIButton* btn_lFold;


@property (nonatomic,strong) UIView * pushView;
@property (nonatomic,strong) UIView * SevNumber;
@property (nonatomic,strong) UIView * LeftMenu;
@property (nonatomic,strong) UIView * RightMenu;


-(void)loadBottomBar;
-(void)loadAnimation;

-(void)loadButtons;
-(void)shareAction;

@end
