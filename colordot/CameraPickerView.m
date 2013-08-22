//
//  CameraPickerView.m
//  colordot
//
//  Created by Devin Hunt on 8/22/13.
//  Copyright (c) 2013 Devin Hunt. All rights reserved.
//

#import "CameraPickerView.h"

@implementation CameraPickerView
@synthesize previewLayer = _previewLayer, color = _color;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _color = [UIColor blackColor];
    }
    return self;
}

- (void)setPreviewLayer:(AVCaptureVideoPreviewLayer *)previewLayer {
    if(self.previewLayer) {
        [self.previewLayer removeFromSuperlayer];
    }
    
    _previewLayer = previewLayer;
    
    if(self.previewLayer) {
        self.previewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
        self.previewLayer.frame = self.bounds;
        [self.layer addSublayer:self.previewLayer];
        
        CAShapeLayer *mask = [CAShapeLayer layer];
        
        mask.frame = self.bounds;
        mask.path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake((mask.frame.size.width / 2.0f) - kCameraPickerViewHoleRadius,
                                                                      (mask.frame.size.height / 2.0f) - kCameraPickerViewHoleRadius,
                                                                      kCameraPickerViewHoleRadius * 2.0f,
                                                                      kCameraPickerViewHoleRadius * 2.0f)].CGPath;
        mask.fillColor = [UIColor whiteColor].CGColor;
        self.previewLayer.mask = mask;
    }
}

- (void)setColor:(UIColor *)color {
    _color = color;
}


- (void)drawRect:(CGRect)rect
{

}

@end
