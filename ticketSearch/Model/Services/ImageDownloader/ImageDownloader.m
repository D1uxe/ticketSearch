//
//  ImageDownloader.m
//  ticketSearch
//
//  Created by MacBook Pro on 29.06.2021.
//

#import "ImageDownloader.h"


#define AirlineLogo(iata) [NSURL URLWithString:[NSString stringWithFormat:@"https://pics.avs.io/200/200/%@.png", iata]];

@implementation ImageDownloader

//MARK: - Initialisers

+ (instancetype)shared {
	static ImageDownloader *instance;
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		instance = [[ImageDownloader alloc] init];
	});
	return instance;
}

//MARK: - Public methods

-(void)getImageForAirline:(NSString *)iata withCompletion:(void (^)(UIImage *image))completion {
	
	NSURL *urlLogo = AirlineLogo(iata);
	
	[[NSURLSession.sharedSession dataTaskWithURL:urlLogo
							   completionHandler:^(NSData * _Nullable data,
												   NSURLResponse * _Nullable response,
												   NSError * _Nullable error) {
		
		if (data) {
			UIImage *image = [[UIImage alloc] initWithData: data scale:1.0];
			
			dispatch_async(dispatch_get_main_queue(), ^{
				completion(image);
			});
			
		}
		
		if (error) {
			NSLog(@"Error while executing request with url %@. Reason: %@", urlLogo, error.localizedDescription);
		}
	}] resume];
}
@end
