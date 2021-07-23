//
//  TicketViewBuilder.h
//  ticketSearch
//
//  Created by MacBook Pro on 28.06.2021.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TicketViewBuilder : NSObject

+(UIViewController *)buildWithTickets:(NSArray *)tickets;

@end

NS_ASSUME_NONNULL_END
