//
//  ContentViewController.m
//  ticketSearch
//
//  Created by MacBook Pro on 12.07.2021.
//

#import "ContentViewController.h"

@interface ContentViewController ()

@property(nonatomic, strong) ContentView *contentView;

@end

@implementation ContentViewController

//MARK: - Public properties

- (void)setTitle:(NSString *)title {

	_contentView.titleLabel.text = title;
	float height = heightForText(title, _contentView.titleLabel.font, 200.0);
	_contentView.titleLabel.frame = CGRectMake([UIScreen mainScreen].bounds.size.width/2 - 100.0,
											   CGRectGetMinY(_contentView.imageView.frame) - 40.0 - height,
											   200.0,
											   height);
}

- (void)setContentText:(NSString *)contentText {

	_contentText = contentText;
	_contentView.contentLabel.text = contentText;
	float height = heightForText(contentText, _contentView.contentLabel.font, 200.0);
	_contentView.contentLabel.frame = CGRectMake([UIScreen mainScreen].bounds.size.width/2 - 100.0,
												 CGRectGetMaxY(_contentView.imageView.frame) + 20.0,
												 200.0,
												 height);
}

- (void)setImage:(UIImage *)image {

	_image = image;
	_contentView.imageView.image = image;
}


//MARK: - Initialisers

- (instancetype)init
{
	self = [super init];
	if (self) {
		_contentView = (ContentView *) self.view;
	}
	return self;
}


//MARK: - Lifecycle

- (void)viewDidLoad {
	[super viewDidLoad];
}

- (void)loadView {
	self.view = [ContentView new];
}


//MARK: - Private methods

float heightForText(NSString *text, UIFont *font, float width) {
	if (text && [text isKindOfClass:[NSString class]]) {
		CGSize size = CGSizeMake(width, FLT_MAX);
		CGRect needLabel = [text boundingRectWithSize:size options:(NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading) attributes:@{NSFontAttributeName:font} context:nil];
		return ceilf(needLabel.size.height);
	}
	return 0.0;
}


@end
