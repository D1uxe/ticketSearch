//
//  MainView.m
//  ticketSearch
//
//  Created by MacBook Pro on 20.06.2021.
//

#import "MainView.h"

@implementation MainView

- (instancetype)init {

	self = [super init];
	if (self) {
		
		[self configureUI];
	}
	return self;
}

-(void)configureUI {

	self.backgroundColor = UIColor.whiteColor;
	[self addDepartureButton];
	[self addArrivalButton];
}

-(void)addDepartureButton {

	_departureButton = [UIButton buttonWithType:UIButtonTypeSystem];
	[_departureButton setTitle:@"Откуда" forState:UIControlStateNormal];
	_departureButton.tintColor = UIColor.blackColor;
	_departureButton.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.3];
	_departureButton.frame = CGRectMake(30.0,
										140.0,
										[UIScreen mainScreen].bounds.size.width - 60.0,
										60.0);
	
	[self addSubview:_departureButton];
}

-(void)addArrivalButton {

	_arrivalButton = [UIButton buttonWithType:UIButtonTypeSystem];
	[_arrivalButton setTitle:@"Куда" forState:UIControlStateNormal];
	_arrivalButton.tintColor = UIColor.blackColor;
	_arrivalButton.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.3];
	_arrivalButton.frame = CGRectMake(30.0,
									  CGRectGetMaxY(_departureButton.frame) + 20.0,
									  [UIScreen mainScreen].bounds.size.width - 60.0,
									  60.0);

	[self addSubview:_arrivalButton];
}

@end
