//
//  UISwatchListViewController.m
//  colordot
//
//  Created by Devin Hunt on 6/28/13.
//  Copyright (c) 2013 Devin Hunt. All rights reserved.
//

#import "UISwatchListViewController.h"
#import "UISwatchListView.h"

@interface UISwatchListViewController ()

@end

@implementation UISwatchListViewController
@synthesize swatches;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)loadView {
    swatchListView = [[UISwatchListView alloc] init];
    swatchListView.dataSource = (UISwatchListDataSource *) self;
    self.view = swatchListView;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark Data management methods
- (void)fetchSwatches {
    self.swatches = [[NSMutableArray alloc] init];
}

#pragma mark UISwatchListDataSource methods
- (NSUInteger)numberOfSwatches {
    return 0;
}

- (UISwatch *)swatchForListRow:(NSUInteger)row {
    return nil;
}

@end
