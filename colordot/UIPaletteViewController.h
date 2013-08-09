//
//  UIPaletteViewController.h
//  colordot
//
//  Created by Devin Hunt on 6/28/13.
//  Copyright (c) 2013 Devin Hunt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UISwatchListDataSource.h"
#import "UISwatchListDelegate.h"
#import "UIColorPickerDelegate.h"
#import "PaletteObject.h"

@class UISwatchListViewController, UIColorPickerViewController, UISwatchListView;

@interface UIPaletteViewController : UIViewController <UISwatchListDataSource, UISwatchListDelegate, UIColorPickerDelegate> {
    UIColorPickerViewController *pickerViewController;
    UISwatchListView *swatchListView;
    BOOL isPickerOpen;
}

@property (nonatomic, strong) PaletteObject *palette;
@property (nonatomic, strong) NSMutableArray *colors;

- (void)layoutViews;
- (void)respondToPaletteSwipe:(UISwipeGestureRecognizer *) sender;

- (void)addColor:(UIColor *)color;

@end
