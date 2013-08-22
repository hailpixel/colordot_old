//
//  UIColorPickerViewController.h
//  colordot
//
//  Created by Devin Hunt on 6/28/13.
//  Copyright (c) 2013 Devin Hunt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SlidingView.h"
@class ColorPickerView;

typedef enum {
    UIColorPickerTypeFinger,
    UIColorPickerTypeCamera
} UIColorPickerModes;

@protocol PickerDelegate <NSObject>

- (void)colorPicked: (UIColor *)color;

@end

@interface PickerViewController : UIViewController <UIGestureRecognizerDelegate> {
    CGFloat _lastHue;
    CGFloat _lastBrightness;
    CGFloat _lastSaturation;
    CGFloat _saturationOnPinchStart;
    UIColor *lastPickedColor;
}
@property (nonatomic, strong) SlidingView *mainView;
@property (nonatomic, strong) ColorPickerView *pickerView;
@property (nonatomic, strong) UIView *cameraView;
@property (nonatomic, strong) UIButton *cameraButton, *fingerButton;
@property (nonatomic, weak) id <PickerDelegate> delegate;
@property UIColorPickerModes pickerMode;

@end
