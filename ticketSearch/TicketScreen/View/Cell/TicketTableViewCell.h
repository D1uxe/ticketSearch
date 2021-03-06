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

@property (nonatomic, strong) UIButton *favoriteButton;
@property (nonatomic, readonly) CellModel cellModel;
@property (nonatomic, strong, readonly) NSString *price;

-(void)configureWith:(CellModel)model;

@end

NS_ASSUME_NONNULL_END
