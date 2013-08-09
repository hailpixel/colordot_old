//
//  UISwatchListDelegate.h
//  colordot
//
//  Created by Devin Hunt on 7/2/13.
//  Copyright (c) 2013 Devin Hunt. All rights reserved.
//

#import <Foundation/Foundation.h>

@class UISwatchListView;

@protocol UISwatchListDelegate <NSObject>

- (void)swatchListView:(UISwatchListView *)listView swatchEditedAtRow:(NSUInteger)row;
- (void)swatchListView:(UISwatchListView *)listView swatchRemovedAtRow:(NSUInteger)row;

@end
