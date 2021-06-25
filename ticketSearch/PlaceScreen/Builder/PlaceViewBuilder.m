//
//  PlaceViewBuilder.m
//  ticketSearch
//
//  Created by MacBook Pro on 21.06.2021.
//

#import "PlaceViewBuilder.h"
#import "PlaceViewController.h"

@implementation PlaceViewBuilder

+(UIViewController<PlaceViewInput>*)buildWith:(PlaceType)placeType withPresenter:(id<MainViewOutput>)mainPresenter {
//+(UIViewController<PlaceViewInput>*)build {

	PlaceViewPresenter *presenter = [[PlaceViewPresenter alloc] initWithPresenter:mainPresenter];
	PlaceViewController *viewController = [[PlaceViewController alloc] initWithPresenter:presenter with:placeType];
	presenter.viewInput = viewController;

	return viewController;
}


@end
