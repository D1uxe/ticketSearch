//
//  AppStartManager.m
//  ticketSearch
//
//  Created by MacBook Pro on 20.06.2021.
//

#import "AppStartManager.h"
#import "MainViewController.h"
#import "MainViewBuilder.h"
#import "MapViewBuilder.h"
#import "TicketViewBuilder.h"
#import "NSString+Localize.h"

@interface AppStartManager()

@property (strong, nonatomic) UIWindow * window;
@property (strong, nonatomic) UIScene * windowScene;
@property (strong, nonatomic) UITabBarController * tabBarController;

@end

@implementation AppStartManager

//MARK: Initialisers

-(instancetype)initWithWindow:(UIWindow*) window withScene:(UIScene*)scene {

	self = [super init];
	if (self) {

		_window = window;
		_windowScene = scene;
		_tabBarController = [UITabBarController new];
	}
	return self;
}


//MARK: Methods

-(void)start {

	// 1-я вкладка TabBar
	UIViewController *rootVC = [MainViewBuilder build];
	UINavigationController *mainNavigationController = makeNavigationControllerForRoot(rootVC);

	mainNavigationController.tabBarItem = [[UITabBarItem alloc] initWithTitle:[@"search_tab" localize] image:[UIImage systemImageNamed:@"magnifyingglass"] tag:0];

	// 2-я вкладка TabBar
	UIViewController *mapVC = [MapViewBuilder build];
	mapVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:[@"map_tab" localize] image:[UIImage systemImageNamed:@"map"] tag:1];

	// 3-я вкладка TabBar
	UIViewController *favoriteVC = [TicketViewBuilder buildWithFavoriteController];
	UINavigationController *favoriteNavigationController = makeNavigationControllerForRoot(favoriteVC);
	favoriteNavigationController.tabBarItem = [[UITabBarItem alloc]  initWithTitle:[@"favorites_tab" localize] image:[UIImage systemImageNamed:@"star"] tag:2];

	_tabBarController.viewControllers = @[mainNavigationController, mapVC, favoriteNavigationController];

	self.window.rootViewController = _tabBarController;
	[self.window makeKeyAndVisible];
	[self.window setWindowScene:(UIWindowScene *)_windowScene];

}

UINavigationController *makeNavigationControllerForRoot(UIViewController *viewController) {

	UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:viewController];

	navigationController.navigationBar.prefersLargeTitles = YES;
	navigationController.navigationBar.tintColor = UIColor.blackColor;
	navigationController.navigationBar.barTintColor = UIColor.lightGrayColor;
//	navigationController.navigationBar.translucent = NO;
	//navigationController.navigationBar.largeTitleTextAttributes = @{NSForegroundColorAttributeName: [UIColor cyanColor]};

	return navigationController;
}

@end
