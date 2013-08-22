//
//  SwatchListViewController.m
//  colordot
//
//  Created by Devin Hunt on 8/19/13.
//  Copyright (c) 2013 Devin Hunt. All rights reserved.
//

#import "SwatchListViewController.h"
#import "SwatchView.h"
#import "PaletteViewController.h"


@implementation SwatchListViewController
@synthesize palette = _palette, swatchListView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil    
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.detailViewController = [[SwatchDetailViewController alloc] init];
        [self addChildViewController:self.detailViewController];
    }
    return self;
}

- (void)loadView {
    CGRect appFrame = [[UIScreen mainScreen] bounds];
    self.swatchListView = [[SwatchListView alloc] initWithFrame:appFrame];
    self.swatchListView.dataSource = self;
    self.swatchListView.delegate = self;
    self.view = self.swatchListView;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.swatchListView.detailView = self.detailViewController.view;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

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
    [self.swatchListView reloadSwatches];
}

#pragma mark UISwatchListDataSource methods
- (NSUInteger)numberOfSwatches {
    return [self.colors count];
}

- (SwatchView *)swatchForListRow:(NSUInteger)row {
    ColorObject *color = [self.colors objectAtIndex:row];
    SwatchView *swatch = [[SwatchView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 0.0f, 0.0f) andColor:color];
    return swatch;
}

#pragma mark SwatchListDelegate methods
- (void)swatchListView:(SwatchListView *)listView swatchEditedAtRow:(NSUInteger)row {
    ColorObject *color = self.colors[row];
    self.detailViewController.color = color;
}

- (void)swatchListView:(SwatchListView *)listView swatchRemovedAtRow:(NSUInteger)row {
    
}
    

#pragma mark UIColorPickerDelegate methods
- (void)colorPicked:(UIColor *)color {
    [self addColor:color];
    
    PaletteViewController *parent = (PaletteViewController *)[self parentViewController];
    if(parent) {
        parent.paletteView.state = PaletteViewClosed;
    }
}

#pragma mark Getters / Setters
- (void)setPalette:(PaletteObject *)palette {
    _palette = palette;
    self.colors = [[self.palette colorsArray] mutableCopy];
    [self.swatchListView reloadSwatches];
}

@end
