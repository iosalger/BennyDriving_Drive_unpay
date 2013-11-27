

#import "SharedObj.h"
#import "LoginVC.h"
#import "SevCenterVC.h"

#import "LoginVC.h"
#import "StoreRateVC.h"
#import "CounterActionVC.h"
#import "PriceListVC.h"
#import "DriProfileVC.h"
#import "DriRateVC.h"
#import "AccountVC.h"

#import "DriMapVC.h"
#import "CallOutAnnotationVifew.h"
#import "DriverMapCell.h"
//#define span 40000

@interface DriMapVC ()
{
    NSMutableArray *_annotationList;
    
    CalloutMapAnnotation *_calloutAnnotation;
	CalloutMapAnnotation *_previousdAnnotation;
    
}
-(void)setAnnotionsWithList:(NSArray *)list;

@end

@implementation DriMapVC

@synthesize mapView = _mapView;

@synthesize delegate;

- (void)dealloc
{
    [_mapView release];
    [_annotationList release];
    [super dealloc];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


-(void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBarHidden = YES;
    
}

- (void)viewDidLoad
{
    _annotationList = [[NSMutableArray alloc] init];
    [super viewDidLoad];
    
//    if ([CLLocationManager locationServicesEnabled])
//    {
//        locationManager = [[CLLocationManager alloc] init];
//        [locationManager setDelegate:self];
//        locationManager.distanceFilter = 1000;
//        locationManager.desiredAccuracy = kCLLocationAccuracyBest;
//        [locationManager startUpdatingLocation];
//    }
    _mapView.delegate = self;
    _mapView.showsUserLocation = YES;
    
    [super loadBottomBar];

}

-(void)setAnnotionsWithList:(NSArray *)list
{
    for (NSDictionary *dic in list) {
        
        CLLocationDegrees latitude=[[dic objectForKey:@"latitude"] doubleValue];
        CLLocationDegrees longitude=[[dic objectForKey:@"longitude"] doubleValue];
        CLLocationCoordinate2D location=CLLocationCoordinate2DMake(latitude, longitude);
        
        //MKCoordinateRegion region=MKCoordinateRegionMakeWithDistance(location,span ,span );
        MKCoordinateRegion region=MKCoordinateRegionMakeWithDistance(location,40000,40000);
        MKCoordinateRegion adjustedRegion = [_mapView regionThatFits:region];
        [_mapView setRegion:adjustedRegion animated:YES];
        
        BasicMapAnnotation *  annotation=[[[BasicMapAnnotation alloc] initWithLatitude:latitude andLongitude:longitude]  autorelease];
        [_mapView   addAnnotation:annotation];
    }
}


- (void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view {
	if ([view.annotation isKindOfClass:[BasicMapAnnotation class]]) {
        if (_calloutAnnotation.coordinate.latitude == view.annotation.coordinate.latitude&&
            _calloutAnnotation.coordinate.longitude == view.annotation.coordinate.longitude) {
            return;
        }
        if (_calloutAnnotation) {
            [mapView removeAnnotation:_calloutAnnotation];
            _calloutAnnotation = nil;
        }
        _calloutAnnotation = [[[CalloutMapAnnotation alloc] 
                               initWithLatitude:view.annotation.coordinate.latitude
                               andLongitude:view.annotation.coordinate.longitude] autorelease];
        [mapView addAnnotation:_calloutAnnotation];
        
        [mapView setCenterCoordinate:_calloutAnnotation.coordinate animated:YES];
	}
    else{
        if([delegate respondsToSelector:@selector(customMKMapViewDidSelectedWithInfo:)]){
            [delegate customMKMapViewDidSelectedWithInfo:@"点击至之后你要在这干点啥"];
        }
    }
}

- (void)mapView:(MKMapView *)mapView didDeselectAnnotationView:(MKAnnotationView *)view {
    if (_calloutAnnotation&& ![view isKindOfClass:[CallOutAnnotationVifew class]]) {
        if (_calloutAnnotation.coordinate.latitude == view.annotation.coordinate.latitude&&
            _calloutAnnotation.coordinate.longitude == view.annotation.coordinate.longitude) {
            [mapView removeAnnotation:_calloutAnnotation];
            _calloutAnnotation = nil;
        }
    }
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation {
	if ([annotation isKindOfClass:[CalloutMapAnnotation class]]) {

        CallOutAnnotationVifew *annotationView = (CallOutAnnotationVifew *)[mapView dequeueReusableAnnotationViewWithIdentifier:@"CalloutView"];
        if (!annotationView) {
            annotationView = [[[CallOutAnnotationVifew alloc] initWithAnnotation:annotation reuseIdentifier:@"CalloutView"] autorelease];
            DriverMapCell  *cell = [[[NSBundle mainBundle] loadNibNamed:@"DriverMapCell" owner:self options:nil] objectAtIndex:0];
            [annotationView.contentView addSubview:cell];
            
        }
        return annotationView;
	} else if ([annotation isKindOfClass:[BasicMapAnnotation class]]) {
        
         MKAnnotationView *annotationView =[self.mapView dequeueReusableAnnotationViewWithIdentifier:@"CustomAnnotation"];
        if (!annotationView) {
            annotationView = [[[MKAnnotationView alloc] initWithAnnotation:annotation 
                                                           reuseIdentifier:@"CustomAnnotation"] autorelease];
            annotationView.canShowCallout = NO;
            annotationView.image = [UIImage imageNamed:@"drilocation.png"];
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

#pragma mark - ButtonAction
-(IBAction)refresh:(id)sender
{
    [self setAnnotionsWithList:_annotationList];
}

- (IBAction)Location:(id)sender {
    
   if ([CLLocationManager locationServicesEnabled]) { // 检查定位服务是否可用
        locationManager = [[CLLocationManager alloc] init];
        locationManager.delegate = self;
        locationManager.distanceFilter=1000;
        locationManager.desiredAccuracy = kCLLocationAccuracyBest;

        [locationManager startUpdatingLocation]; // 开始定位
    }
    
//    if (_mapView.userLocation.location != nil ) {
//        
//        //Since this method will display the user's location on-screen, we will pre-emptively fade out the component and disable interaction with it
//        //[UIView beginAnimations:nil context:NULL];
//        //[UIView setAnimationDuration:0.5];
//        //[locationIndicatorButton setAlpha:0];
//        //[locationIndicatorArrow setAlpha:0];
//        //[UIView commitAnimations];
//        
//        //locationIndicatorButton.userInteractionEnabled = NO;
//        //locationIndicatorArrow.userInteractionEnabled = NO;
//        
//        MKCoordinateSpan span = _mapView.region.span;
//        
//        MKCoordinateRegion region;
//        region.span = span;
//        region.center = _mapView.userLocation.location.coordinate;
//        
//        [self.mapView setRegion:region animated:YES];
//        
//    }
   else {
    
        //If the user tapped on the location indicator to access this method, then the user location value should never be nil, but this is here in case this method is called in some other way
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Could not find your location" message:@"No user location could be found, please check your phone settings." delegate:nil cancelButtonTitle:@"Ok." otherButtonTitles: nil];
        [alert show];
        [alert release];
        
    }

    
    NSLog(@"GPS 启动");
}



- (IBAction)goSevCentre:(id)sender
{
    

//        NSLog(@"Go Home......");
//        [[NSNotificationCenter defaultCenter] postNotificationName:@"goSevCentre" object:nil];

    if([[SharedObj sharedOBJ].logindriid isEqualToString:@""])
    {
        LoginVC *login = [[LoginVC alloc] init];
        [self.navigationController pushViewController:login animated:YES];
    }else if(![[SharedObj sharedOBJ].logindriid isEqualToString:@""])
    {
        SevCenterVC *scVC = [[SevCenterVC alloc] init];
        [self.navigationController pushViewController:scVC animated:YES];
    }
    
    NSLog(@"服务中心");
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"定位出错");
}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    [manager stopUpdatingLocation];
    
    NSLog(@"%f,%f",newLocation.coordinate.latitude,newLocation.coordinate.longitude);
    coordinate.latitude = newLocation.coordinate.latitude;
    coordinate.longitude = newLocation.coordinate.longitude;
    
    MKCoordinateSpan span = _mapView.region.span;
    MKCoordinateRegion region;
    region.span = span;
    region.center = _mapView.userLocation.location.coordinate;

    //设置显示范围
    region = MKCoordinateRegionMakeWithDistance(coordinate,10000,10000);
    [_mapView setRegion:region animated:TRUE];
    
}

-(void)shareAction{
    
    NSString *textToShare = @"我正在使用邦尼代驾APP,感觉十分不错,你们也来试试,下载地址http://www.4008200972.com";
    UIImage *imageToShare = [UIImage imageNamed:@"icon@2x.png"];
    NSURL *urlToShare = [NSURL URLWithString:@"http://www.4008200972.com"];
    NSArray *activityItems = [NSArray arrayWithObjects:textToShare,imageToShare,urlToShare,nil];
    
    UIActivityViewController *activityVC = [[UIActivityViewController alloc]initWithActivityItems:activityItems applicationActivities:nil];    //不出现在活动项目
    activityVC.excludedActivityTypes = [NSArray arrayWithObjects: UIActivityTypePrint, UIActivityTypeCopyToPasteboard,
                                        UIActivityTypeAssignToContact,UIActivityTypeSaveToCameraRoll,nil];
    [self presentViewController:activityVC animated:TRUE completion:nil];
    
}

-(void)seePriceList
{
    PriceListVC *plv = [[PriceListVC alloc] init];
    [self.navigationController pushViewController:plv animated:YES];
}

-(void)goManage
{
    if([[SharedObj sharedOBJ].logindriid isEqualToString:@""])
    {
        LoginVC *login = [[LoginVC alloc] init];
        [self.navigationController pushViewController:login animated:YES];
    }
    else if(![[SharedObj sharedOBJ].logindriid isEqualToString:@""])
    {
        CounterActionVC *ca = [[CounterActionVC alloc] init];
        [self.navigationController pushViewController:ca animated:YES];
    };
    
}

-(void)seeDriProfile
{
    if([[SharedObj sharedOBJ].logindriid isEqualToString:@""])
    {
        LoginVC *login = [[LoginVC alloc] init];
        [self.navigationController pushViewController:login animated:YES];
    }else if(![[SharedObj sharedOBJ].logindriid isEqualToString:@""])
    {
        DriProfileVC *rate = [[DriProfileVC alloc] init];
        [self.navigationController pushViewController:rate animated:YES];
    }
    
}

-(void)seeDriRate
{
    if([[SharedObj sharedOBJ].logindriid isEqualToString:@""])
    {
        LoginVC *login = [[LoginVC alloc] init];
        [self.navigationController pushViewController:login animated:YES];
    }else if(![[SharedObj sharedOBJ].logindriid isEqualToString:@""])
    {
        DriRateVC *drirate = [[DriRateVC alloc] init];
        [self.navigationController pushViewController:drirate animated:YES];
    }
}

-(void)seeAccount
{
    if([[SharedObj sharedOBJ].logindriid isEqualToString:@""])
    {
        LoginVC *login = [[LoginVC alloc] init];
        [self.navigationController pushViewController:login animated:YES];
    }else if(![[SharedObj sharedOBJ].logindriid isEqualToString:@""])
    {
        AccountVC *AcVC = [[AccountVC alloc] init];
        [self.navigationController pushViewController:AcVC animated:YES];
    }
    
}


-(void)dialSerNum
{
    // open a dialog with an OK and cancel button
	UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"拨打服务热线"
                                                             delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:@"4008200972" otherButtonTitles:nil];
	actionSheet.actionSheetStyle = UIActionSheetStyleDefault;
	[actionSheet showInView:self.view]; // show from our table view (pops up in the middle of the table)
	
}

#pragma mark -
#pragma mark - UIActionSheetDelegate

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
	// the user clicked one of the OK/Cancel buttons
	if (buttonIndex == 0)
	{
		NSLog(@"ok");
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"tel://4008200972"]];
	}
	else
	{
		NSLog(@"cancel");
	}
    
}


@end
