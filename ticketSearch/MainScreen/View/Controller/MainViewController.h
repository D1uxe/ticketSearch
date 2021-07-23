//
//  MainViewController.h
//  ticketSearch
//
//  Created by MacBook Pro on 20.06.2021.
//

#import <UIKit/UIKit.h>
#import "MainViewPresenter.h"

NS_ASSUME_NONNULL_BEGIN

@interface MainViewController : UIViewController <MainViewInput>

@property(nonatomic, strong) id<MainViewOutput> presenter;

-(instancetype)initWithPresenter:(id<MainViewOutput>) presenter;

@end

NS_ASSUME_NONNULL_END
