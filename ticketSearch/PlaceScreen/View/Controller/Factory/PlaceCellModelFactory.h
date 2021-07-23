//
//  CellModelFactory.h
//  ticketSearch
//
//  Created by MacBook Pro on 25.06.2021.
//

#import <Foundation/Foundation.h>
#import "City.h"
#import "Airport.h"

typedef struct CellModel {
	__unsafe_unretained NSString * _Nonnull title;
	__unsafe_unretained NSString * _Nonnull code;

} CellModel;

NS_ASSUME_NONNULL_BEGIN

@interface PlaceCellModelFactory : NSObject

+(CellModel)makeCellModelFromCity:(City *)city;
+(CellModel)makeCellModelFromAirport:(Airport *)airPort;

@end

NS_ASSUME_NONNULL_END
