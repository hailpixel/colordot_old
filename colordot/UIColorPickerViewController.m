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
        // Custom initialization
    }
    return self;
}

- (void)loadView {
    pickerView = [[ColorPickerView alloc] init];
    self.view = pickerView;
    
    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(respondToTap:)];
    tapRecognizer.numberOfTapsRequired = 1;
    [self.view addGestureRecognizer:tapRecognizer];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark Interaction for color picker
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesMoved:touches withEvent:event];
    
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInView:self.view];
    CGRect bounds = self.view.bounds;
    CGFloat hue, brightness;
    
    hue = location.x / bounds.size.width;
    brightness = location.y / bounds.size.height;
    
    lastPickedColor = [UIColor colorWithHue:hue saturation:0.5 brightness:brightness alpha:1.0f];
    [pickerView setColor:lastPickedColor];
}

- (void)respondToTap:(UITapGestureRecognizer *) sender {
    [delegate colorPicked:lastPickedColor];
}

@end
