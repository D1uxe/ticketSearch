//
//  MainViewBuilder.m
//  ticketSearch
//
//  Created by MacBook Pro on 21.06.2021.
//

#import "MainViewBuilder.h"
#import "MainViewController.h"

@implementation MainViewBuilder

+(UIViewController<MainViewInput>*)build {

	MainViewPresenter *presenter = [MainViewPresenter new];
	MainViewController *viewController = [[MainViewController alloc] initWithPresenter:presenter];
	presenter.viewInput = viewController;

	return viewController;
}

@end
