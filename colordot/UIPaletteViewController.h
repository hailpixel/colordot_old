//
//  UIPaletteViewController.h
//  colordot
//
//  Created by Devin Hunt on 6/28/13.
//  Copyright (c) 2013 Devin Hunt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UISwatchListDataSource.h"
#import "UIColorPickerDelegate.h"
@class UISwatchListViewController, UIColorPickerViewController, UISwatchListView;

@interface UIPaletteViewController : UIViewController <UISwatchListDataSource, UIColorPickerDelegate> {
    UIColorPickerViewController *pickerViewController;
    UISwatchListView *swatchListView;
    
    NSMutableArray *colors;
}

- (void)layoutViews;

- (void)fetchRecords;
- (void)addColor:(UIColor *)color;

@end
