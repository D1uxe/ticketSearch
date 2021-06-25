//
//  PlaceView.h
//  ticketSearch
//
//  Created by MacBook Pro on 20.06.2021.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PlaceView : UIView

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UISegmentedControl *segmentedControl;

- (instancetype)init;
@end

NS_ASSUME_NONNULL_END
