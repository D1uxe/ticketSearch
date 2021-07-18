//
//  PlaceViewPresenter.h
//  ticketSearch
//
//  Created by MacBook Pro on 21.06.2021.
//

#import <UIKit/UIKit.h>


// Протокол связи Presenter-to-View
@protocol PlaceViewInput <NSObject>

@end

// Протокол связи View-to-Presenter
@protocol PlaceViewOutput <NSObject>

-(void)viewDidSelect;

@end

NS_ASSUME_NONNULL_BEGIN

@interface PlaceViewPresenter : NSObject <PlaceViewOutput>

@property(nonatomic, weak) UIViewController<PlaceViewInput> *viewInput;

@end

NS_ASSUME_NONNULL_END
