//
//  MainViewPresenter.m
//  ticketSearch
//
//  Created by MacBook Pro on 21.06.2021.
//

#import "MainViewPresenter.h"
#import "PlaceViewBuilder.h"
#import "TicketViewBuilder.h"
#import "SearchRequest.h"
#import "APIManager.h"

@interface MainViewPresenter ()

@property (nonatomic) SearchRequest searchRequest;

@end

@implementation MainViewPresenter

//MARK: Private methods

-(void)openPlaceViewWithType:(PlaceType)placeType {

	UIViewController *viewController = [PlaceViewBuilder buildWith:placeType withPresenter:self];

	[_viewInput.navigationController pushViewController:viewController animated:YES];
}

-(void)openTicketView {

	[[APIManager shared] getTicketsWithRequest:_searchRequest withCompletion:^(NSArray *tickets) {

		if (tickets.count > 0) {

			UIViewController *viewController = [TicketViewBuilder buildWithTickets:tickets];
			[self->_viewInput.navigationController pushViewController:viewController animated:YES];

		} else {
			[self->_viewInput showAlert];
		}
	}];
}

-(void)requestData {

	[_viewInput showActivityIndicator:YES];
	[[NSNotificationCenter defaultCenter] addObserver:self
											 selector:@selector(dataLoadedSuccessfully)
												 name:kDataManagerLoadDataDidComplete
											   object:nil];
	[DataManager.shared loadData];
}

- (void)dataLoadedSuccessfully {

	[APIManager.shared getCityForCurrentIP:^(City * _Nonnull city) {
		self->_searchRequest.origin = city.code;
		[self->_viewInput setTitleForButton:city.name withPlaceType:PlaceTypeDeparture];
		[self->_viewInput showActivityIndicator:NO];
	}];
}

//MARK: - Deinitialisers

- (void)dealloc {

	[[NSNotificationCenter defaultCenter] removeObserver:self
													name:kDataManagerLoadDataDidComplete
												  object:nil];
}



//MARK: ViewOutput protocol

- (void)viewDidTapButtonWithType:(PlaceType)placeType {

	[self openPlaceViewWithType:placeType];
}

- (void)viewDidTapSearchButton {

	[self openTicketView];
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

	if (placeType == PlaceTypeDeparture) {
		_searchRequest.origin = iata;
	} else {
		_searchRequest.destination = iata;
	}

	[_viewInput setTitleForButton:title withPlaceType: placeType];
	[_viewInput.navigationController popViewControllerAnimated:YES];
}


@end
