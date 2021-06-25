//
//  PlaceTableViewCell.m
//  ticketSearch
//
//  Created by MacBook Pro on 25.06.2021.
//

#import "PlaceTableViewCell.h"

@implementation PlaceTableViewCell



//MARK: - Public methods

-(void)configureWith:(CellModel)model {

	self.textLabel.text = model.title;
	self.detailTextLabel.text =model.code;
}

@end
