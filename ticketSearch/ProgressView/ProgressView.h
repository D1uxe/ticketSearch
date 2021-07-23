//
//  ProgressView.h
//  ticketSearch
//
//  Created by MacBook Pro on 11.07.2021.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ProgressView : UIView

- (void)show:(void (^)(void))completion;
- (void)dismiss:(void (^)(void))completion;

+ (instancetype)shared;

@end

NS_ASSUME_NONNULL_END
