//
//  MapViewController.m
//  MARTAmobility
//
//  Created by Darshan Gulur Srinivasa on 10/29/16.
//  Copyright © 2016 Marta. All rights reserved.
//

#import "MapViewController.h"
#import <MapKit/MapKit.h>
#import "DataManager.h"
#import "Position.h"

@interface MapViewController () <MKMapViewDelegate, CLLocationManagerDelegate>
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (strong, nonatomic) NSMutableArray *positions;
@property (strong, nonatomic) CLLocationManager *locationManager;
@end

@implementation MapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIBarButtonItem *logoutButton = [[UIBarButtonItem alloc] initWithTitle:@"Cancel Trip" style:UIBarButtonItemStyleDone target:self action:nil];
    self.navigationItem.rightBarButtonItem = logoutButton;
    
    [self.locationManager startUpdatingLocation];
    // Do any additional setup after loading the view.
    [self loadPositions];
}

- (CLLocationManager *)locationManager
{
    if (!_locationManager)
    {
        _locationManager = [[CLLocationManager alloc] init];
        _locationManager.delegate = self;
        [_locationManager requestWhenInUseAuthorization];
    }
    return _locationManager;
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    // [self drawRoute];
}

- (void)loadPositions {
    [[DataManager sharedManager] listOfPositions:^(NSArray *positions, NSError *error) {
        if (error == nil) {
            self.positions = [positions mutableCopy];
            
            self.mapView.delegate = self;
            self.mapView.showsUserLocation = YES;
            Position *position = [positions objectAtIndex:0];
            
            CLLocationCoordinate2D storeLocation = CLLocationCoordinate2DMake([position.LATITUDE doubleValue], [position.LONGITUDE doubleValue]);
            MKCoordinateSpan span = MKCoordinateSpanMake(.01, .01);
            [self.mapView setRegion:MKCoordinateRegionMake(storeLocation, span) animated:YES];
            
            // [self drawRoute];
        }
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)callMARTATapped:(id)sender {
    NSString *stringURL = @"tel:phonenumber";
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:stringURL]];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
