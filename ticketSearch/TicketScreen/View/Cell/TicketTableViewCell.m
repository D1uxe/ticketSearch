//
//  TicketTableViewCell.m
//  ticketSearch
//
//  Created by MacBook Pro on 28.06.2021.
//

#import "TicketTableViewCell.h"

@interface TicketTableViewCell ()

@property (nonatomic, strong) UIImageView *airlineLogoView;
@property (nonatomic, strong) UILabel *priceLabel;
@property (nonatomic, strong) UILabel *placesLabel;
@property (nonatomic, strong) UILabel *dateLabel;

@end


@implementation TicketTableViewCell

//MARK: - Initialisers

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
	self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
	if (self) {

		[self configureUI];
	}
	return self;
}


//MARK: - Lifecycle

- (void)layoutSubviews {
	[super layoutSubviews];

	self.contentView.frame = CGRectMake(10.0,
										10.0,
										[UIScreen mainScreen].bounds.size.width - 20.0,
										self.frame.size.height - 20.0);

	_priceLabel.frame = CGRectMake(10.0,
								   10.0,
								   self.contentView.frame.size.width - 110.0,
								   40.0);

	_airlineLogoView.frame = CGRectMake(CGRectGetMaxX(_priceLabel.frame) + 10.0,
										10.0,
										80.0,
										80.0);

	_placesLabel.frame = CGRectMake(10.0,
									CGRectGetMaxY(_priceLabel.frame) + 16.0,
									100.0,
									20.0);

	_dateLabel.frame = CGRectMake(10.0,
								  CGRectGetMaxY(_placesLabel.frame) + 8.0,
								  self.contentView.frame.size.width - 20.0,
								  20.0);

}


//MARK: - Private methods

-(void)configureUI {

	self.contentView.layer.shadowColor = [[[UIColor blackColor] colorWithAlphaComponent:0.2] CGColor];
	self.contentView.layer.shadowOffset = CGSizeMake(1.0, 1.0);
	self.contentView.layer.shadowRadius = 10.0;
	self.contentView.layer.shadowOpacity = 1.0;
	self.contentView.layer.cornerRadius = 6.0;
	self.contentView.backgroundColor = [UIColor whiteColor];

	[self addPriceLabel];
	[self addPlacesLabel];
	[self addDateLabel];
	[self addAirlineLogoView];
}

-(void)addPriceLabel {

	_priceLabel = [[UILabel alloc] initWithFrame:self.bounds];
	_priceLabel.font = [UIFont systemFontOfSize:24.0 weight:UIFontWeightBold];

	[self.contentView addSubview:_priceLabel];
}

-(void)addPlacesLabel {

	_placesLabel = [[UILabel alloc] initWithFrame:self.bounds];
	_placesLabel.font = [UIFont systemFontOfSize:15.0 weight:UIFontWeightLight];
	_placesLabel.textColor = [UIColor darkGrayColor];

	[self.contentView addSubview:_placesLabel];
}

-(void)addDateLabel {

	_dateLabel = [[UILabel alloc] initWithFrame:self.bounds];
	_dateLabel.font = [UIFont systemFontOfSize:15.0 weight:UIFontWeightRegular];

	[self.contentView addSubview:_dateLabel];
}

-(void)addAirlineLogoView {

	_airlineLogoView = [[UIImageView alloc] initWithFrame:self.bounds];
	_airlineLogoView.contentMode = UIViewContentModeScaleAspectFit;

	[self.contentView addSubview:_airlineLogoView];
}


//MARK: - Public methods

- (void)configureWith:(CellModel)model {

	_priceLabel.text = model.price;
	_placesLabel.text = model.places;
	_dateLabel.text = model.date;
	_airlineLogoView.image = model.airlineLogo;
}

@end
