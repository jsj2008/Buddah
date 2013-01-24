//
//  Bud_MapViewController.m
//  Buddah
//
//  Created by Saxon Parker on 12/2/12.
//  Copyright (c) 2012 Saxon Parker. All rights reserved.
//

#import "Bud_MapViewController.h"
#import <MapKit/MapKit.h>
#import "Bud_DealViewController.h"

/* the range around the user's locaiton that we pull in deals for
    (in degrees) */
#define LATITUDE_SPAN 2.0
#define LONGITUDE_SPAN 2.0

/* This is the distance the map center is from the center of our deal region
    that we will want to pull in new deals */
#define REGION_DELTA 1.6

@interface Bud_MapViewController () <MKMapViewDelegate>
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (strong, nonatomic) CLLocation *userLoc;
@property (nonatomic) CLLocationCoordinate2D dealCenter;
@property (strong, nonatomic) Listing *dealToDisplay;
@property (nonatomic) BOOL haveFoundFirstLocation;
@end

@implementation Bud_MapViewController

@synthesize mapView = _mapView;
@synthesize annotations = _annotations;
@synthesize dealToDisplay = _dealToDisplay;

/* These functions make sure the map is updated any time the 
    outlet or annotations are set */
- (void)updateMapView{
    if(self.mapView.annotations){
        [self.mapView removeAnnotations:self.mapView.annotations];
    }
    if(self.annotations){
        [self.mapView addAnnotations:self.annotations];
    }
}

- (void)setMapView:(MKMapView *)mapView{
    _mapView = mapView;
    [self updateMapView];
}

- (void)setAnnotations:(NSArray *)annotations{
    _annotations = annotations;
    [self updateMapView];
}

/* Map View Delegate methods */
- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation {
    if(annotation == self.mapView.userLocation) return nil;
    MKAnnotationView *aView = [mapView dequeueReusableAnnotationViewWithIdentifier:@"MapVC"];
    if(!aView){
        aView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"MapVC"];
        aView.canShowCallout = YES;
        aView.rightCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
    }
    aView.annotation = annotation;
    return aView;
}

- (void)mapView:(MKMapView *)mapView didDeselectAnnotationView:(MKAnnotationView *)aView{
    NSLog(@"%@", [(Bud_MapAnnotation*)aView.annotation title]);
}

- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)aView calloutAccessoryControlTapped:(UIControl *)control{
    self.dealToDisplay = ((Bud_MapAnnotation*)aView.annotation).deal;
    [self performSegueWithIdentifier:@"viewDealSegue" sender:self];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if( [segue.identifier isEqualToString:@"viewDealSegue"]){
        [segue.destinationViewController setDeal:self.dealToDisplay];
    }
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)findDeals{
    //now that we know where we are, let's find some deals!
    CLLocationCoordinate2D coord = self.dealCenter;
    //dispatch to a new queue
    dispatch_queue_t downloadQueue = dispatch_queue_create("Get Deals Queue", NULL);
    dispatch_async(downloadQueue, ^{
        GetDeals *deals = [[GetDeals alloc] init];
        deals.userId = [RestfulCalls getUserID];
        Position *pos = [[Position alloc] init];
        pos.latitude = [[NSNumber alloc]initWithDouble:coord.latitude];
        pos.longitude = [[NSNumber alloc]initWithDouble:coord.longitude];
        deals.position = pos;
        deals.xOffset = [[NSNumber alloc]initWithDouble:LONGITUDE_SPAN];
        deals.yOffset = [[NSNumber alloc] initWithDouble:LATITUDE_SPAN];
        GetDeals *result = [RestfulCalls getDealsRequest:deals];
        if(result){
            NSLog(@"Got result from getDealsRequest, count = %u", result.listings.count);
            if (result.listings.count > 0){
                NSMutableArray *annotes = [[NSMutableArray alloc] initWithCapacity:[result.listings count]];
                for(int i = 0; i < result.listings.count; i++){
                    [annotes addObject:[Bud_MapAnnotation annotationForDeal:[result.listings objectAtIndex:i]]];
                }
                //switch back to main thread for UI related call
                dispatch_async(dispatch_get_main_queue(), ^{
                    self.annotations = annotes; 
                });
            }
        }
    });
//    dispatch_release(downloadQueue);
}

-(void)mapView:(MKMapView *)mapView regionWillChangeAnimated:(BOOL)animated{
    CLLocationCoordinate2D mapCenter = self.mapView.region.center;
    if (ABS(self.dealCenter.latitude - mapCenter.latitude) > REGION_DELTA ||
        ABS(self.dealCenter.longitude - mapCenter.longitude) > REGION_DELTA){
        NSLog(@"updating deal info: old center = %f, %f newcenter = %f, %f",self.dealCenter.latitude, self.dealCenter.longitude, mapCenter.latitude, mapCenter.longitude);
        self.dealCenter = mapCenter;
        //[self findDeals];
    }
}

- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation{
    if(!self.haveFoundFirstLocation){
        [self.mapView setRegion:MKCoordinateRegionMake(CLLocationCoordinate2DMake(userLocation.location.coordinate.latitude, userLocation.location.coordinate.longitude), MKCoordinateSpanMake(1, 1))];
        self.userLoc = userLocation.location;
        self.haveFoundFirstLocation = YES;
        self.dealCenter = userLocation.coordinate;
        //[self findDeals];
    }
}

- (void)viewDidAppear:(BOOL)animated{

}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
	// Do any additional setup after loading the view.
    self.mapView.delegate = self;
    //create a few fake annotations for testing
    NSDate *curDate = [[NSDate alloc] init];
    Listing * deal1 = [[Listing alloc] init];
    deal1.description = @"decent dank";
    deal1.price = [[NSNumber alloc] initWithFloat:1.34];
    deal1.startTime = [[NSNumber alloc] initWithFloat:[curDate timeIntervalSince1970]];
    NSTimeInterval time1 = 2*60*60;
    deal1.duration = [[NSNumber alloc] initWithFloat:time1];
    deal1.rating = [[NSNumber alloc] initWithFloat:1.34];
    Position *pos1 = [[Position alloc] init];
    pos1.latitude = [[NSNumber alloc] initWithFloat:40.060994];
    pos1.longitude = [[NSNumber alloc] initWithFloat:-105.209798];
    deal1.position  = pos1;
    deal1.username = @"Donkey Kong";
    deal1.cellphone = @"1111111111";
    
    Listing * deal2 = [[Listing alloc] init];
    deal2.description = @"super weed";
    deal2.price = [[NSNumber alloc] initWithFloat:10.25];
    deal2.startTime = [[NSNumber alloc] initWithFloat:[curDate timeIntervalSince1970]];
    NSTimeInterval time2 = 4*60*60;
    deal2.duration = [[NSNumber alloc] initWithFloat:time2];
    deal2.rating = [[NSNumber alloc] initWithFloat:4.34];
    Position *pos2 = [[Position alloc] init];
    pos2.latitude = [[NSNumber alloc] initWithFloat:40.980994];
    pos2.longitude = [[NSNumber alloc] initWithFloat:-104.809798];
    deal2.position  = pos2;
    deal2.username = @"Jumpman";
    deal2.cellphone = @"2222222222";
    
    Listing * deal3 = [[Listing alloc] init];
    deal3.description = @"Oregano";
    deal3.price = [[NSNumber alloc] initWithFloat:1.34];
    deal3.startTime = [[NSNumber alloc] initWithFloat:[curDate timeIntervalSince1970]];
    NSTimeInterval time3 = 6*60*60;
    deal3.duration = [[NSNumber alloc] initWithFloat:time3];
    deal3.rating = [[NSNumber alloc] initWithFloat:43.34];
    Position *pos3 = [[Position alloc] init];
    pos3.latitude = [[NSNumber alloc] initWithFloat:40.320994];
    pos3.longitude = [[NSNumber alloc] initWithFloat:-105.903798];
    deal3.position  = pos3;
    deal3.username = @"The Princess";
    deal3.cellphone = @"3333333333";



    NSMutableArray *annotes = [NSMutableArray array];
    [annotes addObject:[Bud_MapAnnotation annotationForDeal:deal1]];
    [annotes addObject:[Bud_MapAnnotation annotationForDeal:deal2]];
    [annotes addObject:[Bud_MapAnnotation annotationForDeal:deal3]];
    self.annotations = annotes;
    
        //[self.parentViewController.tabBarController setSelectedIndex:1];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
