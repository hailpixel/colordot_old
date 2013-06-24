//
//  PaletteViewController.h
//  colordot
//
//  Created by Devin Hunt on 6/14/13.
//  Copyright (c) 2013 Devin Hunt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIPaletteViewDataSource.h"
@class UIColorPickerView, UIPaletteView;

@interface UIPaletteViewController : UIViewController <UIPaletteViewDataSource>

@property (nonatomic, strong) NSMutableArray *colors;
@property (nonatomic, strong) UIPaletteView *paletteView;
@property (nonatomic, strong) UIColorPickerView *pickerView;

- (void)layoutView;
- (void)handlePickerTap:(UITapGestureRecognizer *)sender;

@end
