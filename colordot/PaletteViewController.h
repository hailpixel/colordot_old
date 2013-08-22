//
//  UIPaletteViewController.h
//  colordot
//
//  Created by Devin Hunt on 6/28/13.
//  Copyright (c) 2013 Devin Hunt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PaletteObject.h"
#import "PaletteView.h"
#import "SwatchListViewController.h"
#import "PickerViewController.h"

@interface PaletteViewController : UIViewController {
    BOOL isPickerOpen;
}

// Controllers
@property (nonatomic, strong) SwatchListViewController *swatchListViewController;
@property (nonatomic, strong) PickerViewController *pickerViewController;

// View
@property (nonatomic, strong) PaletteView *paletteView;

// Data
@property (nonatomic, strong) PaletteObject *palette;

@end
