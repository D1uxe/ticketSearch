//
//  TicketCellModelFactory.m
//  ticketSearch
//
//  Created by MacBook Pro on 29.06.2021.
//

#import "TicketCellModelFactory.h"
#import "ImageDownloader.h"
#import "NSString+Localize.h"

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
		//dateF.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"ru"];
		//dateF.locale = [NSLocale currentLocale];
	});
	return dateF;
}


+(void)makeCellModelFromTicket:(Ticket *)ticket withCompletion:(void (^)(CellModel model))completion {

	[[ImageDownloader shared] getImageForAirline:ticket.airline withCompletion:^(UIImage * _Nonnull image) {

		CellModel cellModel = (CellModel){
			.price = [NSString stringWithFormat:@"%ld %@", (long)ticket.price, [@"currency" localize]],
			.places = [NSString stringWithFormat:@"%@ - %@", ticket.from, ticket.to],
			.date = [TicketCellModelFactory.dateFormatter stringFromDate:ticket.departure],
			.airlineLogo = image,
			.airline = ticket.airline,
			.isFavorite = ticket.isFavorite
		};
		completion(cellModel);
	}];
}

@end
