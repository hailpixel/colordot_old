//
//  CameraPickerView.h
//  colordot
//
//  Created by Devin Hunt on 8/22/13.
//  Copyright (c) 2013 Devin Hunt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

#define kCameraPickerViewHoleRadius 120.0f

@interface CameraPickerView : UIView

@property (nonatomic, strong) AVCaptureVideoPreviewLayer *previewLayer;
@property (nonatomic, strong) UIColor *color;

@end
