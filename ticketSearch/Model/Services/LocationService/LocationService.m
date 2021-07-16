//
//  LocationService.m
//  ticketSearch
//
//  Created by MacBook Pro on 01.07.2021.
//

#import "LocationService.h"
#import "NSString+Localize.h"

@interface LocationService () 

@property (nonatomic, strong) CLLocationManager *locationManager;
@property (nonatomic, strong) CLLocation *currentLocation;

@end


@implementation LocationService

//MARK: - Initialisers

- (instancetype)init {

	self = [super init];
	if (self) {
		_locationManager = [[CLLocationManager alloc] init];
		_locationManager.delegate = self;
		[_locationManager requestAlwaysAuthorization];
	}
	return self;
}


//MARK: - CLLocationManager Delegate

- (void)locationManagerDidChangeAuthorization:(CLLocationManager *)manager {

	CLAuthorizationStatus status = manager.authorizationStatus;

	if (status == kCLAuthorizationStatusAuthorizedAlways || status == kCLAuthorizationStatusAuthorizedWhenInUse) {

		[_locationManager startUpdatingLocation];

	} else if (status != kCLAuthorizationStatusNotDetermined) {

		NSLog(@"%@", [@"not_determine_current_city" localize]);
//		UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Упс!" message:@"Не удалось определить текущий город!" preferredStyle: UIAlertControllerStyleAlert];
//
//		[alertController addAction:[UIAlertAction actionWithTitle:@"Закрыть" style:(UIAlertActionStyleDefault) handler:nil]];
//
//		[[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alertController animated:YES completion:nil];
	}
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {

	if (!_currentLocation) {
		  _currentLocation = [locations firstObject];
		  [_locationManager stopUpdatingLocation];
		  [[NSNotificationCenter defaultCenter] postNotificationName:kLocationServiceDidUpdateCurrentLocation object:_currentLocation];
	  }
}

@end
