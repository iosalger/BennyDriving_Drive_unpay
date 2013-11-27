

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

#import "CalloutMapAnnotation.h"
#import "BasicMapAnnotation.h"
#import "ButtomBarD1.h"



@protocol MapViewControllerDidSelectDelegate; 
@interface DriMapVC : ButtomBarD1<CLLocationManagerDelegate,MKMapViewDelegate>
{
    MKMapView *_mapView;
    CLLocationManager *locationManager;
    CLLocationCoordinate2D coordinate;
    CLGeocoder *geoCoder;
    id<MapViewControllerDidSelectDelegate> delegate;
}
@property(nonatomic,retain)IBOutlet MKMapView *mapView;
@property (nonatomic, retain) NSMutableArray *annotationArray;
- (void)locationAddressWithLocation:(CLLocation *)locationGps;

@property(nonatomic,assign)id<MapViewControllerDidSelectDelegate> delegate;

- (void)resetAnnitations:(NSArray *)data;
@end

@protocol MapViewControllerDidSelectDelegate <NSObject>

@optional
- (void)customMKMapViewDidSelectedWithInfo:(id)info;

@end