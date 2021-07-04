//
//  APIManager.h
//  ticketSearch
//
//  Created by MacBook Pro on 27.06.2021.
//

#import <Foundation/Foundation.h>
#import "City.h"
#import "Ticket.h"
#import "MapPrice.h"
#import "SearchRequest.h"

NS_ASSUME_NONNULL_BEGIN

@interface APIManager : NSObject

+ (instancetype)shared;

- (void)getCityForCurrentIP:(void (^)(City *city))completion;
- (void)getTicketsWithRequest:(SearchRequest)request withCompletion:(void (^)(NSArray *tickets))completion;
- (void)getMapPriceWithFor:(City *)origin withCompletion:(void (^)(NSArray * prices))completion;

@end

NS_ASSUME_NONNULL_END
