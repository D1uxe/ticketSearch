//
//  Ticket.m
//  ticketSearch
//
//  Created by MacBook Pro on 29.06.2021.
//

#import "Ticket.h"

@interface Ticket ()

+(NSDateFormatter *)dateFormatter;

@end

@implementation Ticket

+(NSDateFormatter *) dateFormatter {
	static NSDateFormatter *dateF = nil;
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		dateF = [[NSDateFormatter alloc] init];
		dateF.dateFormat = @"yyyy-MM-dd HH:mm:ss";
	});
	return dateF;
}

//MARK: - Initialisers

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {

	self = [super init];
	if (self) {
		_airline = dictionary[@"airline"];
		_expires = dateFromString(dictionary[@"expires_at"]);
		_departure = dateFromString(dictionary[@"departure_at"]);
		_flightNumber = [dictionary[@"flight_number"] integerValue];
		_price = [dictionary[@"price"] integerValue];
		_returnDate = dateFromString(dictionary [@"return_at"]);

		_isFavorite = NO;
	}
	return self;
}

NSDate *dateFromString(NSString *dateString) {
	if (!dateString) { return  nil; }
	NSString *correctStringDate = [dateString stringByReplacingOccurrencesOfString:@"[TZ]"
																		withString:@" "
																		   options:NSRegularExpressionSearch
																			 range:NSMakeRange(0, [dateString length])];

	correctStringDate = [correctStringDate stringByReplacingOccurrencesOfString:@"\\+\\d+:\\d+"
																	 withString:@""
																		options:NSRegularExpressionSearch
																		  range:NSMakeRange(0, [correctStringDate length])];
	return [Ticket.dateFormatter dateFromString: correctStringDate];
}

@end
