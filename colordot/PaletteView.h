//
//  PaletteView.h
//  colordot
//
//  Created by Devin Hunt on 8/12/13.
//  Copyright (c) 2013 Devin Hunt. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    PaletteViewClosed,
    PaletteViewTransition,
    PaletteViewOpen
} PaletteViewState;

#define kPaletteViewTriggerThreshold 0.3f

@interface PaletteView : UIView <UIGestureRecognizerDelegate>

@property (nonatomic, strong) UIView *mainView, *bottomView;
@property (nonatomic) PaletteViewState state;

- (void)moveContentOffset:(CGFloat)offset hasPanned:(BOOL)hasPanned;

@end
