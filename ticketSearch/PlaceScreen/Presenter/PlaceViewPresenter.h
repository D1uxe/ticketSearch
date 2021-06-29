//
//  PlaceViewPresenter.h
//  ticketSearch
//
//  Created by MacBook Pro on 21.06.2021.
//

#import <UIKit/UIKit.h>
#import "DataManager.h"
#import "PlaceType.h"

@class MainViewPresenter;

// Протокол связи Presenter-to-View
@protocol PlaceViewInput <NSObject>

@property (nonatomic, strong, nonnull) NSArray * currentSourceArray;

-(void)reloadTable;

@end

// Протокол связи View-to-Presenter
@protocol PlaceViewOutput <NSObject>

-(void)viewDidSelectSourceWith:(NSInteger)selectedIndex;
-(void)viewDidSelectPlace:(id _Nonnull )place withType:(PlaceType)placeType;

@end


NS_ASSUME_NONNULL_BEGIN

@interface PlaceViewPresenter : NSObject <PlaceViewOutput>

@property(nonatomic)PlaceType place;
@property(nonatomic, weak) UIViewController<PlaceViewInput> *viewInput;


-(instancetype)initWithPresenter:(MainViewPresenter *) mainPresenter; // Здесь лучше использовать тип протокла id<MainViewOutput>. Но почему-то ошибка. Что-то с подключениями хэдеров.

@end

NS_ASSUME_NONNULL_END
