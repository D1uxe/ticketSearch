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
#import "NotificationService.h"

#define TicketCellReuseIdentifier @"TicketCellIdentifier"

@interface TicketTableViewController ()

@property (nonatomic, strong) UIDatePicker *datePicker;
@property (nonatomic, strong) UITextField *dateTextField;

@end

@implementation TicketTableViewController {
	BOOL isFavoriteController;
	BOOL isFirstLoad;
	TicketTableViewCell *notificationCell;
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
		[self createDatePicker];
	}
	isFirstLoad = true;
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

- (void)createDatePicker {

	_datePicker = [[UIDatePicker alloc] init];
	_datePicker.datePickerMode = UIDatePickerModeDateAndTime;
	_datePicker.preferredDatePickerStyle = UIDatePickerStyleWheels;
	_datePicker.minimumDate = [NSDate date];

	_dateTextField = [[UITextField alloc] initWithFrame:self.view.bounds];
	_dateTextField.hidden = YES;
	_dateTextField.inputView = _datePicker;

	UIToolbar *keyboardToolbar = [[UIToolbar alloc] init];
	[keyboardToolbar sizeToFit];
	UIBarButtonItem *flexBarButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
	UIBarButtonItem *doneBarButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneButtonDidTap:)];
	keyboardToolbar.items = @[flexBarButton, doneBarButton];

	_dateTextField.inputAccessoryView = keyboardToolbar;

	[self.view addSubview:_dateTextField];
}

- (void)doneButtonDidTap:(UIBarButtonItem *)sender {

	NSDateFormatter *dateF = [[NSDateFormatter alloc] init];
	dateF.dateStyle = NSDateFormatterMediumStyle;
	dateF.timeStyle = NSDateFormatterShortStyle;
	dateF.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"ru"];

	if (_datePicker.date && notificationCell) {
		NSString *message = [NSString stringWithFormat:@"%@ за %@ ", notificationCell.cellModel.places, notificationCell.cellModel.price];

		NSURL *imageURL;
		if (notificationCell.cellModel.airlineLogo) {
			NSString *path = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject] stringByAppendingString:[NSString stringWithFormat:@"/%@.png", notificationCell.cellModel.airline]];
			if (![[NSFileManager defaultManager] fileExistsAtPath:path]) {
				UIImage *logo = notificationCell.cellModel.airlineLogo;
				NSData *pngData = UIImagePNGRepresentation(logo);
				[pngData writeToFile:path atomically:YES];

			}
			imageURL = [NSURL fileURLWithPath:path];
		}

		Notification notification = NotificationMake(@"Напоминание о билете", message, _datePicker.date, imageURL);
		[[NotificationService shared] sendNotification:notification];

		UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Успешно" message:[NSString stringWithFormat:@"Уведомление будет отправлено - %@", [dateF stringFromDate:_datePicker.date]] preferredStyle:(UIAlertControllerStyleAlert)];

		UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Закрыть" style:UIAlertActionStyleCancel handler:nil];
		[alertController addAction:cancelAction];

		_datePicker.date = [NSDate date];
		notificationCell = nil;
		[self.view endEditing:YES];

		[self presentViewController:alertController animated:YES completion:nil];
	}
}

- (void)showAlertAtIndexPath: (NSIndexPath *)indexPath {

	UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Действия с билетом" message:@"Создать напоминание для билета?" preferredStyle:UIAlertControllerStyleActionSheet];

	UIAlertAction *notificationAction = [UIAlertAction actionWithTitle:@"Напомнить" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
		self->notificationCell = [self.tableView cellForRowAtIndexPath:indexPath];
		[self->_dateTextField becomeFirstResponder];
	}];
	UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Закрыть" style:UIAlertActionStyleCancel handler:nil];

	[alertController addAction:notificationAction];
	[alertController addAction:cancelAction];

	[self presentViewController:alertController animated:YES completion:nil];
}

/* Deprecated. Использовался для анимации кнопки добавить в избранное
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
 */



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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

	if (isFavoriteController) return;

	[self showAlertAtIndexPath:indexPath];

}

//MARK: - ViewInput protocol

@synthesize tickets;


static void animateFavoriteButton(TicketTableViewCell *cell, BOOL flag) {
	
	[UIView transitionWithView:cell.favoriteButton
					  duration:0.3
					   options:UIViewAnimationOptionTransitionFlipFromLeft
					animations:^{
		cell.favoriteButton.tintColor = (flag == YES) ? UIColor.systemBlueColor : UIColor.lightGrayColor;
	}
					completion:^(BOOL finished) {
	}];
}

- (void)toggleFavoriteButton:(BOOL)flag atIndexPath:(NSIndexPath *)indexPath {

	if (isFavoriteController) {

		[self.tableView performBatchUpdates:^{

			[self->tickets removeObjectAtIndex:indexPath.row];
			[self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];

		} completion:^(BOOL finished) {
		}];
	} else {

		TicketTableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
		animateFavoriteButton(cell, flag);
	}
	/*
	 Лучше всего бы было делать reloadRows, но из-за этого происходит загрузка всех данных снова, которые по сути не изменились.
	 Поменялось только состояние кнопки - закрашена/не закрашена, поэтому перезагрузку таблицы делать не стал - не оптимально в данном
	 случае.
	 [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
	 */
}

@end
