//
//  UIApplication+keyWindow.m
//  ticketSearch
//
//  Created by MacBook Pro on 11.07.2021.
//

#import "UIApplication+keyWindow.h"

@implementation UIApplication (keyWindow)

+(UIWindow *)keyWindow {

	NSPredicate *isKeyWindow = [NSPredicate predicateWithFormat:@"isKeyWindow == YES"];
	return [[[UIApplication sharedApplication] windows] filteredArrayUsingPredicate:isKeyWindow].firstObject;
}

@end
