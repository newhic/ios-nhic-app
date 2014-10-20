//
//  SettingsViewController.h
//  nhicapp
//
//  Created by Mark John Merin on 10/19/14.
//  Copyright (c) 2014 Apps4Christ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SettingsViewController : UIViewController <UIPickerViewDataSource, UIPickerViewDelegate>
@property (weak, nonatomic) IBOutlet UIPickerView *picker;


@end
