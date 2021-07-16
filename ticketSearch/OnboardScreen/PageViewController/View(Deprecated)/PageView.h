//
//  PageView.h
//  ticketSearch
//
//  Created by MacBook Pro on 12.07.2021.
//

#import <UIKit/UIKit.h>

#define CONTENT_COUNT 4

NS_ASSUME_NONNULL_BEGIN


@interface PageView : UIView

@property (strong, nonatomic) UIButton *nextButton;
@property (strong, nonatomic) UIPageControl *pageControl;

@end

NS_ASSUME_NONNULL_END
