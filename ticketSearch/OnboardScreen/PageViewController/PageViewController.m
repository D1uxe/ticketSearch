//
//  PageViewController.m
//  ticketSearch
//
//  Created by MacBook Pro on 12.07.2021.
//

#import "PageViewController.h"
#import "NSString+Localize.h"

@interface PageViewController ()

@property (nonatomic, strong) UIButton *nextButton;
@property (nonatomic, strong) UIPageControl *pageControl;

@end

@implementation PageViewController {
	
	struct firstContentData {
		__unsafe_unretained NSString *title;
		__unsafe_unretained NSString *contentText;
		__unsafe_unretained NSString *imageName;
	} contentData[CONTENT_COUNT];
}



//MARK: - Lifecycle

- (void)viewDidLoad {
	[super viewDidLoad];
	
	self.view.backgroundColor = [UIColor whiteColor];


	self.dataSource = self;
	self.delegate = self;

	[self createContentDataArray];

	ContentViewController *startViewController = [self getViewControllerAtIndex:0];
	[self setViewControllers:@[startViewController]
				   direction:UIPageViewControllerNavigationDirectionForward
					animated:NO
				  completion:nil];
	[self addPageControl];
	[self addNextButton];
	[_nextButton addTarget:self action:@selector(nextButtonDidTap:) forControlEvents:UIControlEventTouchUpInside];
	[self updateButtonWithIndex:0];
}


//MARK: - Private methods

-(void)addNextButton {

	_nextButton = [UIButton buttonWithType:UIButtonTypeSystem];
	_nextButton.frame = CGRectMake(UIScreen.mainScreen.bounds.size.width - 100.0,
								   UIScreen.mainScreen.bounds.size.height - 120.0,
								   100.0,
								   50.0);
	[_nextButton setTintColor:UIColor.blackColor];

	[self.view addSubview:_nextButton];
}

-(void)addPageControl {

	_pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0,
																   UIScreen.mainScreen.bounds.size.height - 120.0,
																   UIScreen.mainScreen.bounds.size.width,
																   50.0)];
	_pageControl.numberOfPages = CONTENT_COUNT;
	_pageControl.currentPage = 0;
	_pageControl.pageIndicatorTintColor = UIColor.darkGrayColor;
	_pageControl.currentPageIndicatorTintColor = UIColor.blackColor;

	[self.view addSubview:_pageControl];
}


- (void)nextButtonDidTap:(UIButton *)sender {

	int index = ((ContentViewController *)[self.viewControllers firstObject]).index;
	
	if (sender.tag) { // если нажали на кнопку готово
		[[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"first_start"];
		[self dismissViewControllerAnimated:YES completion:nil];
	} else {
		__weak typeof(self) weakSelf = self;
		[self setViewControllers:@[[self getViewControllerAtIndex:index+1]]
					   direction:UIPageViewControllerNavigationDirectionForward
						animated:YES
					  completion:^(BOOL finished) {
			weakSelf.pageControl.currentPage = index+1;
			[weakSelf updateButtonWithIndex:index+1];
		}];
	}
}

- (void)updateButtonWithIndex:(int)index {
	switch (index) {
		case 0:
		case 1:
		case 2:
			[_nextButton setTitle:[@"next_button" localize] forState:UIControlStateNormal];
			_nextButton.tag = 0;
			break;
		case 3:;
			[_nextButton setTitle:[@"done_button" localize] forState:UIControlStateNormal];
			_nextButton.tag = 1;
			break;
		default:
			break;
	}
}

- (void)createContentDataArray {

	NSArray *titles = [NSArray arrayWithObjects:[@"about_app_header" localize],
					   [@"tickets_header" localize],
					   [@"map_price_header" localize],
					   [@"favorites_header" localize], nil];

	NSArray *contents = [NSArray arrayWithObjects:[@"about_app_describe" localize],
						 [@"tickets_describe" localize],
						 [@"map_price_describe" localize],
						 [@"favorites_describe" localize], nil];

	for (int i = 0; i < 4; ++i) {
		contentData[i].title = [titles objectAtIndex:i];
		contentData[i].contentText = [contents objectAtIndex:i];
		contentData[i].imageName = [NSString stringWithFormat:@"img_%d", i+1];
	}
}


- (ContentViewController *)getViewControllerAtIndex:(int)index {

	if (index < 0 || index >= CONTENT_COUNT) {
		return nil;
	}
	ContentViewController *contentViewController = [[ContentViewController alloc] init];
	contentViewController.title = contentData[index].title;
	contentViewController.contentText = contentData[index].contentText;
	contentViewController.image =  [UIImage imageNamed: contentData[index].imageName];
	contentViewController.index = index;
	return contentViewController;
}



//MARK: - PageViewControllerDataSource

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {

	int index = ((ContentViewController *)viewController).index;
	index--;
	return [self getViewControllerAtIndex:index];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {

	int index = ((ContentViewController *)viewController).index;
	index++;
	return [self getViewControllerAtIndex:index];
}



//MARK: - PageViewControllerDelegate

- (void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray<UIViewController *> *)previousViewControllers transitionCompleted:(BOOL)completed
{
	if (completed) {
		int index = ((ContentViewController *)[pageViewController.viewControllers firstObject]).index;
		_pageControl.currentPage = index;
		[self updateButtonWithIndex:index];
	}
}


@end
