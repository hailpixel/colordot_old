//
//  UIPaletteViewController.m
//  colordot
//
//  Created by Devin Hunt on 6/28/13.
//  Copyright (c) 2013 Devin Hunt. All rights reserved.
//

#import "PaletteViewController.h"

@implementation PaletteViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.swatchListViewController = [[SwatchListViewController alloc] init];
        [self addChildViewController:self.swatchListViewController];
        
        self.pickerViewController = [[PickerViewController alloc] init];
        self.pickerViewController.delegate = self.swatchListViewController;
        [self addChildViewController:self.pickerViewController];
    }
    return self;
}

- (void)loadView {
    CGRect appFrame = [[UIScreen mainScreen] bounds];
    self.paletteView = [[PaletteView alloc] initWithFrame:appFrame];
    self.view = self.paletteView;
    
    self.paletteView.mainView = self.swatchListViewController.view;
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
    self.swatchListViewController.palette = palette;
    self.paletteView.state = PaletteViewClosed;
}


@end
