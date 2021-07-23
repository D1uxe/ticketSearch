//
//  ContentViewController.h
//  ticketSearch
//
//  Created by MacBook Pro on 12.07.2021.
//

#import <UIKit/UIKit.h>
#import "ContentView.h"

NS_ASSUME_NONNULL_BEGIN

@interface ContentViewController : UIViewController

@property (nonatomic, strong) NSString *contentText;
@property (nonatomic, strong) UIImage *image;
@property (nonatomic) int index;

@end

NS_ASSUME_NONNULL_END
