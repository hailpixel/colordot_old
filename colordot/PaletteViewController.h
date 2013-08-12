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
#import "PaletteView.h"

@class UISwatchListViewController, UIColorPickerViewController, UISwatchListView;

@interface PaletteViewController : UIViewController <UISwatchListDataSource, UISwatchListDelegate, UIColorPickerDelegate> {
    BOOL isPickerOpen;
}

// Controllers
@property (nonatomic, strong) UIColorPickerViewController *pickerViewController;

// Views
@property (nonatomic, strong) PaletteView *paletteView;
@property (nonatomic, strong) UISwatchListView *swatchListView;

// Data
@property (nonatomic, strong) NSMutableArray *colors;
@property (nonatomic, strong) PaletteObject *palette;

- (void)addColor:(UIColor *)color;

@end
