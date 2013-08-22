//
//  UISwatchListView.h
//  colordot
//
//  Created by Devin Hunt on 6/28/13.
//  Copyright (c) 2013 Devin Hunt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SwatchView.h"
@class SwatchListView;

@protocol SwatchListDelegate <NSObject>
- (void)swatchListView:(SwatchListView *)listView swatchEditedAtRow:(NSUInteger)row;
- (void)swatchListView:(SwatchListView *)listView swatchRemovedAtRow:(NSUInteger)row;
@end


@protocol SwatchListDataSource <NSObject>
- (NSUInteger)numberOfSwatches;
- (SwatchView *)swatchForListRow: (NSUInteger)row;
@end


typedef enum {
    SwatchListViewStateDefault,
    SwatchListViewStateEditing
} SwatchListViewState;


@interface SwatchListView : UIView <SwatchViewDelegate, UIGestureRecognizerDelegate> {
    SwatchView *targetSwatch;
}

@property (weak, nonatomic) id <SwatchListDataSource> dataSource;
@property (weak, nonatomic) id <SwatchListDelegate> delegate;
@property (nonatomic) SwatchListViewState state;
@property (strong, nonatomic) UIView *listView, *detailView;

- (void)reloadSwatches;
- (void)updateSwatches;

- (SwatchView *)swatchAtRow:(NSUInteger)row;

@end
