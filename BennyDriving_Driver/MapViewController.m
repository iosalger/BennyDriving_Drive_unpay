//
//  MapViewController.m
//  XQSearchPlaces
//
//  Created by iObitLXF on 5/17/13.
//  Copyright (c) 2013 iObitLXF. All rights reserved.
//


//Google Places Api Type:https://developers.google.com/places/documentation/supported_types

#import "MapViewController.h"
#import "MapCell.h"
#import "PinAnnotation.h"
#import "DetailsAnnotation.h"
#import "DetailsAnnotationView.h"
#import "XMLHelper.h"
#import "PlaceDetailVO.h"
#import "DetailsViewController.h"


#define span_Num 3000
#define PlaceURLString @"https://maps.googleapis.com/maps/api/place/search/xml?location=%f,%f&radius=%f&types=%@&name=%@&sensor=true&key=AIzaSyBHvxjcnxJNzgukGhgtO65qyxV5aX7DXvg"   //key 需自己在google api申请替换

@interface MapViewController ()

{
    NSMutableArray *_annotationList;
    CLLocationCoordinate2D coordinate;
    PinAnnotation *_pinAnnotation;
	DetailsAnnotation *_detailsAnnotation;
    
    BOOL havePlaced;
}

@end

@implementation MapViewController
@synthesize mapView = _mapView;
@synthesize weixiuzhan,xichedian,jiayouzhan,tingcehchang,jigou,dingwei,shuaxin;
@synthesize progressHUD;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
#pragma mark -

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.navigationItem setTitle:@"搜寻服务"];
    
    UIImage *HomeBtnImg = [UIImage imageNamed:@"btn_home.png"];
    UIButton *homeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    homeBtn.frame = CGRectMake(0, 0, 44, 44);
    [homeBtn addTarget:self action:@selector(handleHome) forControlEvents:UIControlEventTouchUpInside];
    
    [homeBtn setImage:HomeBtnImg forState:UIControlStateNormal];
    UIBarButtonItem *homeButton = [[UIBarButtonItem alloc] initWithCustomView:homeBtn];
    self.navigationItem.rightBarButtonItem = homeButton;
    
    [self setBackLeftBarButtonItem];
    
    [xichedian setBackgroundImage:[UIImage imageNamed:@"xichedian"] forState:UIControlStateNormal];
    [jiayouzhan setBackgroundImage:[UIImage imageNamed:@"jiayouzhan"] forState:UIControlStateNormal];
    [tingcehchang setBackgroundImage:[UIImage imageNamed:@"tingchechang_bai"] forState:UIControlStateNormal];
    [jigou setBackgroundImage:[UIImage imageNamed:@"jigou"] forState:UIControlStateNormal];
    [weixiuzhan setBackgroundImage:[UIImage imageNamed:@"jixiudian"] forState:UIControlStateNormal];
    
    [dingwei setBackgroundImage:[UIImage imageNamed:@"dingwei"] forState:UIControlStateNormal];
    [shuaxin setBackgroundImage:[UIImage imageNamed:@"shuaxin"] forState:UIControlStateNormal];
    
     _annotationList = [[NSMutableArray alloc] init];

    self.mapView.showsUserLocation = YES;
    
    locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    
    //开启GPS
    if(CLLocationManager.locationServicesEnabled) {
        locationManager = [[CLLocationManager alloc] init];
        [locationManager setDelegate:self];
        locationManager.distanceFilter = 1000.0f;//响应位置变化的最小距离(m)
        locationManager.desiredAccuracy = kCLLocationAccuracyBest;//设定为最佳精度
        [locationManager startUpdatingLocation];
    }

    self.mapView.delegate = self;
	// 是否显示当前位置
    self.mapView.showsUserLocation = YES;
    
}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    [manager stopUpdatingLocation];
    
    NSLog(@"%f,%f",newLocation.coordinate.latitude,newLocation.coordinate.longitude);
    coordinate.latitude = newLocation.coordinate.latitude;
    coordinate.longitude = newLocation.coordinate.longitude;
    
    //设置显示范围
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(coordinate,1000 ,1000);
    [self.mapView setRegion:region animated:TRUE];
    
}


-(void)viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:NO];
    [super viewWillAppear:animated];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)setBackLeftBarButtonItem{
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(0, 0, 44, 44);
    
    [backBtn setImage:[UIImage imageNamed:@"btn_back.png"] forState:UIControlStateNormal];
    
    
    [backBtn addTarget:self action:@selector(doBack:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    self.navigationItem.leftBarButtonItem = backItem;
    
    
}

-(void)doBack:(UIButton *)bt
{
 [self.navigationController popViewControllerAnimated:YES];
}

-(void)handleHome
{
    NSLog(@"Go Home......");
    [[NSNotificationCenter defaultCenter] postNotificationName:@"goHomeVC" object:nil];
}


#pragma mark - action
- (IBAction)clickFood:(id)sender {
    
    [xichedian setBackgroundImage:[UIImage imageNamed:@"xichedian_huang"] forState:UIControlStateNormal];
    [jiayouzhan setBackgroundImage:[UIImage imageNamed:@"jiayouzhan"] forState:UIControlStateNormal];
    [tingcehchang setBackgroundImage:[UIImage imageNamed:@"tingchechang_bai"] forState:UIControlStateNormal];
    [jigou setBackgroundImage:[UIImage imageNamed:@"jigou"] forState:UIControlStateNormal];
    [weixiuzhan setBackgroundImage:[UIImage imageNamed:@"jixiudian"] forState:UIControlStateNormal];
    
    strType = @"car_wash";
    [self showProgressIndicator:@"Searching..."];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [self googlePlace];
    });
}

- (IBAction)clickSchool:(id)sender {
    [xichedian setBackgroundImage:[UIImage imageNamed:@"xichedian"] forState:UIControlStateNormal];
    [jiayouzhan setBackgroundImage:[UIImage imageNamed:@"jiayouzhan_huang"] forState:UIControlStateNormal];
    [tingcehchang setBackgroundImage:[UIImage imageNamed:@"tingchechang_bai"] forState:UIControlStateNormal];
    [jigou setBackgroundImage:[UIImage imageNamed:@"jigou"] forState:UIControlStateNormal];
    [weixiuzhan setBackgroundImage:[UIImage imageNamed:@"jixiudian"] forState:UIControlStateNormal];
    strType = @"gas_station";
    [self showProgressIndicator:@"Searching..."];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [self googlePlace];
    });
}

- (IBAction)clickBank:(id)sender {
    [xichedian setBackgroundImage:[UIImage imageNamed:@"xichedian"] forState:UIControlStateNormal];
    [jiayouzhan setBackgroundImage:[UIImage imageNamed:@"jiayouzhan"] forState:UIControlStateNormal];
    [tingcehchang setBackgroundImage:[UIImage imageNamed:@"tingchechang_bai"] forState:UIControlStateNormal];
    [jigou setBackgroundImage:[UIImage imageNamed:@"jigou"] forState:UIControlStateNormal];
    [weixiuzhan setBackgroundImage:[UIImage imageNamed:@"jixiudian_huang"] forState:UIControlStateNormal];
    strType = @"car_repair";
    [self showProgressIndicator:@"Searching..."];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [self googlePlace];
    });
}
- (IBAction)clickCafe:(id)sender {
    [xichedian setBackgroundImage:[UIImage imageNamed:@"xichedian"] forState:UIControlStateNormal];
    [jiayouzhan setBackgroundImage:[UIImage imageNamed:@"jiayouzhan"] forState:UIControlStateNormal];
    [tingcehchang setBackgroundImage:[UIImage imageNamed:@"tingchechang"] forState:UIControlStateNormal];
    [jigou setBackgroundImage:[UIImage imageNamed:@"jigou"] forState:UIControlStateNormal];
    [weixiuzhan setBackgroundImage:[UIImage imageNamed:@"jixiudian"] forState:UIControlStateNormal];
    strType = @"parking";
    [self showProgressIndicator:@"Searching..."];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [self googlePlace];
    });
}

- (IBAction)clickPolice:(id)sender {
    [xichedian setBackgroundImage:[UIImage imageNamed:@"xichedian"] forState:UIControlStateNormal];
    [jiayouzhan setBackgroundImage:[UIImage imageNamed:@"jiayouzhan"] forState:UIControlStateNormal];
    [tingcehchang setBackgroundImage:[UIImage imageNamed:@"tingchechang_bai"] forState:UIControlStateNormal];
    [jigou setBackgroundImage:[UIImage imageNamed:@"jigou_huang"] forState:UIControlStateNormal];
    [weixiuzhan setBackgroundImage:[UIImage imageNamed:@"jixiudian"] forState:UIControlStateNormal];
    strType = @"police";
    [self showProgressIndicator:@"Searching..."];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [self googlePlace];
    });
}

-(void)clickMapCellButton:(ButtonType)aType placeDetails:(PlaceDetailVO *)aVO
{
    if (aType == ButtonType_Profile) {
        DetailsViewController *vc = [[DetailsViewController alloc]init];
        vc.placeDetailVO = aVO;
        [self.navigationController pushViewController:vc animated:YES];
    }
    else if(aType == ButtonType_Distance)
    {
    
    }
    else if(aType == ButtonType_More)
    {
        
    }

}

#pragma mark - PlaceSearch
-(void)googlePlace
{
    if (!strType) {
        return;
    }
    [self accessGooglePlaceAPI:5000 latitude:newLocCoordinate.latitude longitude:newLocCoordinate.longitude placeType:strType placeContainName:@""];
    
}

-(void)accessGooglePlaceAPI:(CGFloat)radius latitude:(CGFloat)lat longitude:(CGFloat)lon placeType:(NSString *)type placeContainName:(NSString *)name
{
    NSString *urlString = [NSString stringWithFormat:PlaceURLString,lat,lon,radius,type,name];
    NSURL *googlePlacesURL = [NSURL URLWithString:[urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    NSData *xmlData = [NSData dataWithContentsOfURL:googlePlacesURL];
    
    //【 使用use NSXMLParserDelegate】
     NSMutableArray *placeMuAry = [XMLHelper useNSXMLParserDelegateToGetResult:xmlData];
    
    // 【使用方法2：addAnnotations】
      dispatch_async(dispatch_get_main_queue(), ^{
         
           [self placeThePinsByAnnotationAry:placeMuAry annoType:type];
      });
   
}

#pragma mark - methods

-(void)removeAllAnnotations
{
    id userAnnotation = self.mapView.userLocation;
    
    NSMutableArray *annotations = [NSMutableArray arrayWithArray:self.mapView.annotations];
    [annotations removeObject:userAnnotation];
    
    [self.mapView removeAnnotations:annotations];
}

//放置位置指示针【方法2】
-(void)placeThePinsByAnnotationAry:(NSMutableArray *)aPlaceAry  annoType:(NSString *)aType
{
    NSLog(@"Place pins by using  [mMapView addAnnotations:annoAry]");
    
    [self hideProgressIndicator];
    
    [self removeAllAnnotations];
    [_annotationList removeAllObjects];
    
    [_annotationList addObjectsFromArray:aPlaceAry];
    
    for (int i=0; i<[aPlaceAry count]; i++) {
        PlaceDetailVO *place = [aPlaceAry objectAtIndex:i];
        CLLocationCoordinate2D coor;
        coor.latitude = [place.pLatStr floatValue];
        coor.longitude = [place.pLngStr floatValue];
         PinAnnotation *pinAnno = [[PinAnnotation alloc]initWithLatitude: coor.latitude andLongitude:coor.longitude];
        pinAnno.type = aType;
        pinAnno.tag = i+100;
         [self.mapView addAnnotation:pinAnno];
    }

   
}


-(void)setAnnotionsWithList:(NSArray *)list
{
  
    for (NSDictionary *dic in list) {
        
        CLLocationDegrees latitude=[[dic objectForKey:@"latitude"] doubleValue];
        CLLocationDegrees longitude=[[dic objectForKey:@"longitude"] doubleValue];
        CLLocationCoordinate2D location=CLLocationCoordinate2DMake(latitude, longitude);
        
        MKCoordinateRegion region=MKCoordinateRegionMakeWithDistance(location,span_Num ,span_Num );
        MKCoordinateRegion adjustedRegion = [_mapView regionThatFits:region];
        [_mapView setRegion:adjustedRegion animated:YES];
        
        PinAnnotation *  annotation=[[PinAnnotation alloc] initWithLatitude:latitude andLongitude:longitude];
       
        [_mapView   addAnnotation:annotation];
    }
}

- (void)showProgressIndicator:(NSString *)text {
	//[UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
	self.view.userInteractionEnabled = FALSE;
	if(!progressHUD) {
		CGFloat w = 160.0f, h = 120.0f;
		progressHUD = [[UIProgressHUD alloc] initWithFrame:CGRectMake((self.view.frame.size.width-w)/2, (self.view.frame.size.height-h)/2, w, h)];
		[progressHUD setText:text];
		[progressHUD showInView:self.view];
	}
}

- (void)hideProgressIndicator {
	//[UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
	self.view.userInteractionEnabled = TRUE;
	if(progressHUD) {
		[progressHUD hide];
		self.progressHUD = nil;
        
	}
}

#pragma mark - 

//选中MKAnnotationView
- (void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view {
	if ([view.annotation isKindOfClass:[PinAnnotation class]]) {
        if (_detailsAnnotation) {
            [mapView removeAnnotation:_detailsAnnotation];
            _detailsAnnotation = nil;
        }
        _detailsAnnotation = [[DetailsAnnotation alloc]
                               initWithLatitude:view.annotation.coordinate.latitude
                               andLongitude:view.annotation.coordinate.longitude];
        PinAnnotation *anno = (PinAnnotation *)view.annotation;
        _detailsAnnotation.tag = anno.tag;
        
        [mapView addAnnotation:_detailsAnnotation];
        
       
        
        [mapView setCenterCoordinate:_detailsAnnotation.coordinate animated:YES];
	}
    else{
//        if([delegate respondsToSelector:@selector(customMKMapViewDidSelectedWithInfo:)]){
//            [delegate customMKMapViewDidSelectedWithInfo:@"点击至之后你要在这干点啥"];
//        }
    }
}

//选中完MKAnnotationView
- (void)mapView:(MKMapView *)mapView didDeselectAnnotationView:(MKAnnotationView *)view {
    if (_detailsAnnotation&& ![view isKindOfClass:[DetailsAnnotation class]]) {
        if (_detailsAnnotation.coordinate.latitude == view.annotation.coordinate.latitude&&
            _detailsAnnotation.coordinate.longitude == view.annotation.coordinate.longitude) {
            [mapView removeAnnotation:_detailsAnnotation];
            _detailsAnnotation = nil;
        }
    }
}

//设置MKAnnotation上的annotationView
- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation {
	if ([annotation isKindOfClass:[DetailsAnnotation class]]) {
        
        DetailsAnnotationView *annotationView = [[DetailsAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"DetailsAnnotationView"];
        DetailsAnnotation *anno = annotation;
        PlaceDetailVO *place = [_annotationList objectAtIndex:anno.tag-100];
        
        MapCell  *cell = [MapCell getInstanceWithNibWithBlock:^(ButtonType aType) {
            [self clickMapCellButton:aType placeDetails:place];
        }];
      
        cell.placeDetailVO = place;
        [cell toAppearItemsView];
        [annotationView.contentView addSubview:cell];
        
        return annotationView;
	} else if ([annotation isKindOfClass:[PinAnnotation class]]) {
        
        MKAnnotationView *annotationView =[self.mapView dequeueReusableAnnotationViewWithIdentifier:@"PinAnnotation"];
        if (!annotationView) {
            annotationView = [[MKAnnotationView alloc] initWithAnnotation:annotation
                                                           reuseIdentifier:@"PinAnnotation"];
            annotationView.canShowCallout = NO;
            annotationView.image = [UIImage imageNamed:@"dot.png"];
        }
		
		return annotationView;
    }
	return nil;
}
- (void)resetAnnitations:(NSArray *)data
{
    [_annotationList removeAllObjects];
    [_annotationList addObjectsFromArray:data];
    [self setAnnotionsWithList:_annotationList];
}

#pragma mark -
#pragma mark CLLocationManagerDelegate

// 用户位置更新后，会调用此函数
- (IBAction)dingwei:(id)sender {
    
    self.mapView.showsUserLocation = YES;
}

- (IBAction)shuaxin:(id)sender {
    [self showProgressIndicator:@"Searching..."];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [self googlePlace];
    });

}


- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
	[locationManager stopUpdatingLocation];
	[locationManager stopUpdatingHeading];
	
	[[self.mapView viewForAnnotation:[self.mapView userLocation]] setTransform:CGAffineTransformIdentity];
	
}


@end
