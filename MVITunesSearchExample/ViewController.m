//
//  ViewController.m
//  MVITunesSearch
//
//  Created by Andrea Bizzotto on 08/05/2014.
//  Copyright (c) 2014 musevisions. All rights reserved.
//

#import "ViewController.h"
#import "MVITunesSearch.h"
#import "MVITunesSearchResult.h"
#import "SDImageCache.h"
#import "SDWebImageDownloader.h"
#import "MVAppViewerTableView.h"

@interface ViewController ()
@property (strong, nonatomic) IBOutlet MVAppViewerTableView *tableView;

@end

@implementation ViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.

}

- (void)viewDidAppear:(BOOL)animated
{
    [self.tableView searchWithDeveloperId:@"539165502" excludedBundleIDs:nil];
}

@end
