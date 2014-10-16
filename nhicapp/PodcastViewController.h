//
//  PodcastViewController.h
//  nhicapp
//
//  Created by Mark John Merin on 10/10/14.
//  Copyright (c) 2014 Apps4Christ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PodcastViewController : UITableViewController <NSXMLParserDelegate, UISearchDisplayDelegate, UITableViewDelegate, UITableViewDataSource>
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (strong, nonatomic) IBOutlet UISearchDisplayController *searchController;


@property (strong, nonatomic) NSMutableArray *searchResult;


@end
