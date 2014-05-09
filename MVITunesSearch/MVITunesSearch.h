//
//  MVITunesSearch.h
//  MVITunesSearch
//
//  Created by Andrea Bizzotto on 08/05/2014.
//  Copyright (c) 2014 musevisions. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MVITunesSearch : NSObject

+ (instancetype)searchWithArtistID:(NSString *)artistID exludedBundleIDs:(NSArray *)exludedBundleIDs completion:(void(^)(NSArray *searchResults, NSError *error))completionBlock;

- (id)initWithArtistID:(NSString *)artistID exludedBundleIDs:(NSArray *)exludedBundleIDs;

- (void)doSearch:(void(^)(NSArray *searchResults, NSError *error))completionBlock;

@property (strong, nonatomic, readonly) NSMutableArray *searchResults;

@end
