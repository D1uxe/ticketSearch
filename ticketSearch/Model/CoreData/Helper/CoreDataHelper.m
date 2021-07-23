//
//  CoreDataHelper.m
//  ticketSearch
//
//  Created by MacBook Pro on 08.07.2021.
//

#import "CoreDataHelper.h"

@interface CoreDataHelper ()

@property(nonatomic, strong)NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property(nonatomic,strong)NSManagedObjectContext *managedObjectContext;
@property(nonatomic,strong)NSManagedObjectModel *managedObjectModel;

@end

@implementation CoreDataHelper

//MARK: - Public properties

- (NSArray *)favoriteTickets {

	NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"FavoriteTicket"];
	request.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"created" ascending:NO]];
	return [_managedObjectContext executeFetchRequest:request error:nil];
}

//MARK: - Initialisers

+(instancetype)shared {
	
	static CoreDataHelper *instance;
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{

		instance = [[CoreDataHelper alloc] init];
		[instance setup];
	});
	return instance;
}

//MARK: - Private methods

- (void)setup {

	// Managed object model
	NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"ticketSearchModel" withExtension:@"momd"];
	_managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];

	// Persistent store coordinator
	NSURL *docsURL = [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
	NSURL *storeURL = [docsURL URLByAppendingPathComponent:@"base.sqlite"];
	_persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:_managedObjectModel];

	NSPersistentStore* store = [_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType
																		 configuration:nil
																				   URL:storeURL
																			   options:nil
																				 error:nil];
	if (!store) {
		NSLog(@"Failed to create database file");
		abort();
	}

	// Managed object context
	_managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
	_managedObjectContext.persistentStoreCoordinator = _persistentStoreCoordinator;
}

- (void)save {

	NSError *error;
	[_managedObjectContext save: &error];
	if (error) {
		NSLog(@"%@", [error localizedDescription]);
	}
}


//MARK: - Public methods

- (FavoriteTicket *)favoriteFromTicket:(Ticket *)ticket {

	NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"FavoriteTicket"];
	request.predicate = [NSPredicate predicateWithFormat:@"price == %ld AND airline == %@ AND from == %@ AND to == %@ AND departure == %@ AND  flightNumber == %ld",
						 ticket.price,
						 ticket.airline,
						 ticket.from,
						 ticket.to,
						 ticket.departure,

						 ticket.flightNumber];
	return [[_managedObjectContext executeFetchRequest:request error:nil] firstObject];
}

- (BOOL)isFavorite:(Ticket *)ticket {

	return [self favoriteFromTicket:ticket] != nil;
}

- (void)addToFavorite:(Ticket *)ticket {

	FavoriteTicket *favorite = [NSEntityDescription insertNewObjectForEntityForName:@"FavoriteTicket" inManagedObjectContext:_managedObjectContext];
	favorite.price = ticket.price;
	favorite.airline = ticket.airline;
	favorite.departure = ticket.departure;
	favorite.expires = ticket.expires;
	favorite.flightNumber = ticket.flightNumber;
	favorite.returnDate = ticket.returnDate;
	favorite.from = ticket.from;
	favorite.to = ticket.to;
	favorite.created = [NSDate date];

	favorite.isFavorite = YES;

	[self save];
}

- (void)removeFromFavorite:(Ticket *)ticket {

	FavoriteTicket *favorite = [self favoriteFromTicket:ticket];
	if (favorite) {
		[_managedObjectContext deleteObject:favorite];
		[self save];
	}
}


@end
