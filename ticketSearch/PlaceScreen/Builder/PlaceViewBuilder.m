//
//  PlaceViewBuilder.m
//  ticketSearch
//
//  Created by MacBook Pro on 21.06.2021.
//

#import "PlaceViewBuilder.h"
#import "PlaceViewController.h"

@implementation PlaceViewBuilder

+(UIViewController<PlaceViewInput>*)build {

	PlaceViewPresenter *presenter = [PlaceViewPresenter new];
	PlaceViewController *viewController = [[PlaceViewController alloc] initWithPresenter:presenter];
	presenter.viewInput = viewController;

	return viewController;
}


@end
