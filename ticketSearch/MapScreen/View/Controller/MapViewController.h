//
//  MapViewController.h
//  ticketSearch
//
//  Created by MacBook Pro on 01.07.2021.
//

#import <UIKit/UIKit.h>
#import "MapViewPresenter.h"

NS_ASSUME_NONNULL_BEGIN

@interface MapViewController : UIViewController <MapViewInput>

@property(nonatomic, strong) id<MapViewOutput> presenter;

-(instancetype)initWithPresenter:(id<MapViewOutput>) presenter;

@end

NS_ASSUME_NONNULL_END
