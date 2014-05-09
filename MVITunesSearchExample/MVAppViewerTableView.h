//
// Created by Andrea Bizzotto on 09/05/2014.
// Copyright (c) 2014 musevisions. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface MVAppViewerTableView : UITableView

- (void)searchWithDeveloperId:(NSString *)developerId excludedBundleIDs:(NSArray *)excludedBundleIDs;

@end