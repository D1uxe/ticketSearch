//
//  Country.m
//  ticketSearch
//
//  Created by MacBook Pro on 23.06.2021.
//

#import "Country.h"

@implementation Country

//MARK: - Initialisers

- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
	self = [super init];
	if (self) {
		_currency = dictionary[@"currency"];
		_translations = dictionary[@"name_translations"];
		_name = dictionary[@"name"];
		_code = dictionary[@"code"];
	}
	return self;
}


@end
