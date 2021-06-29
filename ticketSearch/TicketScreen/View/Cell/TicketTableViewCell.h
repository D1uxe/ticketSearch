//
//  TicketTableViewCell.h
//  ticketSearch
//
//  Created by MacBook Pro on 28.06.2021.
//

#import <UIKit/UIKit.h>
#import "TicketCellModelFactory.h"

NS_ASSUME_NONNULL_BEGIN

@interface TicketTableViewCell : UITableViewCell

-(void)configureWith:(CellModel)model;

@end

NS_ASSUME_NONNULL_END
