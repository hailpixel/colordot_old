//
//  FoldingView.h
//  Folding Controller Experiment
//
//  Created by Devin Hunt on 7/22/13.
//  Copyright (c) 2013 Devin Hunt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FoldView.h"
#import "FoldingViewConstants.h"

@interface FoldingView : UIView <UIGestureRecognizerDelegate>

// State of the view
@property (nonatomic) FoldingViewState state;

@property (nonatomic) FoldingViewDirection foldDirection;

// main view
@property (strong, nonatomic) UIView *contentView;

// folded view to the left and right
@property (strong, nonatomic) FoldView *leftView, *rightView;

// Optional rectangle to restric dragging to the new view
@property (nonatomic, assign) CGRect activeArea;

- (void)setCenterContentView:(UIView *)view;
- (void)setLeftFoldView:(UIView *)view;
- (void)setRightFoldView:(UIView *)view;

@end
