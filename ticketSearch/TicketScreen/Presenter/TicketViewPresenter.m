//
//  TicketViewPresenter.m
//  ticketSearch
//
//  Created by MacBook Pro on 28.06.2021.
//

#import "TicketViewPresenter.h"
#import "APIManager.h"
#import "CoreDataHelper.h"

@interface TicketViewPresenter ()

@property (nonatomic, strong, nonnull) NSMutableArray *tickets;

@end

@implementation TicketViewPresenter

//MARK: - Initialisers

- (instancetype)initWithTickets:(NSMutableArray *)tickets {

	self = [super init];
	if (self) {

		_tickets = tickets;
	}
	return self;
}


//MARK: - Private methods

- (void)getTickets {

	for (Ticket *ticket in _tickets) {
		if ([[CoreDataHelper shared] isFavorite:ticket]) {
			ticket.isFavorite = YES;
		} else {
			ticket.isFavorite = NO;
		}
	}
	_viewInput.tickets = _tickets;
}

- (void)getFavoriteTickets {

	_tickets = [NSMutableArray arrayWithArray:[[CoreDataHelper shared] favoriteTickets]];

	_viewInput.tickets = _tickets;
}

- (void)favoriteButtonHandler:(NSIndexPath *)indexPath {

	Ticket *ticket = [_tickets objectAtIndex:indexPath.row];

	if ([[CoreDataHelper shared] isFavorite:ticket])  {

		[[CoreDataHelper shared] removeFromFavorite:ticket];
		ticket.isFavorite = !ticket.isFavorite;
		[_viewInput toggleFavoriteButton: ticket.isFavorite atIndexPath:indexPath];
	} else {
		
		[[CoreDataHelper shared] addToFavorite:ticket];
		ticket.isFavorite = !ticket.isFavorite;
		[_viewInput toggleFavoriteButton: ticket.isFavorite atIndexPath:indexPath];
	}
}



//MARK: ViewOutput protocol

- (void)viewRequestTickets {

	[self getTickets];
}

- (void)viewRequestFavoriteTickets {

	[self getFavoriteTickets];
}

- (void)viewDidTapFavoriteButtonWith:(NSIndexPath *)indexPath {

	[self favoriteButtonHandler:indexPath];
}

@end



