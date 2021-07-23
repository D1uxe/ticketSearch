//
//  MapViewController.m
//  ticketSearch
//
//  Created by MacBook Pro on 01.07.2021.
//

#import "MapViewController.h"
#import "MapView.h"
#import "NSString+Localize.h"

@interface MapViewController ()

@property (nonatomic, strong) MapView *mapView;

@end

@implementation MapViewController

//MARK: - Initialisers

- (instancetype)initWithPresenter:(id<MapViewOutput>)presenter
{
	self = [super init];
	if (self) {
		_presenter = presenter;
	}
	return self;
}

//MARK: - Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];

	self.title = [@"map_tab" localize];

	_mapView = (MapView*) self.view;

	[_presenter viewRequestTickets];
}

- (void)loadView {
	self.view = [MapView new];
}


//MARK: - ViewInput protocol

- (void)setMapRegion:(MKCoordinateRegion)region {

	[_mapView.mapView setRegion:region animated:YES];
}

- (void)addMapAnnotation:(MKPointAnnotation *)annotation {

	[_mapView.mapView addAnnotation:annotation];
}

- (void)removeMapAnnotation {

	[_mapView.mapView removeAnnotations:_mapView.mapView.annotations];
}

@end
