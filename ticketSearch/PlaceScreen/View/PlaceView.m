//
//  PlaceView.m
//  ticketSearch
//
//  Created by MacBook Pro on 20.06.2021.
//

#import "PlaceView.h"

@implementation PlaceView

- (instancetype)init {

	self = [super init];
	if (self) {

		[self configureUI];
	}
	return self;
}

-(void)configureUI {

	self.backgroundColor = UIColor.whiteColor;
	[self addTable];
	[self configureSegmentedControl];
	[self configureSearchController];
}

-(void)addTable {

	_tableView = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStylePlain];

	[self addSubview:_tableView];
}

-(void)configureSegmentedControl {

	_segmentedControl = [[UISegmentedControl alloc] initWithItems:@[@"Города", @"Аэропорты"]];
	//_segmentedControl.backgroundColor = UIColor.blackColor;
	_segmentedControl.selectedSegmentIndex = 0;
}

-(void)configureSearchController {

	_searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
	_searchController.obscuresBackgroundDuringPresentation = NO;
	_searchController.searchBar.placeholder = @"Поиск";
//	_searchController.definesPresentationContext = YES;

}
@end
