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
    CGRect appFrame = [[UIScreen mainScreen] applicationFrame];
    UIView *container = [[UIView alloc] initWithFrame:appFrame];
    
    self.view = container;
    container.backgroundColor = [UIColor redColor];
    
    swatchListView = [[UISwatchListView alloc] initWithFrame:appFrame];
    swatchListView.dataSource = (UIViewController <UISwatchListDataSource> *) self;
    [self.view addSubview:swatchListView];
    
    [self.view addSubview:[pickerViewController view]];
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

#pragma mark View layout
- (void)layoutViews {
    CGRect paletteRect, editorRect, bounds = [self.view bounds];
    
    NSUInteger sections = [colors count] + 1;
    CGFloat itemHeight = bounds.size.height / sections;
    
    paletteRect = CGRectMake(0.0f, 0.0f, bounds.size.width, itemHeight * [colors count]);
    editorRect = CGRectMake(0.0f, paletteRect.size.height, bounds.size.width, itemHeight);
    
    [swatchListView updateSwatches];
    
    [UIView animateWithDuration:3.0f animations:^ {
        swatchListView.frame = paletteRect;
        [pickerViewController view].frame = editorRect;
    }];
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
}

#pragma mark Data management
- (void)fetchRecords {
    colors = [[NSMutableArray alloc] init];
}

- (void)addColor:(UIColor *)color {
    [colors addObject:color];
    [self layoutViews];
}

@end
