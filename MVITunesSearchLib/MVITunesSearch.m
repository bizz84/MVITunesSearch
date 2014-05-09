//
//  MVITunesSearch.m
//  MVITunesSearch
//
//  Created by Andrea Bizzotto on 08/05/2014.
//  Copyright (c) 2014 musevisions. All rights reserved.
//

#import "MVITunesSearch.h"
#import "MVITunesSearchResult.h"

static NSString *kITunesSearchURLFormat = @"https://itunes.apple.com/lookup?id=%@&entity=software";

@interface MVITunesSearch ()
@property (copy, nonatomic) NSString *artistID;
@property (copy, nonatomic) NSArray *exludedBundleIDs;
@property (strong, nonatomic) NSMutableArray *searchResults;
@end

@implementation MVITunesSearch

- (id)initWithArtistID:(NSString *)artistID exludedBundleIDs:(NSArray *)exludedBundleIDs {

    if (self = [super init]) {

        self.artistID = artistID;
        self.exludedBundleIDs = exludedBundleIDs;
        self.searchResults = [NSMutableArray new];
    }
    return self;
}

- (void)doSearch:(void(^)(NSArray *searchResults, NSError *error))completionBlock {

    NSString *searchAddress = [NSString stringWithFormat:kITunesSearchURLFormat, self.artistID];
    NSURL *searchURL = [NSURL URLWithString:searchAddress];

    NSURLSession *session = [NSURLSession sharedSession];
    [[session dataTaskWithURL:searchURL
            completionHandler:^(NSData *data,
                    NSURLResponse *response,
                    NSError *error) {

                // handle response
                if (error == nil) {
                    [self parseData:data completion:completionBlock];
                }
                else {
                    completionBlock(nil, error);
                }

            }] resume];
}

- (void)parseData:(NSData *)data completion:(void(^)(NSArray *searchResults, NSError *error))completionBlock {
    NSError *error = nil;
    NSDictionary *contents = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
    if (error != nil) {
        completionBlock(nil, error);
        return;
    }
    NSArray *results = contents[@"results"];
    if (results == nil) {
        completionBlock(@[], nil);
        return;
    }

    NSMutableArray *searchResults = [NSMutableArray new];

    for (NSDictionary *result in results) {

        NSString *bundleID = result[@"bundleId"];
        // If bundleID is not found, skip (this is the case for the first result containing the artist details)
        if (bundleID == nil)
            continue;
        BOOL shouldExclude = [self shouldExcludeBundleId:bundleID];

        if (!shouldExclude) {

            [searchResults addObject:[self processResult:result]];
        }
    }
    completionBlock(searchResults, nil);
}

- (BOOL)shouldExcludeBundleId:(NSString *)bundleId {

    for (NSString *excludedBundleId in self.exludedBundleIDs) {
        if ([excludedBundleId isEqualToString:bundleId]) {
            return YES;
        }
    }
    return NO;
}

- (NSString *)artworkURLForResult:(NSDictionary *)result withSize:(NSString *)artworkSizeString {

    NSString *artworkKey = [NSString stringWithFormat:@"artworkUrl%@", artworkSizeString];
    return result[artworkKey];
}

- (MVITunesSearchResult *)processResult:(NSDictionary *)result {

    MVITunesSearchResult *searchResult = [MVITunesSearchResult new];
    searchResult.result = result;
    // Derived values
    searchResult.appBundleId = result[@"bundleId"];
    searchResult.appId = result[@"trackId"];
    searchResult.appURL = result[@"trackViewUrl"];
    searchResult.iconArtworkSize60URL = [self artworkURLForResult:result withSize:@"60"];
    searchResult.iconArtworkSize100URL = [self artworkURLForResult:result withSize:@"100"];
    searchResult.iconArtworkSize512URL = [self artworkURLForResult:result withSize:@"512"];
    return searchResult;
}

@end
