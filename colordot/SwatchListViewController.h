//
//  SwatchListViewController.h
//  colordot
//
//  Created by Devin Hunt on 8/19/13.
//  Copyright (c) 2013 Devin Hunt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SwatchListView.h"
#import "SwatchDetailViewController.h"
#import "PaletteObject.h"
#import "PickerViewController.h"

@interface SwatchListViewController : UIViewController <SwatchListDelegate, SwatchListDataSource, PickerDelegate>

@property (nonatomic, strong) SwatchDetailViewController *detailViewController;
@property (nonatomic, strong) SwatchListView *swatchListView;

// data
@property (nonatomic, strong) PaletteObject *palette;
@property (nonatomic, strong) NSMutableArray *colors;

@end
