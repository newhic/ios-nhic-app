//
//  PodcastViewController.m
//  nhicapp
//
//  Created by Mark John Merin on 10/10/14.
//  Copyright (c) 2014 Apps4Christ. All rights reserved.
//

#import "PodcastViewController.h"
#import "PodcastDetailViewController.h"
#import "Reachability.h"

@interface PodcastViewController () {
    NSXMLParser *parser;
    NSMutableArray *feeds;
    NSMutableDictionary *item;
    NSMutableString *title;
    NSMutableString *link;
    NSMutableString *author;
    NSString *element;
    NSArray *pickerURL;
}
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *indicator;

@end

@implementation PodcastViewController

-(void)loadPodcastData {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSInteger selection;
    NSURL *url;
    NSString *urlString;
    
    pickerURL = @[@"http://www.newhic.org/Media/Audio/rss.xml",
                  @"http://www.newhic.org/Media/Thai/rss.xml",
                  @"http://www.newhic.org/Media/Mandarin/rss.xml",
                  @"http://www.newhic.org/Media/Japanese/rss.xml",
                  @"http://www.newhic.org/Media/German/rss.xml"];
    
    // Do any additional setup after loading the view.
    
    feeds = [[NSMutableArray alloc] init];
    
    selection = [defaults integerForKey:@"pdcstLang_pref"];
    
    if(selection < 0 || selection > 4)
        selection = 0;
    
    urlString = pickerURL[selection];
    
    
    url = [NSURL URLWithString: [ urlString stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding]];
    
    
    parser = [[NSXMLParser alloc] initWithContentsOfURL:url];
    
    
    [self.tableView setTableHeaderView:self.searchDisplayController.searchBar];
    
    
    self.searchResult = [[NSMutableArray alloc]init];
    
    
    [parser setDelegate:self];
    [parser setShouldResolveExternalEntities:NO];
    
    
    [parser parse];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    Reachability *networkReachability = [Reachability reachabilityForInternetConnection];
    NetworkStatus networkStatus = [networkReachability currentReachabilityStatus];
    
    self.screenName = @"Podcasts";
    
    //Display an activity indicator while loading the RSS feed
    self.indicator.center = CGPointMake(self.view.center.x, self.view.center.y-64);
    [self.view addSubview:self.indicator];
    
    if(networkStatus != NotReachable){
        [self.indicator startAnimating];
        [self performSelector:@selector(loadPodcastData)withObject:nil afterDelay:0];
    }
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

-(NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskAllButUpsideDown;
}

-(BOOL)shouldAutorotate
{
    return YES;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if(tableView == self.searchDisplayController.searchResultsTableView)
    {
        return [self.searchResult count];
    }
    
        return [feeds count];
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell;
    
    cell = [self.tableView dequeueReusableCellWithIdentifier:@"Cell"];
    
    if(cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"Cell"];
    
    }
    
    if(tableView == self.searchDisplayController.searchResultsTableView) {
        cell.textLabel.text = [[self.searchResult objectAtIndex:indexPath.row] objectForKey:@"title"];
        cell.detailTextLabel.text = [[self.searchResult objectAtIndex:indexPath.row] objectForKey:@"itunes:author"];
    }
    else{
        cell.textLabel.text = [[feeds objectAtIndex:indexPath.row] objectForKey:@"title"];
        cell.detailTextLabel.text = [[feeds objectAtIndex:indexPath.row]objectForKey:@"itunes:author"];
    }
    
    return cell;
}


#pragma mark - search

-(void)filterContentForSearchText:(NSString*) searchText scope:(NSString *) scope {
    NSPredicate *predicate;
    
    [self.searchResult removeAllObjects];
    
    predicate = [NSPredicate predicateWithFormat:@"SELF.title contains[c] %@ OR SELF.author contains [c] %@", searchText, searchText];
    assert(predicate);
    
    self.searchResult = [[feeds filteredArrayUsingPredicate:predicate] mutableCopy];
    assert(self.searchResult);
    
    [self.tableView reloadData];
    
}

-(BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString{
    [self filterContentForSearchText:searchString scope: [[self.searchDisplayController.searchBar scopeButtonTitles] objectAtIndex:[self.searchDisplayController.searchBar selectedScopeButtonIndex]]];
    
    return YES;
}




#pragma mark - parser

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict {
    
    element = elementName;
    
    NSLog(@"Starting Podcast parser");
    
    if([element isEqualToString:@"item"]) {
        
        item = [[NSMutableDictionary alloc] init];
        title = [[NSMutableString alloc] init];
        link = [[NSMutableString alloc] init];
        author = [[NSMutableString alloc] init];
    }
    
    if([element isEqualToString:@"enclosure"]) {
        NSString *myUrl = [NSString stringWithString:[attributeDict objectForKey:@"url"]];
        link = (NSMutableString*)myUrl;
    }
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
    
    if ([element isEqualToString:@"title"]) {
        [title appendString:string];
    }else if ([element isEqualToString:@"url"]) {
        [link appendString:string];
    }else if ([element isEqualToString:@"itunes:author"]) {
        [author appendString:string];
    }
}

-(void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
    
    if ([elementName isEqualToString:@"item"]) {
        [item setObject:title forKey:@"title"];
        [item setObject:link forKey:@"link"];
         [item setObject:author forKey:@"itunes:author"];
        
        [feeds addObject:[item copy]];
    }
    
    if([elementName isEqualToString:@"enclosure"]) {
        [item setObject:link forKey:@"url"];
    }
}


-(void)parserDidEndDocument:(NSXMLParser *)parser {
    [self.tableView reloadData];
    [self.indicator stopAnimating];
}



#pragma mark - navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    NSIndexPath *indexPath;
    NSString *string;
    
    if ([[segue identifier] isEqualToString:@"showPodcastDetail"]) {
        if(self.searchDisplayController.active) {
            indexPath = [self.searchDisplayController.searchResultsTableView indexPathForSelectedRow];
            string = [self.searchResult[indexPath.row] objectForKey:@"link"];
        }
        
        else {
            indexPath = [self.tableView indexPathForSelectedRow];
            string = [feeds[indexPath.row] objectForKey: @"link"];
        }
    }
    
    [[segue destinationViewController] setUrl:string];
}






@end
