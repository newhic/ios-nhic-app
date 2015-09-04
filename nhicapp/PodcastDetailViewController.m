//
//  PodcastDetailViewController.m
//  nhicapp
//
//  Created by Mark John Merin on 10/10/14.
//  Copyright (c) 2014 Apps4Christ. All rights reserved.
//

#import <AVFoundation/AVFoundation.h>
#import "PodcastDetailViewController.h"

@interface PodcastDetailViewController ()

@end

@implementation PodcastDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Start session with playback category to ensure audio plays in the background
    AVAudioSession *audioSession = [AVAudioSession sharedInstance];
    BOOL ok;
    NSError *setCategoryError = nil;
    ok = [audioSession setCategory:AVAudioSessionCategoryPlayback
                             error:&setCategoryError];
    if (!ok) {
        NSLog(@"%s setCategoryError=%@", __PRETTY_FUNCTION__, setCategoryError);
    }
    
    NSString *website;
    NSURL *myUrl;
    
    website = self.url;
    website = [website stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    website = [website stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    myUrl = [NSURL URLWithString:website];
    
    // Load up the webview
    self.webView.mediaPlaybackRequiresUserAction = NO;
    self.webView.allowsInlineMediaPlayback = YES;
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL: [NSURL URLWithString: website]];
    [self.webView loadRequest: request];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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


@end
