//
//  UIPaletteViewController.m
//  colordot
//
//  Created by Devin Hunt on 6/28/13.
//  Copyright (c) 2013 Devin Hunt. All rights reserved.
//

#import "PaletteViewController.h"
#import "UIColorPickerViewController.h"
#import "UISwatchListView.h"
#import "UISwatch.h"
#import "ColorPickerView.h"
#import "QuartzCore/QuartzCore.h"
#import "ColorObject.h"

@implementation PaletteViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.pickerViewController = [[UIColorPickerViewController alloc] init];
        self.pickerViewController.delegate = (UIViewController <UIColorPickerDelegate> *) self;
        [self addChildViewController:self.pickerViewController];
    }
    return self;
}

- (void)loadView {
    CGRect appFrame = [[UIScreen mainScreen] bounds];
    self.paletteView = [[PaletteView alloc] initWithFrame:appFrame];
    self.view = self.paletteView;

    self.swatchListView = [[UISwatchListView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, appFrame.size.width, appFrame.size.height)];
    self.swatchListView.dataSource = (UIViewController <UISwatchListDataSource> *) self;
    self.paletteView.mainView = self.swatchListView;
    self.paletteView.bottomView = self.pickerViewController.view;
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

- (void)setPalette:(PaletteObject *)palette {
    _palette = palette;
    
    self.colors = [[self.palette colorsArray] mutableCopy];
    [self.swatchListView reloadSwatches];
}

#pragma mark UISwatchListDataSource methods
- (NSUInteger)numberOfSwatches {
    return [self.colors count];
}

- (UISwatch *)swatchForListRow:(NSUInteger)row {
    ColorObject *color = [self.colors objectAtIndex:row];
    UISwatch *swatch = [[UISwatch alloc] initWithColor:[color uiColor]];
    return swatch;
}

#pragma mark UIColorPickerDelegate methods
- (void)colorPicked:(UIColor *)color {
    [self addColor:color];
    
    // TODO: .. should we adding it to the view here..?
    UISwatch *newSwatch = [[UISwatch alloc] initWithColor:color];
    newSwatch.frame = [self.pickerViewController view].frame;
    newSwatch.representedRow = [self.palette.colors count] - 1;
    newSwatch.delegate = self;
    [self.swatchListView addSubview:newSwatch];
    self.swatchListView.frame = self.view.bounds;
    
    [[self.pickerViewController view] removeFromSuperview];
    isPickerOpen = NO;
}

#pragma mark Data management
- (void)addColor:(UIColor *)color {
    
    ColorObject *newColor = (ColorObject *) [NSEntityDescription insertNewObjectForEntityForName:@"Color" inManagedObjectContext:self.palette.managedObjectContext];
    
    CGFloat h, s, b, a;
    [color getHue:&h saturation:&s brightness:&b alpha:&a];

    newColor.palette = self.palette;
    newColor.order = [NSNumber numberWithInt:[self.colors count]];
    newColor.hue = [NSNumber numberWithFloat:h];
    newColor.saturation = [NSNumber numberWithFloat:s];
    newColor.brightness = [NSNumber numberWithFloat:b];

    NSError *error;
    if(! [self.palette.managedObjectContext save:&error]) {
        NSLog(@"Problem saving new color in palette view");
    }
    
    [self.colors addObject:newColor];
}

#pragma mark UISwatchListDelegate methods

- (void)swatchListView:(ColorPickerView *)listView swatchEditedAtRow:(NSUInteger)row {
    
}

- (void)swatchListView:(ColorPickerView *)listView swatchRemovedAtRow:(NSUInteger)row {
    UISwatch *swatchToRemove = [self.swatchListView swatchAtRow:row];
    [swatchToRemove removeFromSuperview];
    [self.swatchListView updateSwatches];
}


@end
