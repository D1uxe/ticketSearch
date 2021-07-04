//
//  MapPrice.m
//  ticketSearch
//
//  Created by MacBook Pro on 01.07.2021.
//

#import "MapPrice.h"
#import "DataManager.h"

@interface MapPrice ()

+(NSDateFormatter *)dateFormatter;

@end

@implementation MapPrice

+(NSDateFormatter *) dateFormatter {
	static NSDateFormatter *dateF = nil;
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		dateF = [[NSDateFormatter alloc] init];
		dateF.dateFormat = @"yyyy-MM-dd";
	});
	return dateF;
}

//MARK: - Initialisers

- (instancetype)initWithDictionary:(NSDictionary *)dictionary withOrigin: (City *)origin {

	self = [super init];
	if (self)
	{
		_destination = [[DataManager shared] getCityForIATA: [dictionary valueForKey:@"destination"]];
		_origin = origin;
		_departure = [self dateFromString:[dictionary valueForKey:@"depart_date"]];
		_returnDate = [self dateFromString:[dictionary valueForKey:@"return_date"]];
		_numberOfChanges = [[dictionary valueForKey:@"number_of_changes"] integerValue];
		_value = [[dictionary valueForKey:@"value"] integerValue];
		_distance = [[dictionary valueForKey:@"distance"] integerValue];
		_actual = [[dictionary valueForKey:@"actual"] boolValue];
	}
	return self;
}

- (NSDate * _Nullable)dateFromString:(NSString *)dateString {
	
	if (!dateString) { return  nil; }
	return [MapPrice.dateFormatter dateFromString: dateString];
}


@end
