//
//  MainViewPresenter.h
//  ticketSearch
//
//  Created by MacBook Pro on 21.06.2021.
//

#import <UIKit/UIKit.h>


// Протокол связи Presenter-to-View
@protocol MainViewInput <NSObject>

@end

// Протокол связи View-to-Presenter
@protocol MainViewOutput <NSObject>

-(void)viewDidTapButton;

@end

NS_ASSUME_NONNULL_BEGIN

@interface MainViewPresenter : NSObject <MainViewOutput>

@property(nonatomic, weak) UIViewController<MainViewInput> *viewInput;

@end

NS_ASSUME_NONNULL_END
