//
//  ContentView.m
//  ticketSearch
//
//  Created by MacBook Pro on 12.07.2021.
//

#import "ContentView.h"

@implementation ContentView

- (instancetype)init
{
	self = [super init];
	if (self) {

		[self configureUI];
	}
	return self;
}

-(void)configureUI {

	self.backgroundColor = UIColor.whiteColor;

	[self addImageView];
	[self addTitleLabel];
	[self addContentLabel];
}

-(void)addImageView {

	_imageView = [[UIImageView alloc] initWithFrame:CGRectMake(UIScreen.mainScreen.bounds.size.width/2 - 100,
															   UIScreen.mainScreen.bounds.size.height/2 - 100,
															   200,
															   200)];
	_imageView.contentMode = UIViewContentModeScaleAspectFill;
	_imageView.layer.cornerRadius = 8.0;
	_imageView.clipsToBounds = YES;

	[self addSubview:_imageView];

}

-(void)addTitleLabel {

	_titleLabel = [[UILabel alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width/2 - 100.0,
															CGRectGetMinY(_imageView.frame) - 61.0,
															200.0,
															21.0)];
	_titleLabel.font = [UIFont systemFontOfSize:20.0 weight:UIFontWeightHeavy];
	_titleLabel.numberOfLines = 0;
	_titleLabel.textAlignment = NSTextAlignmentCenter;

	[self addSubview:_titleLabel];
}

-(void)addContentLabel {

	_contentLabel = [[UILabel alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width/2 - 100.0,
															  CGRectGetMaxY(_imageView.frame) + 20.0,
															  200.0,
															  21.0)];
	_contentLabel.font = [UIFont systemFontOfSize:17.0 weight:UIFontWeightSemibold];
	_contentLabel.numberOfLines = 0;
	_contentLabel.textAlignment = NSTextAlignmentCenter;

	[self addSubview:_contentLabel];

}

@end
