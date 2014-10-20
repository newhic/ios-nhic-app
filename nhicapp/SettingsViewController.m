//
//  SettingsViewController.m
//  nhicapp
//
//  Created by Mark John Merin on 10/19/14.
//  Copyright (c) 2014 Apps4Christ. All rights reserved.
//

#import "SettingsViewController.h"

@interface SettingsViewController () {
    NSArray *pickerData;

}

@end

@implementation SettingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    // Do any additional setup after loading the view.
    NSInteger row;
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    row = [defaults integerForKey:@"selection"];
    
    pickerData = @[@"English", @"ไทย", @"中文", @"日本語", @"Deutsche" ];
    

    
    self.picker.dataSource = self;
    self.picker.delegate = self;
    
    [self.picker selectRow:row inComponent:(NSInteger)0 animated:NO];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// The number of columns of data
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

// The number of rows of data
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return pickerData.count;
}

// The data to return for the row and component (column) that's being passed in
- (NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    
    return pickerData[row];
}


// Catpure the picker view selection
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    // This method is triggered whenever the user makes a change to the picker selection.
    // The parameter named row and component represents what was selected.
    
    NSUserDefaults *defaults;
    int selection;
    
    defaults = [NSUserDefaults standardUserDefaults];
    
    selection = (int) row;
    
    [defaults setInteger: selection forKey:@"selection"];
    [defaults synchronize];
    
    NSLog(@"Selected item %d", (int)row);
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
