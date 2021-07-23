//
//  PlaceViewController.m
//  ticketSearch
//
//  Created by MacBook Pro on 20.06.2021.
//

#import "PlaceViewController.h"
#import "PlaceView.h"
#import "PlaceTableViewCell.h"
#import "NSString+Localize.h"

#define ReuseIdentifier @"CellIdentifier"

@interface PlaceViewController ()

@property(nonatomic) PlaceType placeType;
@property (nonatomic, strong) PlaceView *placeView;


@property (nonatomic) BOOL isFiltering;
@property (nonatomic, strong) NSArray *filteredSourceArray;

@end

@implementation PlaceViewController

//MARK: - Private properties


- (BOOL)isFiltering {

	return (_placeView.searchController.isActive && _filteredSourceArray.count > 0);
}

//MARK: - Public properties

-(NSString*)title {

	if (_placeType == PlaceTypeDeparture) {
		return [@"main_from" localize];
	} else {
		return [@"main_to" localize];
	}
}

//MARK: - Initialisers

- (instancetype)initWithPresenter:(id<PlaceViewOutput>)presenter with:(PlaceType)placeType {

	self = [super init];
	if (self) {
		_presenter = presenter;
		_placeType = placeType;
	}
	return self;
}

//MARK: - Life cycle

- (void)viewDidLoad {
	[super viewDidLoad];
	
	_placeView = (PlaceView *) self.view;

	_placeView.tableView.dataSource = self;
	_placeView.tableView.delegate = self;

	self.navigationItem.titleView = _placeView.segmentedControl;
	[_placeView.segmentedControl addTarget:self action:@selector(changeSource) forControlEvents:UIControlEventValueChanged];

	if (@available(iOS 11.0, *)) {
		self.navigationItem.searchController = _placeView.searchController;
		//self.navigationItem.hidesSearchBarWhenScrolling = NO;
	} else {
		_placeView.tableView.tableHeaderView = _placeView.searchController.searchBar;
	}

	_placeView.searchController.searchResultsUpdater = self;

	[self changeSource];
}

- (void)loadView {
	self.view = [PlaceView new];
}

//MARK: - Private methods

- (void)changeSource {

	[_presenter viewDidSelectSourceWith:_placeView.segmentedControl.selectedSegmentIndex];
}



//MARK: - UITableViewDataSource

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

	if (self.isFiltering) {
		return _filteredSourceArray.count;
	}
	return currentSourceArray.count;
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {

	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ReuseIdentifier];
	if (!cell) {
		cell = [[PlaceTableViewCell alloc] initWithStyle: UITableViewCellStyleSubtitle reuseIdentifier:ReuseIdentifier];
		cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
	}

	if (_placeView.segmentedControl.selectedSegmentIndex == 0) {
		City *city = self.isFiltering ? [_filteredSourceArray objectAtIndex:indexPath.row] : [currentSourceArray objectAtIndex:indexPath.row];

		[((PlaceTableViewCell*)cell) configureWith:[PlaceCellModelFactory makeCellModelFromCity:city]];

	}
	else if (_placeView.segmentedControl.selectedSegmentIndex == 1) {
		Airport *airport = self.isFiltering ? [_filteredSourceArray objectAtIndex:indexPath.row] : [currentSourceArray objectAtIndex:indexPath.row];

		[((PlaceTableViewCell*)cell) configureWith:[PlaceCellModelFactory makeCellModelFromAirport:airport]];
	}
	return cell;
}



//MARK: - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

	if (self.isFiltering) {
		[_presenter viewDidSelectPlace:[_filteredSourceArray objectAtIndex:indexPath.row] withType:_placeType];
		_placeView.searchController.active = NO;
	} else {
		[_presenter viewDidSelectPlace:[currentSourceArray objectAtIndex:indexPath.row] withType:_placeType];
	}
}



//MARK: - UISearchResultsUpdating

- (void)updateSearchResultsForSearchController:(UISearchController *)searchController {

	if (searchController.searchBar.text) {
		NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF.name CONTAINS[cd] %@", _placeView.searchController.searchBar.text];
		_filteredSourceArray = [currentSourceArray filteredArrayUsingPredicate: predicate];
		[_placeView.tableView reloadData];
	}
}



//MARK: - PlaceViewInput protocol

@synthesize currentSourceArray;


- (void)reloadTable {

	[_placeView.tableView reloadData];
}


@end








