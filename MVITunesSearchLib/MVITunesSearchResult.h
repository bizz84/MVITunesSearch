//
// Created by Andrea Bizzotto on 08/05/2014.
// Copyright (c) 2014 musevisions. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface MVITunesSearchResult : NSObject
@property (copy, nonatomic) NSString *appBundleId;
@property (copy, nonatomic) NSString *appId;
@property (copy, nonatomic) NSString *appURL;
@property (copy, nonatomic) NSString *iconArtworkSize60URL;
@property (copy, nonatomic) NSString *iconArtworkSize100URL;
@property (copy, nonatomic) NSString *iconArtworkSize512URL;
@property (copy, nonatomic) NSDictionary *result;
@end