//
//  PlaceViewPresenter.m
//  ticketSearch
//
//  Created by MacBook Pro on 21.06.2021.
//

#import "PlaceViewPresenter.h"
#import "MainViewPresenter.h"

@interface PlaceViewPresenter()

@property(nonatomic, strong) MainViewPresenter *mainPresenter; // Здесь лучше использовать тип протокла id<MainViewOutput>.

@end

@implementation PlaceViewPresenter

- (instancetype)initWithPresenter:(MainViewPresenter *)mainPresenter // Здесь лучше использовать тип протокла id<MainViewOutput>. Но почему-то ошибка. Что-то с подключениями хэдеров
{
	self = [super init];
	if (self) {
		_mainPresenter = mainPresenter;
	}
	return self;
}

//MARK: Private methods

-(void)setDataSourceWithSelectedSegment: (NSInteger)selectedIndex {

	switch (selectedIndex) {
		case 0:
			_viewInput.currentSourceArray = DataManager.shared.cities;
			break;
		case 1:
			_viewInput.currentSourceArray = DataManager.shared.airports;
			break;
	}
	 [_viewInput reloadTable];
}

- (void)selectPlace:(id _Nonnull)place withType:(PlaceType)placeType {

	[_mainPresenter setPlace:place withType:placeType];
}




//MARK: ViewOutput protocol

- (void)viewDidSelectSourceWith:(NSInteger)selectedIndex {

	[self setDataSourceWithSelectedSegment:selectedIndex];
	
}

- (void)viewDidSelectPlace:(id _Nonnull)place withType:(PlaceType)placeType {

	[self selectPlace:place withType:placeType];
}


@end
