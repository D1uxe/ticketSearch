//
//  TicketViewPresenter.m
//  ticketSearch
//
//  Created by MacBook Pro on 28.06.2021.
//

#import "TicketViewPresenter.h"
#import "APIManager.h"

@interface TicketViewPresenter ()

@property (nonatomic, strong, nonnull) NSArray *tickets;

@end
@implementation TicketViewPresenter



//MARK: - Initialisers

- (instancetype)initWithTickets:(NSArray *)tickets {

	self = [super init];
	if (self) {

		_tickets = tickets;
	}
	return self;
}


//MARK: ViewOutput protocol

- (void)viewRequestTickets {
	
	_viewInput.tickets = _tickets;

}

@end



