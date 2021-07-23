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


//MARK: Life cycle

- (void)viewDidLoad {
	[super viewDidLoad];

	self.title = @"Поиск";

	_mainView = (MainView*) self.view;

	[_presenter viewRequestData];

	[_mainView.departureButton addTarget:self action:@selector(placeButtonDidTap:) forControlEvents:UIControlEventTouchUpInside];
	[_mainView.arrivalButton addTarget:self action:@selector(placeButtonDidTap:) forControlEvents:UIControlEventTouchUpInside];
	[_mainView.searchButton addTarget:self action:@selector(searchButtonDidTap:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)loadView {
	self.view = [MainView new];
}

//MARK: - Private methods

- (void)placeButtonDidTap:(UIButton *)sender {

	PlaceType placeType = [sender isEqual:_mainView.departureButton] ? PlaceTypeDeparture : PlaceTypeArrival;

	[self.presenter viewDidTapButtonWithType:placeType];
}

- (void)searchButtonDidTap:(UIButton *)sender {

	[self.presenter viewDidTapSearchButton];
}



//MARK: - ViewInput protocol

- (void)setTitleForButton:(NSString *)placeTitle withPlaceType:(PlaceType)placeType {

	UIButton *button = (placeType == PlaceTypeDeparture) ? _mainView.departureButton : _mainView.arrivalButton;

	[button setTitle:placeTitle forState:UIControlStateNormal];
}

- (void)showActivityIndicator:(BOOL)show {

	show ? [_mainView.activityIndicator startAnimating] : [_mainView.activityIndicator stopAnimating];
}

- (void)showAlert {

	UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Увы!"
																			 message:@"По данному направлению билетов не найдено" preferredStyle: UIAlertControllerStyleAlert];
	[alertController addAction:[UIAlertAction actionWithTitle:@"Закрыть"
														style:(UIAlertActionStyleDefault)
													  handler:nil]];

	[self presentViewController:alertController animated:YES completion:nil];
}

@end
