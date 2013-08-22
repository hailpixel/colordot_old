//
//  UIColorPickerViewController.m
//  colordot
//
//  Created by Devin Hunt on 6/28/13.
//  Copyright (c) 2013 Devin Hunt. All rights reserved.
//

#import "PickerViewController.h"
#import "ColorPickerView.h"


@implementation PickerViewController
@synthesize delegate;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.pickerMode = UIColorPickerTypeCamera;
        
        _lastHue = 0.5f;
        _lastSaturation = 0.5f;
        _lastBrightness = 0.5f;
    }
    return self;
}

- (void)loadView {
    CGRect appFrame = [[UIScreen mainScreen] bounds];
    
    self.mainView = [[SlidingView alloc] initWithFrame:appFrame];
    self.mainView.autoresizesSubviews = YES;
    self.view = self.mainView;
    
    self.pickerView = [[ColorPickerView alloc] initWithFrame:appFrame];
    self.pickerView.autoresizingMask = (UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight);
    self.mainView.centerView = self.pickerView;
    
    UIPanGestureRecognizer *panRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(respondToPan:)];
    panRecognizer.delegate = self;
    panRecognizer.maximumNumberOfTouches = 1;
    panRecognizer.minimumNumberOfTouches = 1;
    [self.pickerView addGestureRecognizer:panRecognizer];
    
    UIPinchGestureRecognizer *pinchRecognizer = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(respondToPinch:)];
    [self.pickerView addGestureRecognizer:pinchRecognizer];
    
    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(respondToTap:)];
    tapRecognizer.numberOfTapsRequired = 1;
    tapRecognizer.delegate = self;
    [self.pickerView addGestureRecognizer:tapRecognizer];
    
    self.cameraView = [[UIView alloc] initWithFrame:appFrame];
    self.cameraView.backgroundColor = [UIColor redColor];
    self.mainView.rightView = self.cameraView;
    
    self.cameraButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    self.cameraButton.frame = CGRectMake(self.pickerView.bounds.size.width - 46.0f, (self.pickerView.bounds.size.width / 2.0f) - 15.0f, 30.0f, 30.0f);
    self.cameraButton.titleLabel.text = @"C";
    [self.cameraButton addTarget:self action:@selector(onCameraButtonTap) forControlEvents:UIControlEventTouchUpInside];
    [self.pickerView addSubview:self.cameraButton];
    
    self.fingerButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    self.fingerButton.frame = CGRectMake(16.0f, (self.cameraView.bounds.size.width / 2.0f) - 15.0f, 30.0f, 30.0f);
    self.fingerButton.titleLabel.text = @"F";
    [self.fingerButton addTarget:self action:@selector(onFingerButtonTap) forControlEvents:UIControlEventTouchUpInside];
    [self.cameraView addSubview:self.fingerButton];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    lastPickedColor = [UIColor colorWithHue:_lastHue saturation:_lastSaturation brightness:_lastBrightness alpha:1.0f];
    [self.pickerView setColor:lastPickedColor];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark Interaction for Finger Mode color picker

- (void)respondToPan:(UIPanGestureRecognizer *)sender {
    CGPoint location = [sender locationInView:self.view];
    CGRect bounds = self.view.bounds;
    
    _lastHue = location.x / bounds.size.width;
    _lastBrightness = location.y / bounds.size.height;
    
    lastPickedColor = [UIColor colorWithHue:_lastHue saturation:_lastSaturation brightness:_lastBrightness alpha:1.0f];
    [self.pickerView setColor:lastPickedColor];
}

- (void)respondToTap:(UITapGestureRecognizer *) sender {
    [delegate colorPicked:lastPickedColor];
}

- (void)respondToPinch:(UIPinchGestureRecognizer *)sender {
    _lastSaturation = MIN(1.0f, MAX(0.0f, (log10f([sender scale]) + 0.7f * 0.8f)));
    
    lastPickedColor = [UIColor colorWithHue:_lastHue saturation:_lastSaturation brightness:_lastBrightness alpha:1.0f];
    [self.pickerView setColor:lastPickedColor];
}

#pragma mark Tapping between views
- (void)onCameraButtonTap {
    self.mainView.state = SlidingViewRightOpen;
}

- (void)onFingerButtonTap {
    self.mainView.state = SlidingViewDefault;
}

#pragma mark Gesture delegate methods
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    CGPoint point = [gestureRecognizer locationInView:self.pickerView];
    
    if(CGRectContainsPoint(self.cameraButton.frame, point)) {
        return NO;
    }
    return YES;
}


@end
