//
//  AppStartManager.h
//  ticketSearch
//
//  Created by MacBook Pro on 20.06.2021.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


NS_ASSUME_NONNULL_BEGIN

@interface AppStartManager : NSObject

//MARK: Initialisers

-(instancetype)initWithWindow:(UIWindow*) window withScene:(UIScene*)scene;


//MARK: Methods

-(void)start;

@end

NS_ASSUME_NONNULL_END
