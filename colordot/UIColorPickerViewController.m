//
//  UIColorPickerViewController.m
//  colordot
//
//  Created by Devin Hunt on 6/28/13.
//  Copyright (c) 2013 Devin Hunt. All rights reserved.
//

#import "UIColorPickerViewController.h"
#import "ColorPickerView.h"


@implementation UIColorPickerViewController
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
    
    UIView *mainView = [[UIView alloc] initWithFrame:appFrame];
    mainView.autoresizesSubviews = YES;
    self.view = mainView;
    
    self.pickerView = [[ColorPickerView alloc] initWithFrame:appFrame];
    self.pickerView.autoresizingMask = (UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight);
    [self.view addSubview:self.pickerView];
    
    UIPanGestureRecognizer *panRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(respondToPan:)];
    panRecognizer.maximumNumberOfTouches = 1;
    panRecognizer.minimumNumberOfTouches = 1;
    [self.pickerView addGestureRecognizer:panRecognizer];
    
    UIPinchGestureRecognizer *pinchRecognizer = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(respondToPinch:)];
    [self.pickerView addGestureRecognizer:pinchRecognizer];
    
    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(respondToTap:)];
    tapRecognizer.numberOfTapsRequired = 1;
    [self.pickerView addGestureRecognizer:tapRecognizer];
    
//    self.cameraView = [[UIView alloc] initWithFrame:appFrame];
//    self.cameraView.backgroundColor = [UIColor greenColor];
//    [self.view addSubview:cameraView];
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

#pragma mark Camera Mode setup and delegate methods

@end
