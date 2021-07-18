//
//  PlaceViewController.m
//  ticketSearch
//
//  Created by MacBook Pro on 20.06.2021.
//

#import "PlaceViewController.h"
#import "PlaceView.h"

@interface PlaceViewController ()

@end

@implementation PlaceViewController

//MARK: Initialisers

- (instancetype)initWithPresenter:(PlaceViewPresenter *)presenter
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

	self.title = @"Города";

}

- (void)loadView {
	self.view = [PlaceView new];
}


@end
