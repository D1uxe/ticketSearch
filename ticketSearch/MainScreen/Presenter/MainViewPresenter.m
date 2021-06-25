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

-(void)openPlaceViewWithType:(PlaceType)placeType {

	UIViewController *viewController = [PlaceViewBuilder buildWith:placeType withPresenter:self];

	[self.viewInput.navigationController pushViewController:viewController animated:YES];
}


-(void)requestData {

	[DataManager.shared loadData];
}


//MARK: ViewOutput protocol

- (void)viewDidTapButtonWithType:(PlaceType)placeType {

	[self openPlaceViewWithType:placeType];
}

- (void)viewRequestData {

	[self requestData];
}
-(void)setPlace:(id _Nonnull )place withType:(PlaceType)placeType {

	NSString *title;
	NSString *iata;

	if ([place isMemberOfClass:[City class]]) {
		City *city = (City *)place;
		title = city.name;
		iata = city.code;
	}
	else if ([place isMemberOfClass:[Airport class]]) {
		Airport *airport = (Airport *)place;
		title = airport.name;
		iata = airport.cityCode;
	}
	/*
	if (placeType == PlaceTypeDeparture) {
		_searchRequest.origin = iata;
	} else {
		_searchRequest.destionation = iata;
	}
*/

	[_viewInput setTitleForButton:title withPlaceType: placeType];
	[self.viewInput.navigationController popViewControllerAnimated:YES];
}

@end
