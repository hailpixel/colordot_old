//
//  PaletteViewController.m
//  colordot
//
//  Created by Devin Hunt on 6/14/13.
//  Copyright (c) 2013 Devin Hunt. All rights reserved.
//

#import "UIPaletteViewController.h"
#import "UIPaletteView.h"
#import "UIColorSwatch.h"
#import "UIColorPickerView.h"

@implementation UIPaletteViewController {
    UIColor *lastPickedColor;
}
@synthesize colors, paletteView, pickerView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        lastPickedColor = [UIColor colorWithHue:0.0f saturation:0.5f brightness:0.0f alpha:1.0f];
        colors = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)loadView {
    CGRect appFrame = [[UIScreen mainScreen] applicationFrame];
    UIView *contentView = [[UIView alloc] initWithFrame:appFrame];
    self.view = contentView;
    
    paletteView = [[UIPaletteView alloc] init];
    paletteView.dataSource = self;
    [self.view addSubview:paletteView];
    
    pickerView = [[UIColorPickerView alloc] init];
    [self.view addSubview:pickerView];
    
    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handlePickerTap:)];
    tapRecognizer.numberOfTapsRequired = 1;
    [pickerView addGestureRecognizer:tapRecognizer];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self layoutView];
    [paletteView reloadData];
}

- (void)layoutView {
    CGRect bounds = [self.view bounds];
    NSInteger totalColors = [colors count];
    
    CGFloat paletteHeight = totalColors * bounds.size.height / (totalColors + 3);
    CGFloat pickerHeight = bounds.size.height - paletteHeight;
    
    paletteView.frame = CGRectMake(0, 0, 320, paletteHeight);
    pickerView.frame = CGRectMake(0, paletteHeight, bounds.size.width, pickerHeight);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

# pragma mark - Touch handling
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesMoved:touches withEvent:event];
    
    NSSet *pickerTouches = [event touchesForView:pickerView];
    UITouch *pickerTouch = [pickerTouches anyObject];
    
    if(pickerTouch) {
        CGPoint touchLocation = [pickerTouch locationInView:pickerView];
        
        CGFloat hue = touchLocation.x / pickerView.bounds.size.width;
        CGFloat brightness = touchLocation.y / pickerView.bounds.size.height;
        
        lastPickedColor = [UIColor colorWithHue:hue saturation:0.5f brightness:brightness alpha:1.0f];
        [pickerView setColor:lastPickedColor];
    }
}

- (void)handlePickerTap:(UITapGestureRecognizer *)sender {
    if(sender.state == UIGestureRecognizerStateEnded) {
        UIColor *newColor = [lastPickedColor copy];
        [colors addObject:newColor];
        
        // TODO: Ugh.. this screams bad MVC..
        [self layoutView];
        [paletteView reloadData];
    }
}

# pragma mark - Palette data source methods
- (NSInteger)numberOfSwatchesInPaletteView:(UIPaletteView *)paletteView {
    return [colors count];
}

- (UIColorSwatch *)paletteView:(UIPaletteView *)paletteView swatchForRow:(NSInteger) row {
    UIColor *color = [colors objectAtIndex:row];
    UIColorSwatch *swatch = [[UIColorSwatch alloc] init];
    swatch.color = color;
    
    return swatch;
}

@end
