//
//  SwatchDetailViewController.h
//  colordot
//
//  Created by Devin Hunt on 8/19/13.
//  Copyright (c) 2013 Devin Hunt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ColorObject.h"

@interface SwatchDetailViewController : UIViewController <UIPickerViewDataSource, UIPickerViewDelegate>

@property (strong, nonatomic) IBOutlet UILabel *hexLabel, *rValue, *gValue, *bValue, *hValue, *sValue, *lValue;
@property (strong, nonatomic) IBOutlet UIPickerView *hsbPicker;

@property (strong, nonatomic) ColorObject *color;

@end
