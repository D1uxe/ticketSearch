//
//  MapViewPresenter.h
//  ticketSearch
//
//  Created by MacBook Pro on 01.07.2021.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

// Протокол связи Presenter-to-View
@protocol MapViewInput <NSObject>

-(void)setMapRegion:(MKCoordinateRegion)region;
-(void)addMapAnnotation:(MKPointAnnotation *_Nonnull)annotation;
-(void)removeMapAnnotation;

@end

// Протокол связи View-to-Presenter
@protocol MapViewOutput <NSObject>

-(void)viewRequestTickets;

@end


NS_ASSUME_NONNULL_BEGIN

@interface MapViewPresenter : NSObject <MapViewOutput>

@property (nonatomic, weak) UIViewController<MapViewInput> *viewInput;

@end

NS_ASSUME_NONNULL_END
