//
//  TicketCellModelFactory.h
//  ticketSearch
//
//  Created by MacBook Pro on 29.06.2021.
//


#import <UIKit/UIKit.h>
#import "Ticket.h"


typedef struct CellModel {
	__unsafe_unretained NSString * _Nonnull price;
	__unsafe_unretained NSString * _Nonnull places;
	__unsafe_unretained NSString * _Nonnull date;
	__unsafe_unretained UIImage * _Nullable airlineLogo;
	__unsafe_unretained NSString * _Nonnull airline;
	BOOL isFavorite;

} CellModel;

NS_ASSUME_NONNULL_BEGIN

@interface TicketCellModelFactory : NSObject


+(void)makeCellModelFromTicket:(Ticket *)ticket withCompletion:(void (^)(CellModel model))completion;


@end

NS_ASSUME_NONNULL_END
