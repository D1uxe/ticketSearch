//
//  PlaceViewBuilder.h
//  ticketSearch
//
//  Created by MacBook Pro on 21.06.2021.
//

#import <UIKit/UIKit.h>
#import "PlaceViewPresenter.h"
#import "MainViewPresenter.h"

NS_ASSUME_NONNULL_BEGIN

@interface PlaceViewBuilder : NSObject

+(UIViewController<PlaceViewInput>*)buildWith: (PlaceType)placeType withPresenter:(id<MainViewOutput>)mainPresenter;
//+(UIViewController<PlaceViewInput>*)build;
@end

NS_ASSUME_NONNULL_END
