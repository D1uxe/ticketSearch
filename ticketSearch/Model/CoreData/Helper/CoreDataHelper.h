//
//  CoreDataHelper.h
//  ticketSearch
//
//  Created by MacBook Pro on 08.07.2021.
//

#import <CoreData/CoreData.h>
#import "DataManager.h"
#import "FavoriteTicket+CoreDataClass.h"
#import "Ticket.h"

NS_ASSUME_NONNULL_BEGIN

@interface CoreDataHelper : NSObject

- (BOOL)isFavorite:(Ticket *)ticket;
- (NSArray *)favoriteTickets;
- (void)addToFavorite:(Ticket *)ticket;
- (void)removeFromFavorite:(Ticket *)ticket;

+ (instancetype)shared;

@end

NS_ASSUME_NONNULL_END
