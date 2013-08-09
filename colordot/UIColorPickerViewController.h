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

typedef enum {
    UIColorPickerTypeFinger,
    UIColorPickerTypeCamera
} UIColorPickerModes;

@interface UIColorPickerViewController : UIViewController {
    CGFloat _lastHue;
    CGFloat _lastBrightness;
    CGFloat _lastSaturation;
    CGFloat _saturationOnPinchStart;
    UIColor *lastPickedColor;
}
@property (nonatomic, strong) ColorPickerView *pickerView;
@property (nonatomic, strong) UIView *cameraView;
@property (nonatomic, weak) id <UIColorPickerDelegate> delegate;
@property UIColorPickerModes pickerMode;

@end
