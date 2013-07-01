//
//  UIColorPickerViewController.h
//  colordot
//
//  Created by Devin Hunt on 6/28/13.
//  Copyright (c) 2013 Devin Hunt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIColorPickerDelegate.h"
@class ColorPickerView;

@interface UIColorPickerViewController : UIViewController {
    UIColor *lastPickedColor;
    ColorPickerView *pickerView;
    __weak id <UIColorPickerDelegate> delegate;
}

@property (nonatomic, weak) id <UIColorPickerDelegate> delegate;

@end
