//
//  MainViewPresenter.h
//  ticketSearch
//
//  Created by MacBook Pro on 21.06.2021.
//

#import <UIKit/UIKit.h>
#import "PlaceViewController.h"



// Протокол связи Presenter-to-View
@protocol MainViewInput <NSObject>

-(void)setTitleForButton:(NSString *_Nonnull)placeTitle withPlaceType:(PlaceType)placeType;
-(void)showActivityIndicator:(BOOL)show;
-(void)showAlert;

@end

// Протокол связи View-to-Presenter
@protocol MainViewOutput <NSObject>

-(void)viewDidTapButtonWithType:(PlaceType)placeType;
-(void)viewDidTapSearchButton;
-(void)viewRequestData;
-(void)setPlace:(id _Nonnull )place withType:(PlaceType)placeType;
-(void)presentOnBoardScreenIfNeeded;

@end

NS_ASSUME_NONNULL_BEGIN

@interface MainViewPresenter : NSObject <MainViewOutput>

@property(nonatomic, weak) UIViewController<MainViewInput> *viewInput;

@end

NS_ASSUME_NONNULL_END
