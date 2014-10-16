//
//  PodcastDetailViewController.h
//  nhicapp
//
//  Created by Mark John Merin on 10/10/14.
//  Copyright (c) 2014 Apps4Christ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PodcastDetailViewController : UIViewController
@property (copy, nonatomic) NSString *url;

@property (strong, nonatomic) IBOutlet UIWebView *webView;

@end
