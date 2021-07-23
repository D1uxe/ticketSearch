//
//  DataManager.m
//  ticketSearch
//
//  Created by MacBook Pro on 23.06.2021.
//

#import "DataManager.h"

@interface DataManager ()

@property (nonatomic, strong) NSMutableArray *countriesArray;
@property (nonatomic, strong) NSMutableArray *citiesArray;
@property (nonatomic, strong) NSMutableArray *airportsArray;

@end

@implementation DataManager

//MARK: - Public properties

- (NSArray *)countries
{
	return _countriesArray;
}

- (NSArray *)cities
{
	return _citiesArray;
}

- (NSArray *)airports
{
	return _airportsArray;
}

//MARK: - Initialisers

+(instancetype)shared {
	static DataManager *instance;
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		instance = [[DataManager alloc] init];
	});
	return instance;
}

//MARK: - Public methods

-(void)loadData {
	dispatch_async(dispatch_get_global_queue(QOS_CLASS_UTILITY, 0), ^{

		NSArray *countriesJsonArray = [self getArrayFromFileName:@"countries" ofType:@"json"];
		self->_countriesArray = [self createEntitiesFromArray:countriesJsonArray withType: DataSourceTypeCountry];

		NSArray *citiesJsonArray = [self getArrayFromFileName:@"cities" ofType:@"json"];
		self->_citiesArray = [self createEntitiesFromArray:citiesJsonArray withType: DataSourceTypeCity];

		NSArray *airportsJsonArray = [self getArrayFromFileName:@"airports" ofType:@"json"];
		self->_airportsArray = [self createEntitiesFromArray:airportsJsonArray withType: DataSourceTypeAirport];

		dispatch_async(dispatch_get_main_queue(), ^{
			[[NSNotificationCenter defaultCenter] postNotificationName:kDataManagerLoadDataDidComplete object:nil];
		});
	});
}

- (City *)getCityForIATA:(NSString *)iata {

	if (iata) {
		for (City *city in _citiesArray) {
			if ([city.code isEqual:iata]) {
				return city;
			}
		}
	}
	return nil;
}

- (City *)getCityForLocation:(CLLocation *)location {

	for (City *city in _citiesArray) {
		if (ceilf(city.coordinate.latitude) == ceilf(location.coordinate.latitude) && ceilf(city.coordinate.longitude) == ceilf(location.coordinate.longitude)) {
			return city;
		}
	}
	return nil;
}


//MARK: - Private methods

-(NSArray *)getArrayFromFileName:(NSString *)fileName ofType: (NSString *)type {

	NSString *path = [[NSBundle mainBundle] pathForResource:fileName ofType:type];
	NSData *data = [NSData dataWithContentsOfFile:path];
	return [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
}


-(NSMutableArray *)createEntitiesFromArray:(NSArray *)array withType:(DataSourceType)type {

	NSMutableArray *entities = [NSMutableArray new];

	for (NSDictionary *jsonObject in array) {
		if (type == DataSourceTypeCountry) {
			[entities addObject: [[Country alloc] initWithDictionary:jsonObject]];
		}
		else if (type == DataSourceTypeCity) {
			[entities addObject: [[City alloc] initWithDictionary:jsonObject]];
		}
		else if (type == DataSourceTypeAirport) {
			[entities addObject: [[Airport alloc] initWithDictionary:jsonObject]];
		}
	}
	return entities;
}

@end
