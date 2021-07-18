//
//  MainView.h
//  ticketSearch
//
//  Created by MacBook Pro on 20.06.2021.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MainView : UIView

@property (nonatomic, strong) UIButton *departureButton;
@property (nonatomic, strong) UIButton *arrivalButton;

- (instancetype)init;

@end

NS_ASSUME_NONNULL_END
