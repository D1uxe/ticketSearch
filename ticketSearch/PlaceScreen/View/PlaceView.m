//
//  PlaceView.m
//  ticketSearch
//
//  Created by MacBook Pro on 20.06.2021.
//

#import "PlaceView.h"

@implementation PlaceView

- (instancetype)init
{
	self = [super init];
	if (self) {

		[self configureUI];
	}
	return self;
}

-(void)configureUI {

	self.backgroundColor = UIColor.whiteColor;
}

@end
