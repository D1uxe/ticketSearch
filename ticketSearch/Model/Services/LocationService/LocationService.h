//
//  LocationService.h
//  ticketSearch
//
//  Created by MacBook Pro on 01.07.2021.
//

#import <CoreLocation/CoreLocation.h>

#define kLocationServiceDidUpdateCurrentLocation @"LocationServiceDidUpdateCurrentLocation"

NS_ASSUME_NONNULL_BEGIN

@interface LocationService : NSObject <CLLocationManagerDelegate>
@end

NS_ASSUME_NONNULL_END
