//
//  TicketTableViewController.m
//  ticketSearch
//
//  Created by MacBook Pro on 28.06.2021.
//

#import "TicketTableViewController.h"
#import "TicketViewPresenter.h"
#import "TicketTableViewCell.h"

#define TicketCellReuseIdentifier @"TicketCellIdentifier"

@interface TicketTableViewController ()

@end

@implementation TicketTableViewController

//MARK: - Initialisers

- (instancetype)initWithPresenter:(id<TicketViewOutput>)presenter
{
	self = [super init];
	if (self) {
		_presenter = presenter;
	}
	return self;
}


- (void)viewDidLoad {
	[super viewDidLoad];

	self.title = @"Билеты";
	self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
	[self.tableView registerClass:[TicketTableViewCell class] forCellReuseIdentifier:TicketCellReuseIdentifier];

	[_presenter viewRequestTickets];
}




#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

	return tickets.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

	TicketTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:TicketCellReuseIdentifier forIndexPath:indexPath];

	Ticket *ticket = [tickets objectAtIndex:indexPath.row];

	[TicketCellModelFactory makeCellModelFromTicket:ticket withCompletion:^(CellModel model) {

		[cell configureWith:model];
	}];

//	[cell configureWith:[TicketCellModelFactory makeCellModelFromTicket:ticket]];

	return cell;
}




#pragma mark - Table view delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

	return 140.0;
}



//MARK: - ViewInput protocol

@synthesize tickets;


@end
