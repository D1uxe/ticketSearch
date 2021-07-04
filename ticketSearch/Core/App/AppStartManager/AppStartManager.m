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
//#import "FavoriteViewBuilder"

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
	UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:rootVC];
//	navigationController.tabBarItem = [[UITabBarItem alloc] initWithTabBarSystemItem:UITabBarSystemItemSearch tag:0];
	navigationController.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Поиск" image:[UIImage systemImageNamed:@"magnifyingglass"] tag:0];

	navigationController.navigationBar.prefersLargeTitles = YES;
	navigationController.navigationBar.barTintColor = UIColor.lightGrayColor;
	navigationController.navigationBar.tintColor = UIColor.blackColor;
	//navigationController.navigationBar.largeTitleTextAttributes = @{NSForegroundColorAttributeName: [UIColor cyanColor]};

	// 2-я вкладка TabBar
	UIViewController *mapVC = [MapViewBuilder build];
	mapVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Карта цен" image:[UIImage systemImageNamed:@"map"] tag:1];

	// 3-я вкладка TabBar
//	UIViewController *favoriteVC = [FavoriteViewBuilder build];
//	favoriteVC.tabBarItem = [[UITabBarItem alloc]  initWithTitle:favoriteVC.title image:[UIImage systemImageNamed:@"star"] tag:2];

	_tabBarController.viewControllers = @[navigationController,mapVC, /* favoriteVC*/];

	self.window.rootViewController = _tabBarController;

	[self.window makeKeyAndVisible];
	[self.window setWindowScene:(UIWindowScene *)_windowScene];

}

@end
