//
//  MapViewBuilder.m
//  ticketSearch
//
//  Created by MacBook Pro on 01.07.2021.
//

#import "MapViewBuilder.h"
#import "MapViewController.h"


@implementation MapViewBuilder

+ (UIViewController *)build {

	MapViewPresenter *presenter = [MapViewPresenter new];
	MapViewController *viewController = [[MapViewController alloc] initWithPresenter:presenter];
	presenter.viewInput = viewController;

	return viewController;
}

@end
