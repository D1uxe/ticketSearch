//
//  NotificationService.h
//  ticketSearch
//
//  Created by MacBook Pro on 13.07.2021.
//

#import <Foundation/Foundation.h>
#import <UserNotifications/UserNotifications.h>

typedef struct {
	__unsafe_unretained NSString * _Nullable title;
	__unsafe_unretained NSString * _Nonnull body;
	__unsafe_unretained NSDate * _Nonnull date;
	__unsafe_unretained NSURL * _Nullable imageURL;
} Notification;


NS_ASSUME_NONNULL_BEGIN

@interface NotificationService : NSObject <UNUserNotificationCenterDelegate>

+ (instancetype _Nonnull)shared;

- (void)registerService;
- (void)sendNotification:(Notification)notification;
Notification NotificationMake(NSString* _Nullable title, NSString* _Nonnull body, NSDate* _Nonnull date, NSURL * _Nullable  imageURL);

@end

NS_ASSUME_NONNULL_END
