//
//  MainView.m
//  ticketSearch
//
//  Created by MacBook Pro on 20.06.2021.
//

#import "MainView.h"

static CGFloat const cornerRadius = 4.0;

@interface MainView ()

@property (nonatomic, strong) UIView *containerView;

@end


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

	[self addContainerView];
	[self addDepartureButton];
	[self addArrivalButton];
	[self addSearchButton];
	[self addActivityIndicator];

}


-(void)addContainerView {

	_containerView = [[UIView alloc] initWithFrame:CGRectMake(20.0,
															  140.0,
															  UIScreen.mainScreen.bounds.size.width - 40.0,
															  170.0)];
	_containerView.backgroundColor = UIColor.whiteColor;

	_containerView.layer.shadowColor = [[[UIColor blackColor] colorWithAlphaComponent:0.1] CGColor];
	_containerView.layer.shadowOffset = CGSizeZero;
	_containerView.layer.shadowRadius = 20.0;
	_containerView.layer.shadowOpacity = 1.0;
	_containerView.layer.cornerRadius = 6.0;

	[self addSubview: _containerView];
}

-(void)addDepartureButton {

	_departureButton = [UIButton buttonWithType:UIButtonTypeSystem];
	[_departureButton setTitle:@"Откуда" forState:UIControlStateNormal];
	_departureButton.tintColor = UIColor.blackColor;
	_departureButton.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.3];
	_departureButton.layer.cornerRadius = cornerRadius;
	_departureButton.frame = CGRectMake(10.0,
										20.0,
										_containerView.frame.size.width - 20.0,
										60.0);
	
	[_containerView addSubview:_departureButton];
}

-(void)addArrivalButton {

	_arrivalButton = [UIButton buttonWithType:UIButtonTypeSystem];
	[_arrivalButton setTitle:@"Куда" forState:UIControlStateNormal];
	_arrivalButton.tintColor = UIColor.blackColor;
	_arrivalButton.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.3];
	_arrivalButton.layer.cornerRadius = cornerRadius;
	_arrivalButton.frame = CGRectMake(10.0,
									  CGRectGetMaxY(_departureButton.frame) + 10.0,
									  _containerView.frame.size.width - 20.0,
									  60.0);

	[_containerView addSubview:_arrivalButton];
}

-(void)addSearchButton {

	_searchButton = [UIButton buttonWithType:UIButtonTypeSystem];
	[_searchButton setTitle:@"Найти" forState:UIControlStateNormal];
	_searchButton.tintColor = UIColor.whiteColor;
	_searchButton.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.9];
	_searchButton.titleLabel.font = [UIFont systemFontOfSize:20.0 weight:UIFontWeightBold];
	_searchButton.layer.cornerRadius = cornerRadius + 2.0;
	_searchButton.frame = CGRectMake(30.0,
									 CGRectGetMaxY(_containerView.frame) + 30.0,
									 UIScreen.mainScreen.bounds.size.width - 60.0,
									 60.0);

	[self addSubview:_searchButton];
}

-(void)addActivityIndicator {

	_activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleMedium];
	_activityIndicator.center = _departureButton.center;
	[_containerView addSubview:_activityIndicator];
}

/* Эксперимент с добавлением кнопок в stackView
-(void)add {

	_sv = [[UIStackView alloc] initWithFrame:CGRectMake(20.0, 140.0, UIScreen.mainScreen.bounds.size.width - 40.0, 170.0)];
	_sv.axis = UILayoutConstraintAxisVertical;
	_sv.distribution = UIStackViewDistributionFillEqually;
	_sv.alignment = UIStackViewAlignmentFill;
	_sv.spacing = 10;
	_sv.backgroundColor = UIColor.whiteColor;


	UIButton *but1 = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, _sv.frame.size.width - 20, 60)];
	UIButton *but2 = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, _sv.frame.size.width - 20, 60)];
	but1.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.3];
	but2.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.3];

	[_sv addArrangedSubview:but1];
	[_sv addArrangedSubview:but2];

	[self addSubview:_sv];
}
*/

@end
