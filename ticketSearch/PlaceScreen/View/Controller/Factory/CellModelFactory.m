//
//  CellModelFactory.m
//  ticketSearch
//
//  Created by MacBook Pro on 25.06.2021.
//

#import "CellModelFactory.h"

@implementation CellModelFactory

+(CellModel)makeCellModelFromCity:(City *)city {

	return (CellModel){.title = city.name, .code = city.code};
}

+(CellModel)makeCellModelFromAirport:(Airport *)airPort {

	return (CellModel){.title = airPort.name, .code = airPort.code};
}

@end
