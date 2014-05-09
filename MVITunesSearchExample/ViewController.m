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

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    MVITunesSearch *search = [[MVITunesSearch alloc] initWithArtistID:@"539165502" exludedBundleIDs:nil];
    [search doSearch:^(NSArray *searchResults, NSError *error) {

        for (MVITunesSearchResult *result in searchResults) {
            //NSLog(@"%@", [result debugDescription]);
            NSLog(@"%@", result);
        }
    }];
}

@end
