//
//  MainViewPresenter.m
//  ticketSearch
//
//  Created by MacBook Pro on 21.06.2021.
//

#import "MainViewPresenter.h"
#import "PlaceViewBuilder.h"

@implementation MainViewPresenter

//MARK: Private methods

-(void)openPlaceView {

	UIViewController *viewController = [PlaceViewBuilder build];
	[self.viewInput.navigationController pushViewController:viewController animated:YES];
}

//MARK: ViewOutput protocol

- (void)viewDidTapButton {

	[self openPlaceView];
}

@end
