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
		dateF.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"ru_RU"];
//		dateF.locale = [NSLocale currentLocale];
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
		_flightNumber = dictionary [@"flight_number"];
		_price = dictionary [@"price"];
		_returnDate = dateFromString(dictionary [@"return_at"]);
	}
	return self;
}

NSDate *dateFromString(NSString *dateString) {
	if (!dateString) { return  nil; }
//	NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
	NSString *correctStringDate = [dateString stringByReplacingOccurrencesOfString:@"T" withString:@" "];
	correctStringDate = [correctStringDate stringByReplacingOccurrencesOfString:@"+03:00" withString:@" "];
//	dateFormatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
	return [Ticket.dateFormatter dateFromString: correctStringDate];
}

@end
