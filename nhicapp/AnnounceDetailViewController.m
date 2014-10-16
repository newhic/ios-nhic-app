//
//  AnnounceDetailViewController.m
//  nhicapp
//
//  Created by Mark John Merin on 10/9/14.
//  Copyright (c) 2014 Apps4Christ. All rights reserved.
//

#import "AnnounceDetailViewController.h"

@interface AnnounceDetailViewController ()

@end

@implementation AnnounceDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSString *website;
    NSURL *myURL;
    
    website = self.url;
    website = [website stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    website = [website stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSLog(@"website url is: %@", website);
    
    myURL = [NSURL URLWithString:website];
    
    NSLog(@"detail view link is: %@", myURL);
    
    NSURLRequest *request = [NSURLRequest requestWithURL:myURL];
    
    [self.webView loadRequest:request];
}


@end
