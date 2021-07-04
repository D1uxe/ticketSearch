//
//  PlaceViewController.h
//  ticketSearch
//
//  Created by MacBook Pro on 20.06.2021.
//

#import <UIKit/UIKit.h>
#import "PlaceViewPresenter.h"
#import "DataManager.h"
#import "PlaceType.h"

NS_ASSUME_NONNULL_BEGIN

@interface PlaceViewController : UIViewController <PlaceViewInput, UITableViewDataSource, UITableViewDelegate, UISearchResultsUpdating>

@property(nonatomic, strong) id<PlaceViewOutput> presenter;

-(instancetype)initWithPresenter:(id<PlaceViewOutput>)presenter with:(PlaceType)placeType; 

@end

NS_ASSUME_NONNULL_END
