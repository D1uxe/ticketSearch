//
//  TicketCellModelFactory.m
//  ticketSearch
//
//  Created by MacBook Pro on 29.06.2021.
//

#import "TicketCellModelFactory.h"
#import "ImageDownloader.h"


@interface TicketCellModelFactory ()

+(NSDateFormatter *)dateFormatter;

@end


@implementation TicketCellModelFactory

+(NSDateFormatter *) dateFormatter {
	static NSDateFormatter *dateF = nil;
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		dateF = [[NSDateFormatter alloc] init];
		dateF.dateFormat = @"dd MMMM yyyy hh:mm";
	});
	return dateF;
}


+(void)makeCellModelFromTicket:(Ticket *)ticket withCompletion:(void (^)(CellModel model))completion {

	[[ImageDownloader shared] getImageForAirline:ticket.airline withCompletion:^(UIImage * _Nonnull image) {

		CellModel cellModel = (CellModel){
			.price = [NSString stringWithFormat:@"%@ руб.", ticket.price],
			.places = [NSString stringWithFormat:@"%@ - %@", ticket.from, ticket.to],
			.date = [TicketCellModelFactory.dateFormatter stringFromDate:ticket.departure],
			.airlineLogo = image
		};
		completion(cellModel);
	}];
}

@end
