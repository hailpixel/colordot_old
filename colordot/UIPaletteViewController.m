//
//  UIPaletteViewController.m
//  colordot
//
//  Created by Devin Hunt on 6/28/13.
//  Copyright (c) 2013 Devin Hunt. All rights reserved.
//

#import "UIPaletteViewController.h"
#import "UISwatchListViewController.h"
#import "UIColorPickerViewController.h"
#import "UISwatchListView.h"
#import "UISwatch.h"
#import "ColorPickerView.h"
#import "QuartzCore/QuartzCore.h"
#import "ColorObject.h"

@implementation UIPaletteViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        pickerViewController = [[UIColorPickerViewController alloc] init];
        pickerViewController.delegate = (UIViewController <UIColorPickerDelegate> *) self;
    }
    return self;
}

- (void)loadView {
    CGRect appFrame = [[UIScreen mainScreen] bounds];
    UIView *container = [[UIView alloc] initWithFrame:appFrame];
    
    self.view = container;
    container.backgroundColor = [UIColor redColor];

    swatchListView = [[UISwatchListView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, appFrame.size.width, appFrame.size.height)];
    swatchListView.dataSource = (UIViewController <UISwatchListDataSource> *) self;
    [self.view addSubview:swatchListView];
    
    // Gesture for opening the picker again
    UISwipeGestureRecognizer *swipeRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(respondToPaletteSwipe:)];
    swipeRecognizer.numberOfTouchesRequired = 1;
    swipeRecognizer.direction = UISwipeGestureRecognizerDirectionUp;
    
    [swatchListView addGestureRecognizer:swipeRecognizer];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.colors = [[self.palette colorsArray] mutableCopy];
    
    [swatchListView reloadSwatches];
}

- (void)viewWillAppear:(BOOL)animated {
    [self layoutViews];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)respondToPaletteSwipe:(UISwipeGestureRecognizer *) sender {
    if(! isPickerOpen) {
        CGRect bounds = self.view.bounds;
        [pickerViewController view].frame = CGRectMake(0.0f, bounds.size.height, bounds.size.width, 0.0f);
        [self.view addSubview:[pickerViewController view]];
        
        [pickerViewController.pickerView setColor:[UIColor blackColor]];
        
        [UIView animateWithDuration:0.3f animations:^{
            [pickerViewController view].frame = CGRectMake(0.0f, bounds.size.height - 320.0f, bounds.size.width, 320.0f);
        }];
        
        swatchListView.frame = CGRectMake(0.0f, 0.0f, bounds.size.width, bounds.size.height - 320.0f);
        [self layoutViews];
    }
}

#pragma mark View layout
- (void)layoutViews {
    CGRect paletteRect, bounds = swatchListView.bounds;
    
    NSUInteger sections = [self.colors count];
    
    if(sections > 0) {
        CGFloat itemHeight = bounds.size.height / sections;
        
        paletteRect = CGRectMake(0.0f, 0.0f, bounds.size.width, itemHeight * [self.colors count]);
        [swatchListView updateLayoutToFrame:paletteRect];
    }
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
    newSwatch.frame = [pickerViewController view].frame;
    newSwatch.representedRow = [self.palette.colors count] - 1;
    newSwatch.delegate = self;
    [swatchListView addSubview:newSwatch];
    swatchListView.frame = self.view.bounds;
    
    [self layoutViews];
    
    [[pickerViewController view] removeFromSuperview];
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
    UISwatch *swatchToRemove = [swatchListView swatchAtRow:row];
    [swatchToRemove removeFromSuperview];
    [swatchListView updateSwatches];
    [self layoutViews];
}


@end
