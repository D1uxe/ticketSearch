//
//  PageView.m
//  ticketSearch
//
//  Created by MacBook Pro on 12.07.2021.
//

#import "PageView.h"


DEPRECATED_MSG_ATTRIBUTE("The class is no longer needed")
@implementation PageView

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

	[self addNextButton];
	[self addPageControl];

}

-(void)addNextButton {

	_nextButton = [UIButton buttonWithType:UIButtonTypeSystem];
	_nextButton.frame = CGRectMake(UIScreen.mainScreen.bounds.size.width - 100.0,
								   UIScreen.mainScreen.bounds.size.height - 50.0,
								   100.0,
								   50.0);
	[_nextButton setTintColor:[UIColor blackColor]];

	[self addSubview:_nextButton];
}

-(void)addPageControl {

	_pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0,
																   UIScreen.mainScreen.bounds.size.height - 50.0,
																   UIScreen.mainScreen.bounds.size.width,
																   50.0)];
		_pageControl.numberOfPages = CONTENT_COUNT;
		_pageControl.currentPage = 0;
		_pageControl.pageIndicatorTintColor = [UIColor darkGrayColor];
		_pageControl.currentPageIndicatorTintColor = [UIColor blackColor];

		[self addSubview:_pageControl];
}

@end
