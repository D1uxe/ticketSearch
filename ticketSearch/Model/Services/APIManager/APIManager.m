//
//  APIManager.m
//  ticketSearch
//
//  Created by MacBook Pro on 27.06.2021.
//

#import "APIManager.h"
#import "DataManager.h"
#import "Ticket.h"

#define API_TOKEN @"9cfb220fbf225dc196d63ea213925fc8"
#define API_URL_FOR_IP_ADDRESS @"https://api.ipify.org/?format=json"
#define API_URL_FOR_CHEAP @"https://api.travelpayouts.com/v1/prices/cheap"
#define API_URL_FOR_CITY_FROM_IP @"https://www.travelpayouts.com/whereami?ip="
#define API_URL_FOR_MAP_PRICE @"https://map.aviasales.ru/prices.json?origin_iata="

@implementation APIManager

//MARK: - Initialisers

+ (instancetype)shared {
	static APIManager *instance;
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		instance = [[APIManager alloc] init];
	});
	return instance;
}

//MARK: - Private methods

-(void)executeRequestForURL:(NSString *)urlString withCompletion:(void (^)(id result))completion {

	NSURL *URL = [NSURL URLWithString:urlString];
	[[NSURLSession.sharedSession dataTaskWithURL:URL
							   completionHandler:^(NSData * _Nullable data,
												   NSURLResponse * _Nullable response,
												   NSError * _Nullable error) {

		if (data) {
			completion([NSJSONSerialization JSONObjectWithData:data
													   options:NSJSONReadingMutableContainers
														 error:nil]);
		}

		if (error) {
			NSLog(@"Error while executing request with url %@. Reason: %@", urlString, error.localizedDescription);
		}
	}] resume];
}

-(void)getIPAddressWithCompletion:(void (^)(NSString *ipAddress))completion {

	[self executeRequestForURL:API_URL_FOR_IP_ADDRESS withCompletion:^(id result) {
		NSDictionary *json = result;
		completion(json[@"ip"]);
	}];
}


//MARK: - Public methods

- (void)getCityForCurrentIP:(void (^)(City *city))completion {

	[self getIPAddressWithCompletion:^(NSString *ipAddress) {

		NSString *fullUrl = [NSString stringWithFormat:@"%@%@",API_URL_FOR_CITY_FROM_IP, ipAddress];

		[self executeRequestForURL:fullUrl withCompletion:^(id result) {

			NSDictionary *json = result;
			NSString *iata = json[@"iata"];

			if (iata) {
				City *city = [DataManager.shared getCityForIATA:iata];
				if (city) {
					dispatch_async(dispatch_get_main_queue(), ^{
						completion(city);
					});
				}
			}
		}];

	}];
}

- (void)getTicketsWithRequest:(SearchRequest)request withCompletion:(void (^)(NSArray * _Nonnull))completion {

	NSURLComponents *urlConstructor = [[NSURLComponents alloc] initWithString:API_URL_FOR_CHEAP];
	urlConstructor.queryItems = @[
		[[NSURLQueryItem alloc] initWithName:@"origin" value:request.origin],
		[[NSURLQueryItem alloc] initWithName:@"destination" value:request.destination],
		[[NSURLQueryItem alloc] initWithName:@"token" value:API_TOKEN]
	];

	if (request.departDate && request.returnDate) {
		NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
		dateFormatter.dateFormat = @"yyyy-MM";
		urlConstructor.queryItems = @[
			[[NSURLQueryItem alloc] initWithName:@"depart_date" value:[dateFormatter stringFromDate:request.departDate]],
			[[NSURLQueryItem alloc] initWithName:@"return_date" value:[dateFormatter stringFromDate:request.returnDate]]
		];
	}
	NSLog(@"%@", urlConstructor.URL.absoluteString);
	NSString *url = @"https://api.travelpayouts.com/v1/prices/cheap?origin=LED&destination=DME&token=9cfb220fbf225dc196d63ea213925fc8";
	[self executeRequestForURL:url/*urlConstructor.URL.absoluteString*/ withCompletion:^(id _Nullable result) {

		NSDictionary *response = result;
		if (response) {
			NSDictionary *json = [[response valueForKey:@"data"] valueForKey:@"MOW"];//request.destination];
			NSMutableArray *array = [NSMutableArray new];
			for (NSString *key in json) {
				NSDictionary *value = [json valueForKey: key];
				Ticket *ticket = [[Ticket alloc] initWithDictionary:value];
				ticket.from = request.origin;
				ticket.to = request.destination;
				[array addObject:ticket];
			}
			dispatch_async(dispatch_get_main_queue(), ^{
				completion(array);
			});
		}
	}];
}

@end
