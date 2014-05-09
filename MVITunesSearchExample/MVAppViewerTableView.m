//
// Created by Andrea Bizzotto on 09/05/2014.
// Copyright (c) 2014 musevisions. All rights reserved.
//

#import <SDWebImage/SDWebImageDownloader.h>
#import <SDWebImage/SDImageCache.h>
#import "MVAppViewerTableView.h"
#import "MVITunesSearchResult.h"
#import "MVITunesSearch.h"

@interface MVAppViewerTableView ()<UITableViewDataSource, UITableViewDelegate>
@property (strong, nonatomic) NSArray *searchResults;
@property (strong, nonatomic) SDWebImageDownloader *imageDownloader;

@end

@implementation MVAppViewerTableView

- (void)searchWithDeveloperId:(NSString *)developerId excludedBundleIDs:(NSArray *)excludedBundleIDs {

    self.delegate = self;
    self.dataSource = self;
    self.imageDownloader = [SDWebImageDownloader new];

    MVITunesSearch *search = [[MVITunesSearch alloc] initWithArtistID:developerId exludedBundleIDs:excludedBundleIDs];
    [search doSearch:^(NSArray *searchResults, NSError *error) {

        self.searchResults = searchResults;
        NSUInteger rowCounter = 0;
        for (MVITunesSearchResult *result in searchResults) {

            NSString *imageURLAddress = result.iconArtworkSize60URL;
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:rowCounter inSection:0];
            [self downloadAndUpdateImage:imageURLAddress forIndexPath:indexPath];
            rowCounter++;

            //NSLog(@"%@", result);
        }
        [self reloadData];
    }];
}

- (void)downloadAndUpdateImage:(NSString *)imageURLAddress forIndexPath:(NSIndexPath *)indexPath {

    NSURL *url = [NSURL URLWithString:imageURLAddress];
    UIImage *image = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:imageURLAddress];
    if (image == nil) {
        NSLog(@"Downloading image: %@", imageURLAddress);
        [self.imageDownloader downloadImageWithURL:url options:SDWebImageDownloaderUseNSURLCache progress:nil completed:^(UIImage *image, NSData *data, NSError *error, BOOL finished) {
            [[SDImageCache sharedImageCache] storeImage:image forKey:imageURLAddress];

            // First time this doesn't work!
            [self updateCellAtIndexPath:indexPath withImage:image];
        }];
    }
    else {
        NSLog(@"Image already exists: %@", imageURLAddress);
        [self updateCellAtIndexPath:indexPath withImage:image];
    }
}

- (void)updateCellAtIndexPath:(NSIndexPath *)indexPath withImage:(UIImage *)image {
    UITableViewCell *cell = [self cellForRowAtIndexPath:indexPath];
    if (cell != nil) {
        cell.imageView.image = image;
    }
    else {
        //
    }
}

#pragma mark - table view
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.searchResults.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.textLabel.font = [UIFont systemFontOfSize:12.0f];
        cell.textLabel.numberOfLines = 0;
        cell.imageView.layer.cornerRadius = 5;
        cell.imageView.layer.masksToBounds = YES;
        cell.imageView.bounds = CGRectMake(0, 0, 30, 30); // setting bounds not working
        cell.imageView.image = [UIImage imageNamed:@"placeholderImage60.png"];
    }
    NSUInteger row = (NSUInteger)indexPath.row;
    if (row < self.searchResults.count) {
        MVITunesSearchResult *searchResult = [self.searchResults objectAtIndex:row];
        cell.textLabel.text = searchResult.appName;
        UIImage *image = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:searchResult.iconArtworkSize60URL];
        cell.imageView.image = image;
        cell.imageView.bounds = CGRectMake(0, 0, 30, 30);
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44.0f;
}
- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44.0f;
}


@end