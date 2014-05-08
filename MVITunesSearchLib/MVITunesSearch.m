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

- (void)doSearch {

    NSString *searchAddress = [NSString stringWithFormat:kITunesSearchURLFormat, self.artistID];
    NSURL *searchURL = [NSURL URLWithString:searchAddress];

    NSURLSession *session = [NSURLSession sharedSession];
    [[session dataTaskWithURL:searchURL
            completionHandler:^(NSData *data,
                    NSURLResponse *response,
                    NSError *error) {
                // handle response

                [self parseData:data];
            }] resume];
}

- (BOOL)parseData:(NSData *)data {
    NSError *error = nil;
    NSDictionary *contents = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
    if (error != nil) {
        NSLog(@"Error parsing JSON.");
        return NO;
    }
    NSArray *results = contents[@"results"];
    if (results == nil)
        return NO;

    // Clear
    [self.searchResults removeAllObjects];

    for (NSDictionary *result in results) {

        NSString *bundleID = result[@"bundleId"];
        // If bundleID is not found, skip (this is the case for the first result containing the artist details)
        if (bundleID == nil)
            continue;
        BOOL shouldExclude = [self shouldExcludeBundleId:bundleID];

        if (!shouldExclude) {

            [self processResult:result];
        }

    }
    return YES;
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

- (void)processResult:(NSDictionary *)result {

    MVITunesSearchResult *searchResult = [MVITunesSearchResult new];
    searchResult.appBundleId = result[@"bundleId"];
    searchResult.appId = result[@"trackId"];
    searchResult.appURL = result[@"trackViewUrl"];
    searchResult.iconArtworkSize60URL = [self artworkURLForResult:result withSize:@"60"];
    searchResult.iconArtworkSize100URL = [self artworkURLForResult:result withSize:@"100"];
    searchResult.iconArtworkSize512URL = [self artworkURLForResult:result withSize:@"512"];

    [self.searchResults addObject:searchResult];

    NSLog(@"%@", searchResult);
}

@end
