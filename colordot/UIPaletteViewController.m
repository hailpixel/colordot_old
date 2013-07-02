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
    
    [self.view addSubview:[pickerViewController view]];
    isPickerOpen = YES;

    swatchListView = [[UISwatchListView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, appFrame.size.width, 0.0f)];
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
    
    UIView *pickerView = [pickerViewController view];
    pickerView.frame = self.view.bounds;
    
    [self fetchRecords];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)respondToPaletteSwipe:(UISwipeGestureRecognizer *) sender {
    NSLog(@"Yaaa");
    if(! isPickerOpen) {
        CGRect bounds = self.view.bounds;
        [pickerViewController view].frame = CGRectMake(0.0f, bounds.size.height, bounds.size.width, 0.0f);
        [self.view addSubview:[pickerViewController view]];
        
        ColorPickerView *pickerView = (ColorPickerView *)[pickerViewController view];
        [pickerView setColor:[UIColor blackColor]];
        
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
    
    NSUInteger sections = [colors count];
    
    if(sections > 0) {
        CGFloat itemHeight = bounds.size.height / sections;
        
        paletteRect = CGRectMake(0.0f, 0.0f, bounds.size.width, itemHeight * [colors count]);
        [swatchListView updateLayoutToFrame:paletteRect];
    }
}


#pragma mark UISwatchListDataSource methods
- (NSUInteger)numberOfSwatches {
    return [colors count];
}

- (UISwatch *)swatchForListRow:(NSUInteger)row {
    UIColor *color = [colors objectAtIndex:row];
    UISwatch *swatch = [[UISwatch alloc] initWithColor:color];
    return swatch;
}

#pragma mark UIColorPickerDelegate methods
- (void)colorPicked:(UIColor *)color {
    [self addColor:color];
    
    UISwatch *newSwatch = [[UISwatch alloc] initWithColor:color];
    newSwatch.frame = [pickerViewController view].frame;
    newSwatch.layer.zPosition = 10;
    
    [swatchListView addSubview:newSwatch];
    swatchListView.frame = self.view.bounds;
    
    [self layoutViews];
    
    [[pickerViewController view] removeFromSuperview];
    isPickerOpen = NO;
}

#pragma mark Data management
- (void)fetchRecords {
    colors = [[NSMutableArray alloc] init];
}

- (void)addColor:(UIColor *)color {
    [colors addObject:color];
}

@end
