//
//  SlidingView.h
//  colordot
//
//  Created by Devin Hunt on 8/21/13.
//  Copyright (c) 2013 Devin Hunt. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kSlidingViewThreshold 0.3f

typedef enum {
    SlidingViewDefault,
    SlidingViewRightOpen
} SlidingViewStates;

typedef enum {
    SlidingViewDirectionNone,
    SlidingViewDirectionHorizontal
} SlidingViewDirection;

@interface SlidingView : UIView <UIGestureRecognizerDelegate>

@property (nonatomic, strong) UIView *centerView, *rightView;

@property (nonatomic) SlidingViewStates state;
@property (nonatomic) SlidingViewDirection direction;

@end
