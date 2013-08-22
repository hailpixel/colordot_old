//
//  SwatchDetailViewController.m
//  colordot
//
//  Created by Devin Hunt on 8/19/13.
//  Copyright (c) 2013 Devin Hunt. All rights reserved.
//

#import "SwatchDetailViewController.h"

@interface SwatchDetailViewController ()

@end

@implementation SwatchDetailViewController
@synthesize color = _color;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.hsbPicker.dataSource = self;
    self.hsbPicker.delegate = self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setColor:(ColorObject *)color {
    _color = color;
    
    CGFloat r, g, b, hue, sat, bri, alpha;
    NSInteger rInt, gInt, bInt, hueInt, satInt, briInt;
    UIColor *uiColor = [color uiColor];
    
    [uiColor getHue:&hue saturation:&sat brightness:&bri alpha:&alpha];
    [uiColor getRed:&r green:&g blue:&b alpha:&alpha];
    
    rInt = r * 255; gInt = g * 255; bInt = b * 255;
    hueInt = hue * 360; satInt = sat * 100; briInt = bri * 100;
    
    self.hexLabel.text = [NSString stringWithFormat:@"#%.2X%.2X%.2X", rInt, gInt, bInt];
    
    self.rValue.text = [NSString stringWithFormat:@"%i", rInt];
    self.gValue.text = [NSString stringWithFormat:@"%i", gInt];
    self.bValue.text = [NSString stringWithFormat:@"%i", bInt];
    
    self.hValue.text = [NSString stringWithFormat:@"%i", hueInt];
    self.sValue.text = [NSString stringWithFormat:@"%i", satInt];
    self.lValue.text = [NSString stringWithFormat:@"%i", briInt];
    
    [self.hsbPicker selectRow:hueInt inComponent:0 animated:NO];
    [self.hsbPicker selectRow:satInt inComponent:1 animated:NO];
    [self.hsbPicker selectRow:briInt inComponent:2 animated:NO];
}

#pragma mark Picker datasource methods
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 3;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if(component == 0) {
        return 361;
    }
    return 101;
}

#pragma mark Picker delegate method
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return [NSString stringWithFormat:@"%i", row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    
}


@end
