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

@interface Bud_MapViewController () <MKMapViewDelegate>
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (strong, nonatomic) dealData *dealToDisplay;
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

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.mapView.delegate = self;
    /* create a few fake annotations for testing */
    dealData * deal1 = [[dealData alloc] init];
    deal1.descriptionText = @"suck suck";
    deal1.priceText = @"21.42";
    deal1.locationText = @"up my ass";
    deal1.longitude = -104.123;
    deal1.latitude = 39.123421;
    NSTimeInterval time1 = 2*60*60;
    deal1.endTime = [[NSDate alloc] initWithTimeIntervalSinceNow:time1];
    deal1.rating = 2;
    
    dealData * deal2 = [[dealData alloc] init];
    deal2.descriptionText = @"the good shit hi hihihihhi hi hi hi hi hi hi hi hi hi hi hi hi hi hi  hi hi hi hi hi hi hi hi hi hi hi";
    deal2.priceText = @"1.42";
    deal2.locationText = @"up somebody's ass";
    deal2.longitude = -102.123;
    deal2.latitude = 41.123421;
    NSTimeInterval time2 = 3*60*60;
    deal2.endTime = [[NSDate alloc] initWithTimeIntervalSinceNow:time2];
    deal2.rating = 4;
    
    dealData * deal3 = [[dealData alloc] init];
    deal3.descriptionText = @"it'll kill ya";
    deal3.priceText = @"0.01";
    deal3.locationText = @"errywhere";
    deal3.longitude = -105.87;
    deal3.latitude = 40.53421;
    NSTimeInterval time3 = 5*60*60;
    deal3.endTime = [[NSDate alloc] initWithTimeIntervalSinceNow:time3];
    deal3.rating = 1;



    NSMutableArray *annotes = [NSMutableArray array];
    [annotes addObject:[Bud_MapAnnotation annotationForDeal:deal1]];
    [annotes addObject:[Bud_MapAnnotation annotationForDeal:deal2]];
    [annotes addObject:[Bud_MapAnnotation annotationForDeal:deal3]];
    self.annotations = annotes;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
