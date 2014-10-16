//
//  HomeViewController.m
//  nhicapp
//
//  Created by Mark John Merin on 10/9/14.
//  Copyright (c) 2014 Apps4Christ. All rights reserved.
//

#import "HomeViewController.h"
#import "HomeDetailViewController.h"

@interface HomeViewController ()

@end

@implementation HomeViewController {
    NSArray *homeAbout;
    NSArray *links;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    homeAbout = [NSArray arrayWithObjects:@"Our Vision", @"Statement of Faith", @"Core Values", nil];
    links = [NSArray arrayWithObjects:@"http://www.newhic.org/about/vision-of-our-church/",
             @"http://www.newhic.org/about/statement-of-faith/", @"http://www.newhic.org/about/core-values/", nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberofSectionsInTableView:(UITableView *) tableView {
    return 1;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return homeAbout.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"Cell";
    
    tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    self.tableView.scrollEnabled = NO;
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    
    cell.textLabel.text = [homeAbout objectAtIndex:indexPath.row];
    return cell;
}


#pragma mark - Navigation
 
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    NSString *string;
    
    NSLog(@"hello");
    
    if ([[segue identifier] isEqualToString:@"showHomeDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        string = links[indexPath.row];
        
        NSLog(@"home detail view link is: %@", string);
        [[segue destinationViewController] setUrl:string];
    }
}
 



@end
