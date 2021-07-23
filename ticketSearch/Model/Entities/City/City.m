//
//  City.m
//  ticketSearch
//
//  Created by MacBook Pro on 23.06.2021.
//

#import "City.h"

@implementation City

//MARK: - Initialisers

- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
	self = [super init];
	if (self) {
		_timezone = [dictionary valueForKey:@"time_zone"];
		_translations = [dictionary valueForKey:@"name_translations"];
		_name = [dictionary valueForKey:@"name"];
		_countryCode = [dictionary valueForKey:@"country_code"];
		_code = [dictionary valueForKey:@"code"];

		NSDictionary *coords = [dictionary valueForKey:@"coordinates"];
		if (coords && ![coords isEqual:[NSNull null]]) {
			NSNumber *longitude = [coords valueForKey:@"lon"];
			NSNumber *latitude = [coords valueForKey:@"lat"];
			if (![longitude isEqual:[NSNull null]] && ![latitude isEqual:[NSNull null]]) {
				_coordinate = CLLocationCoordinate2DMake([latitude doubleValue], [longitude doubleValue]);
			}
		}

	}
	return self;
}
@end
