//
//  UISwatchListView.h
//  colordot
//
//  Created by Devin Hunt on 6/28/13.
//  Copyright (c) 2013 Devin Hunt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UISwatchListDataSource.h"
#import "UISwatchListDelegate.h"
@class UISwatch;

@interface UISwatchListView : UIView

@property (weak, nonatomic) id <UISwatchListDataSource> dataSource;
@property (weak, nonatomic) id <UISwatchListDelegate> delegate;

- (void)reloadSwatches;
- (void)updateSwatches;

- (UISwatch *)swatchAtRow:(NSUInteger)row;

@end
