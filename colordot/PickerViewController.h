//
//  UIColorPickerViewController.h
//  colordot
//
//  Created by Devin Hunt on 6/28/13.
//  Copyright (c) 2013 Devin Hunt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import "SlidingView.h"
#import "CameraPickerView.h"
#import "ColorPickerView.h"

typedef enum {
    UIColorPickerTypeFinger,
    UIColorPickerTypeCamera
} UIColorPickerModes;

@protocol PickerDelegate <NSObject>

- (void)colorPicked: (UIColor *)color;

@end

@interface PickerViewController : UIViewController <UIGestureRecognizerDelegate, AVCaptureVideoDataOutputSampleBufferDelegate> {
    CGFloat _lastHue;
    CGFloat _lastBrightness;
    CGFloat _lastSaturation;
    CGFloat _saturationOnPinchStart;
    UIColor *lastPickedColor;
    
    AVCaptureVideoPreviewLayer *previewLayer;
}
@property (nonatomic, strong) SlidingView *mainView;
@property (nonatomic, strong) ColorPickerView *pickerView;
@property (nonatomic, strong) CameraPickerView *cameraView;
@property (nonatomic, strong) UIButton *cameraButton, *fingerButton;
@property (nonatomic, weak) id <PickerDelegate> delegate;
@property UIColorPickerModes pickerMode;

@end
