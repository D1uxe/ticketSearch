//
//  PlaceViewController.m
//  ticketSearch
//
//  Created by MacBook Pro on 20.06.2021.
//

#import "PlaceViewController.h"
#import "PlaceView.h"
#import "PlaceTableViewCell.h"

#define ReuseIdentifier @"CellIdentifier"

@interface PlaceViewController ()

@property(nonatomic) PlaceType placeType;
@property (nonatomic, strong) PlaceView *placeView;

@end

@implementation PlaceViewController


-(NSString*)title {

	if (_placeType == PlaceTypeDeparture) {
		return @"Откуда";
	} else {
		return @"Куда";
	}
}

//MARK: - Initialisers

- (instancetype)initWithPresenter:(id<PlaceViewOutput>)presenter with:(PlaceType)placeType
{
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

	return [currentSourceArray count];
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {

	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ReuseIdentifier];
	if (!cell) {
		cell = [[PlaceTableViewCell alloc] initWithStyle: UITableViewCellStyleSubtitle reuseIdentifier:ReuseIdentifier];
		cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
	}

	if (_placeView.segmentedControl.selectedSegmentIndex == 0) {
		City *city = [currentSourceArray objectAtIndex:indexPath.row];

		[((PlaceTableViewCell*)cell) configureWith:[CellModelFactory makeCellModelFromCity:city]];

	}
	else if (_placeView.segmentedControl.selectedSegmentIndex == 1) {
		Airport *airport = [currentSourceArray objectAtIndex:indexPath.row];

		[((PlaceTableViewCell*)cell) configureWith:[CellModelFactory makeCellModelFromAirport:airport]];

	}


	return cell;
}



//MARK: - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

	[_presenter viewDidSelectPlace:[currentSourceArray objectAtIndex:indexPath.row] withType:_placeType];
}



//MARK: - PlaceViewInput protocol

@synthesize currentSourceArray;


- (void)reloadTable {

	[_placeView.tableView reloadData];
}


@end








