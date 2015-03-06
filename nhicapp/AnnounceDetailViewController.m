//
//  AnnounceDetailViewController.m
//  nhicapp
//
//  Created by Mark John Merin on 10/9/14.
//  Copyright (c) 2014 Apps4Christ. All rights reserved.
//

#import "AnnounceDetailViewController.h"
#import "TFHpple.h"

@interface AnnounceDetailViewController ()

@end

@implementation AnnounceDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self loadContent];
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

-(void)loadContent
{
    NSString *website;
    NSURL *url;
    NSString *announceBody = @"";
    NSString *announceTitle =@"";
    NSUInteger length;
    
    website = self.url;
    website = [website stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    website = [website stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSLog(@"website url is: %@", website);
    
    url = [NSURL URLWithString:website];
    
    announceTitle = [self parseHtml:url for:@"//h1"];
    announceBody = [self parseHtml:url for:@"//p"];
    
    NSLog(@"Title %@", announceTitle);
    
    length = [announceTitle length];
    
    if(length <= 35)
        self.labelView.numberOfLines = 1;
    else {
        NSLog(@"length is: %d", length);
    
    self.labelView.numberOfLines = length % 22;
    }
    
     NSLog(@"num lines is: %d", self.labelView.numberOfLines);
    
    self.labelView.text = announceTitle;
    self.textView.text = announceBody;
    
}

-(NSString*)parseHtml:(NSURL *)url for:(NSString*) queryString
{
    NSString *string = @"";
   
    //Returns a data object containing the data from the location specified by a given URL.
    NSData *htmlData = [NSData dataWithContentsOfURL:url];
    
    //Gives the Hpple parser the NSData file which contains the HTML data
    TFHpple *htmlParser = [TFHpple hppleWithHTMLData:htmlData];
    
    if (htmlData)   //check that htmlData contains data
    {
        //Enter your Xpath query here to obtain the data you want from the webpage
        //more info on Xpath queries can be found at http://www.w3schools.com/xpath/default.asp
        NSString *xPathQueryString = queryString;   //searching for all h2 in document
        
        //Creates an array to hold the data obtained from the Xpath query
        NSArray *infoNodes = [htmlParser searchWithXPathQuery:xPathQueryString];
        
        for(TFHppleElement *element in infoNodes){
            NSString *info;
            
            info = [[element firstChild] content];
            
            string = [string stringByAppendingString:info];
            string = [string stringByAppendingString:@"\r\n\r\n"];

        }
        
        
    }else{
        //Display an error if htmlData is not available. I.E no internet connection etc
            string= @"Error - No data";
    }
    
    return string;
    
}


@end
