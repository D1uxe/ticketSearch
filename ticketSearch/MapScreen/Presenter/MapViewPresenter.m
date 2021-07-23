//
//  MapViewPresenter.m
//  ticketSearch
//
//  Created by MacBook Pro on 01.07.2021.
//

#import "MapViewPresenter.h"
#import "LocationService.h"
#import "APIManager.h"
#import "DataManager.h"

@interface MapViewPresenter ()

@property (nonatomic, strong) LocationService *locationService;

@end

@implementation MapViewPresenter

//MARK: - Initialisers

- (instancetype)init
{
	self = [super init];
	if (self) {

		_locationService = [LocationService new];

		[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateCurrentLocation:) name:kLocationServiceDidUpdateCurrentLocation object:nil];
	}
	return self;
}

- (void)updateCurrentLocation:(NSNotification *)notification {

	City *origin;

	CLLocation *currentLocation = notification.object;
	MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(currentLocation.coordinate, 1000000, 1000000);
	[_viewInput setMapRegion:region];

	if (currentLocation) {

		origin = [[DataManager shared] getCityForLocation:currentLocation];
		if (origin) {
			[[APIManager shared] getMapPriceWithFor:origin withCompletion:^(NSArray *prices) {
				[self->_viewInput removeMapAnnotation];

				for (MapPrice *price in prices) {
					//dispatch_async(dispatch_get_main_queue(), ^{
						MKPointAnnotation *annotation = [[MKPointAnnotation alloc] init];
						annotation.title = [NSString stringWithFormat:@"%@ (%@)", price.destination.name, price.destination.code];
						annotation.subtitle = [NSString stringWithFormat:@"%ld руб.", (long)price.value];
						annotation.coordinate = price.destination.coordinate;
						[self->_viewInput addMapAnnotation: annotation];
					//});
				}
			}];
		}
	}
}


//MARK: - Deinitialisers

- (void)dealloc {

	[[NSNotificationCenter defaultCenter] removeObserver:self
													name:kLocationServiceDidUpdateCurrentLocation
												  object:nil];
}



//MARK: ViewOutput protocol


@end
