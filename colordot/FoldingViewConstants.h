//
//  As_FoldingVIewConstants.h
//  Folding Controller Experiment
//
//  Created by Devin Hunt on 7/23/13.
//  Copyright (c) 2013 Devin Hunt. All rights reserved.
//


#define kUnfoldThreshold 0.3

// States for FoldingView
typedef enum {
    FoldingStateDefault = 0,
    FoldingStateLeftUnfolded = 1,
    FoldingStateRightUnfolded = 2,
    FoldingStateTransition = 3
} FoldingViewState;

// Types for FoldView
typedef enum {
    FoldViewTypeLeft = 0,
    FoldViewTypeRight = 1
} FoldViewType;

typedef enum {
    FoldViewStateClosed = 0,
    FoldViewStateOpen = 1,
    FoldViewStateTransition = 2,
} FoldViewState;

// Direction flags
typedef enum {
    FoldingViewDirectionHorizontal = 0,
    FoldingViewDirectionVertical = 1
} FoldingViewDirection;