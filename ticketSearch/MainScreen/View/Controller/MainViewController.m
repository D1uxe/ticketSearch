//
//  MainViewController.m
//  ticketSearch
//
//  Created by MacBook Pro on 20.06.2021.
//

#import "MainViewController.h"
#import "MainView.h"

@class PlaceViewController;

@interface MainViewController ()

@property (nonatomic, strong) MainView *mainView;

@end

@implementation MainViewController

//MARK: - Initialisers

- (instancetype)initWithPresenter:(id<MainViewOutput>)presenter
{
	self = [super init];
	if (self) {
		_presenter = presenter;
	}
	return self;
}

//MARK: - Private properties

-(MainView*) mainView {

	// Странно почему геттер не срабатывает??

	return (MainView*) self.view;
}


//MARK: Life cycle

- (void)viewDidLoad {
	[super viewDidLoad];

	[_presenter viewRequestData];

	self.title = @"Поиск";

	_mainView = (MainView*) self.view;

	[_mainView.departureButton addTarget:self action:@selector(placeButtonDidTap:) forControlEvents:UIControlEventTouchUpInside];
	[_mainView.arrivalButton addTarget:self action:@selector(placeButtonDidTap:) forControlEvents:UIControlEventTouchUpInside];

}

- (void)loadView {
	self.view = [MainView new];
}

//MARK: - Private methods

- (void)placeButtonDidTap:(UIButton *)sender {

	PlaceType placeType = [sender isEqual:_mainView.departureButton] ? PlaceTypeDeparture : PlaceTypeArrival;

	[self.presenter viewDidTapButtonWithType:placeType];
}



//MARK: - ViewInput protocol

- (void)setTitleForButton:(NSString *)placeTitle withPlaceType:(PlaceType)placeType {

	UIButton *button = (placeType == PlaceTypeDeparture) ? _mainView.departureButton : _mainView.arrivalButton;

	[button setTitle:placeTitle forState:UIControlStateNormal];
}

@end
