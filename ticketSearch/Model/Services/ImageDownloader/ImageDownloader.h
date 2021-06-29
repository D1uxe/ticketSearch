//
//  ImageDownloader.h
//  ticketSearch
//
//  Created by MacBook Pro on 29.06.2021.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ImageDownloader : NSObject

+ (instancetype)shared;

-(void)getImageForAirline:(NSString *)iata withCompletion:(void (^)(UIImage *image))completion;

@end

NS_ASSUME_NONNULL_END
