//
//  MVITunesSearch.h
//  MVITunesSearch
//
//  Created by Andrea Bizzotto on 08/05/2014.
//  Copyright (c) 2014 musevisions. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MVITunesSearch : NSObject

- (id)initWithArtistID:(NSString *)artistID exludedBundleIDs:(NSArray *)exludedBundleIDs;

- (void)doSearch;

@property (strong, nonatomic, readonly) NSMutableArray *searchResults;

@end
