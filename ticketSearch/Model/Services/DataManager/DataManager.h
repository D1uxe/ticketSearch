//
//  DataManager.h
//  ticketSearch
//
//  Created by MacBook Pro on 23.06.2021.
//

#import <Foundation/Foundation.h>
#import "DataSourceType.h"
#import "Country.h"
#import "City.h"
#import "Airport.h"

#define kDataManagerLoadDataDidComplete @"DataManagerLoadDataDidComplete"

NS_ASSUME_NONNULL_BEGIN

@interface DataManager : NSObject

@property (nonatomic, strong, readonly) NSArray *countries;
@property (nonatomic, strong, readonly) NSArray *cities;
@property (nonatomic, strong, readonly) NSArray *airports;

+ (instancetype)shared;

- (void)loadData;
- (City *)getCityForIATA:(NSString *)iata;
- (City *)getCityForLocation:(CLLocation *)location;

@end

NS_ASSUME_NONNULL_END
