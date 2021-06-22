//
//  AppStartManager.m
//  ticketSearch
//
//  Created by MacBook Pro on 20.06.2021.
//

#import "AppStartManager.h"
#import "MainViewController.h"
#import "MainViewBuilder.h"

@interface AppStartManager()

@property (strong, nonatomic) UIWindow * window;
@property (strong, nonatomic) UIScene * windowScene;

@end

@implementation AppStartManager

//MARK: Initialisers

-(instancetype)initWithWindow:(UIWindow*) window withScene:(UIScene*)scene {

	self = [super init];
	if (self) {

		_window = window;
		_windowScene = scene;
	}
	return self;
}


//MARK: Methods

-(void)start {

	UIViewController *rootVC = [MainViewBuilder build];
	UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:rootVC];

	navigationController.navigationBar.prefersLargeTitles = YES;
	navigationController.navigationBar.barTintColor = UIColor.lightGrayColor;
	navigationController.navigationBar.tintColor = UIColor.blackColor;
	//navigationController.navigationBar.largeTitleTextAttributes = @{NSForegroundColorAttributeName: [UIColor cyanColor]};

	self.window.rootViewController = navigationController;

	[self.window makeKeyAndVisible];
	[self.window setWindowScene:(UIWindowScene *)_windowScene];
	
}

@end
