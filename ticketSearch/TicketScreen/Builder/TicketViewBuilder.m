//
//  TicketViewBuilder.m
//  ticketSearch
//
//  Created by MacBook Pro on 28.06.2021.
//

#import "TicketViewBuilder.h"
#import "TicketTableViewController.h"

@implementation TicketViewBuilder

+ (UIViewController *)buildWithTickets:(NSArray *)tickets {

	TicketViewPresenter *presenter = [[TicketViewPresenter alloc] initWithTickets:tickets];
	TicketTableViewController *viewController = [[TicketTableViewController alloc] initWithPresenter:presenter];
	presenter.viewInput = viewController;

	return viewController;
}

@end
