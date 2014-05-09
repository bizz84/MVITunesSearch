//
// Created by Andrea Bizzotto on 08/05/2014.
// Copyright (c) 2014 musevisions. All rights reserved.
//

#import "MVITunesSearchResult.h"

@interface MVITunesSearchResult ()

@end

@implementation MVITunesSearchResult

- (NSString *)description {

    return [NSString stringWithFormat:@"appId: %@\nappURL: %@\nappName: %@\nbundle: %@\nartwork URL(60): %@\nartwork URL(100): %@\nartwork URL(512): %@\n\n",
        self.appId, self.appURL, self.appName, self.appBundleId, self.iconArtworkSize60URL, self.iconArtworkSize100URL, self.iconArtworkSize512URL];
}

- (NSString *)debugDescription
{
    return [NSString stringWithFormat:@"%@", self.result];
}

@end