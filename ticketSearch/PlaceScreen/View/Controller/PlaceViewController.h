//
//  PlaceViewController.h
//  ticketSearch
//
//  Created by MacBook Pro on 20.06.2021.
//

#import <UIKit/UIKit.h>
#import "PlaceViewPresenter.h"

NS_ASSUME_NONNULL_BEGIN

@interface PlaceViewController : UIViewController <PlaceViewInput>

@property(nonatomic, strong) PlaceViewPresenter *presenter;

-(instancetype)initWithPresenter:(PlaceViewPresenter *) presenter;

@end

NS_ASSUME_NONNULL_END
