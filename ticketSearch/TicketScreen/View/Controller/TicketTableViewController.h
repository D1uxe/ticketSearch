//
//  TicketTableViewController.h
//  ticketSearch
//
//  Created by MacBook Pro on 28.06.2021.
//

#import <UIKit/UIKit.h>
#import "TicketViewPresenter.h"

NS_ASSUME_NONNULL_BEGIN

@interface TicketTableViewController : UITableViewController <TicketViewInput>

@property(nonatomic, strong) id<TicketViewOutput> presenter;

-(instancetype)initWithPresenter:(id<TicketViewOutput>) presenter;
- (instancetype)initFavoriteTicketsControllerWithPresenter:(id<TicketViewOutput>)presenter;


@end

NS_ASSUME_NONNULL_END
