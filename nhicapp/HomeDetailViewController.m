//
//  HomeDetailViewController.m
//  nhicapp
//
//  Created by Mark John Merin on 10/13/14.
//  Copyright (c) 2014 Apps4Christ. All rights reserved.
//

#import "HomeDetailViewController.h"

@interface HomeDetailViewController ()

@end

@implementation HomeDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSString *website;
    NSURL *myUrl;
    
    website = self.url;
    website = [website stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    website = [website stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSLog(@"website url is: %@", website);
    
    myUrl = [NSURL URLWithString:website];
    
    NSLog(@"detail view link is: %@", myUrl);
    
    NSURLRequest *request = [NSURLRequest requestWithURL:myUrl];
    
    [self.webView loadRequest:request];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
