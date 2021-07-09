//
//  TicketTableViewController.m
//  ticketSearch
//
//  Created by MacBook Pro on 28.06.2021.
//

#import "TicketTableViewController.h"
#import "TicketViewPresenter.h"
#import "TicketTableViewCell.h"
#import "FavoriteTicket+CoreDataClass.h"

#define TicketCellReuseIdentifier @"TicketCellIdentifier"

@interface TicketTableViewController ()

@end

@implementation TicketTableViewController {
	BOOL isFavoriteController;
	BOOL isFirstLoad;
	CGFloat tabOriginX;
}

//MARK: - Initialisers

- (instancetype)initWithPresenter:(id<TicketViewOutput>)presenter {

	self = [super init];
	if (self) {
		_presenter = presenter;
		self.title = @"Билеты";
	}
	return self;
}

- (instancetype)initFavoriteTicketsControllerWithPresenter:(id<TicketViewOutput>)presenter {

	self = [super init];
	if (self) {
		_presenter = presenter;
		isFavoriteController = YES;
		self.title = @"Избранное";
	}
	return self;
}


//MARK: - Lifecycle

- (void)viewDidLoad {
	[super viewDidLoad];

	self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
	[self.tableView registerClass:[TicketTableViewCell class] forCellReuseIdentifier:TicketCellReuseIdentifier];
	
	if (isFavoriteController) {

		[_presenter viewRequestFavoriteTickets];
	} else {

		[_presenter viewRequestTickets];
	}
	isFirstLoad = true;

	tabOriginX = CGRectGetMidX([self getFrameForTabInTabBar:self.tabBarController.tabBar withIndex:2]);
}

- (void)viewDidAppear:(BOOL)animated {
	[super viewDidAppear:animated];

	if (isFirstLoad) {
		isFirstLoad = false;
		return;
	}

	if (isFavoriteController) {

		[_presenter viewRequestFavoriteTickets];
		[self.tableView reloadData];
	} else {

		[_presenter viewRequestTickets];
		[self.tableView reloadData];
	}
}


//MARK: - Private methods

- (void)favoriteButtonDidTap:(UIButton *)sender {

	UIResponder *responder = sender.nextResponder;
	NSIndexPath *indexPath;

	while (responder.nextResponder) {
		responder = responder.nextResponder;
		if ([responder isMemberOfClass:[TicketTableViewCell class]]) {
			indexPath = [self.tableView indexPathForCell:(UITableViewCell*)responder];
			break;
		}
	}
	[_presenter viewDidTapFavoriteButtonWith:indexPath];

	/* также можно вот таким способом сделать

	 for (UITableViewCell *cell in self.tableView.visibleCells) {
	 if ([sender isDescendantOfView:cell]) {
	 NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
	 NSLog(@"tapped %@", indexPath);
	 break;
	 }
	 }
	 */
}

- (CGRect)getFrameForTabInTabBar:(UITabBar*)tabBar withIndex:(NSUInteger)index {

	NSUInteger currentTabIndex = 0;

	for (UIView* subView in tabBar.subviews)
	{
		if ([subView isKindOfClass:NSClassFromString(@"UITabBarButton")])
		{
			if (currentTabIndex == index)
				return subView.frame;
			else
				currentTabIndex++;
		}
	}
	NSAssert(NO, @"Index is out of bounds");
	return CGRectNull;
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

	return tickets.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

	TicketTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:TicketCellReuseIdentifier forIndexPath:indexPath];

	[cell.favoriteButton addTarget:self action:@selector(favoriteButtonDidTap:) forControlEvents:UIControlEventTouchUpInside];

	[TicketCellModelFactory makeCellModelFromTicket:[tickets objectAtIndex:indexPath.row] withCompletion:^(CellModel model) {
		[cell configureWith:model];
	}];

	return cell;
}



#pragma mark - Table view delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

	return 155.0;
}



//MARK: - ViewInput protocol

@synthesize tickets;


- (void)toggleFavoriteButton:(BOOL)flag atIndexPath:(NSIndexPath *)indexPath {

	if (isFavoriteController) {

		[self.tableView performBatchUpdates:^{

			[self->tickets removeObjectAtIndex:indexPath.row];
			[self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];

		} completion:^(BOOL finished) {
		}];
	} else {
		TicketTableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
		cell.favoriteButton.tintColor = (flag == YES) ? UIColor.systemBlueColor : UIColor.lightGrayColor;

		[UIView animateWithDuration:0.3
							  delay:0
			 usingSpringWithDamping:0.5
			  initialSpringVelocity:0.2
							options:UIViewAnimationOptionCurveEaseOut
						 animations:^{
			cell.favoriteButton.transform = CGAffineTransformMakeTranslation(self->tabOriginX - cell.favoriteButton.frame.origin.x - 25.0, 0);
		}
						 completion:^(BOOL finished) {

			[UIView animateWithDuration:0.5
								  delay:0
				 usingSpringWithDamping:1
				  initialSpringVelocity:1
								options:UIViewAnimationOptionCurveEaseOut
							 animations:^{

				cell.favoriteButton.transform = CGAffineTransformMakeTranslation(0, 250);
				cell.favoriteButton.alpha = 0;
			}
							 completion:^(BOOL finished) {

				cell.favoriteButton.transform = CGAffineTransformIdentity;
				cell.favoriteButton.alpha = 1;

			}];
		}];
	}
	/*
	 Лучше всего бы было делать reloadRows, но из-за этого происходит загрузка всех данных снова, которые по сути не изменились.
	 Поменялось только состояние кнопки - закрашена/незакрашена, поэтому перезагрузку таблицы делать не стал - не оптимально в данном
	 случае.
	 [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
	 */
}


@end
