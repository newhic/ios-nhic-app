//
//  HomeDetailViewController.m
//  nhicapp
//
//  Created by Mark John Merin on 10/13/14.
//  Copyright (c) 2014 Apps4Christ. All rights reserved.
//

#import "HomeDetailViewController.h"
#import "TFHpple.h"
#import "Reachability.h"

@interface HomeDetailViewController ()
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *indicator;

@end

@implementation HomeDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    Reachability *networkReachability = [Reachability reachabilityForInternetConnection];
    NetworkStatus networkStatus = [networkReachability currentReachabilityStatus];
    
    //Display an activity indicator while loading the RSS feed
    self.indicator.center = self.view.center;
    [self.view addSubview:self.indicator];
    self.indicator.hidesWhenStopped = YES;
    
    if(networkStatus != NotReachable){
        [self.indicator startAnimating];
        [self performSelector:@selector(loadContent)withObject:nil afterDelay:0];
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



-(void)loadContent
{
    NSString *website;
    NSURL *url;
    
    website = self.url;
    website = [website stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    website = [website stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSLog(@"website url is: %@", website);
    
    url = [NSURL URLWithString:website];
    
    self.titleText.text =[self getTextAt:url forKey: @"//h1"];
        
    self.textView.text = [self getTextAt:url forKey: @"//p"];
    
    [self.indicator stopAnimating];
}

-(NSString *)getTextAt:(NSURL*)url forKey:(NSString*)key
{
    //Returns a data object containing the data from the location specified by a given URL.
    NSData *htmlData = [NSData dataWithContentsOfURL:url];
    
    NSString *string =@"";

    //Gives the Hpple parser the NSData file which contains the HTML data
    TFHpple *htmlParser = [TFHpple hppleWithHTMLData:htmlData];
    
    if (htmlData)   //check that htmlData contains data
    {
        //Enter your Xpath query here to obtain the data you want from the webpage
        //more info on Xpath queries can be found at http://www.w3schools.com/xpath/default.asp
        NSString *xPathQueryString = key;   //searching for all h2 in document
        
        //Creates an array to hold the data obtained from the Xpath query
        NSArray *infoNodes = [htmlParser searchWithXPathQuery:xPathQueryString];
        
        for(TFHppleElement *element in infoNodes){
            NSString *info;
            
            info = [[element firstChild] content];
            
            string = [string stringByAppendingString:info];
            string = [string stringByAppendingString:@"\r\n\r\n"];
            
            NSLog(@"string is: %@", string);
            
        }
   
    }else{
        //Display an error if htmlData is not available. I.E no internet connection etc
       string = @"Error - No data";
    }
    
    return string;
}


@end
