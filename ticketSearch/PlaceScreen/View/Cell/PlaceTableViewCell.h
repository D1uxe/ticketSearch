//
//  PlaceTableViewCell.h
//  ticketSearch
//
//  Created by MacBook Pro on 25.06.2021.
//

#import <UIKit/UIKit.h>
#import "PlaceCellModelFactory.h"

NS_ASSUME_NONNULL_BEGIN

@interface PlaceTableViewCell : UITableViewCell

-(void)configureWith:(CellModel)model;

@end

NS_ASSUME_NONNULL_END
