//
//  MapView.m
//  ticketSearch
//
//  Created by MacBook Pro on 01.07.2021.
//

#import "MapView.h"

@implementation MapView

- (instancetype)init
{
	self = [super init];
	if (self) {
		
		[self configureUI];
	}
	return self;
}

- (void)configureUI {

	[self addMapView];
}

- (void)addMapView {

	_mapView = [[MKMapView alloc] initWithFrame:UIScreen.mainScreen.bounds];
	_mapView.showsUserLocation = YES;

	[self addSubview:_mapView];
}

@end
