//
//  TicketViewPresenter.h
//  ticketSearch
//
//  Created by MacBook Pro on 28.06.2021.
//

#import <UIKit/UIKit.h>

// Протокол связи Presenter-to-View
@protocol TicketViewInput <NSObject>

@property (nonatomic, strong, nonnull) NSMutableArray * tickets;

-(void)toggleFavoriteButton:(BOOL)flag atIndexPath:(NSIndexPath *_Nonnull)indexPath;

@end

// Протокол связи View-to-Presenter
@protocol TicketViewOutput <NSObject>

-(void)viewRequestTickets;
-(void)viewRequestFavoriteTickets;
-(void)viewDidTapFavoriteButtonWith:(NSIndexPath *_Nonnull)indexPath;

@end


NS_ASSUME_NONNULL_BEGIN

@interface TicketViewPresenter : NSObject <TicketViewOutput>

@property(nonatomic, weak) UIViewController<TicketViewInput> *viewInput;

- (instancetype)initWithTickets:(NSArray *)tickets;

@end

NS_ASSUME_NONNULL_END
