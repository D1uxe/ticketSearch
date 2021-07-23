//
//  SearchRequest.h
//  ticketSearch
//
//  Created by MacBook Pro on 27.06.2021.
//

#ifndef SearchRequest_h
#define SearchRequest_h

typedef struct SearchRequest {
	__unsafe_unretained NSString *origin;
	__unsafe_unretained NSString *destination;
	__unsafe_unretained NSDate *departDate;
	__unsafe_unretained NSDate *returnDate;
} SearchRequest;

#endif /* SearchRequest_h */
