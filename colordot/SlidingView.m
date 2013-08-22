//
//  SlidingView.m
//  colordot
//
//  Created by Devin Hunt on 8/21/13.
//  Copyright (c) 2013 Devin Hunt. All rights reserved.
//

#import "SlidingView.h"

@implementation SlidingView
@synthesize state = _state, centerView = _centerView, rightView = _rightView;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initialize];
    }
    return self;
}

- (void)initialize {
    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(onPan:)];
    [self addGestureRecognizer:panGesture];
}

#pragma mark Setting content
- (void)setCenterView:(UIView *)centerView {
    if(self.centerView) {
        [self.centerView removeFromSuperview];
    }
    _centerView = centerView;
    
    self.centerView.frame = self.bounds;
    [self addSubview:self.centerView];
}

- (void)setRightView:(UIView *)rightView {
    if(self.rightView) {
        [self.rightView removeFromSuperview];
    }
    _rightView = rightView;
    
    self.rightView.frame = CGRectMake(self.bounds.size.width, 0.0f, self.rightView.bounds.size.width, self.bounds.size.height);
    [self insertSubview:self.rightView atIndex:0];
}

#pragma mark State and interaction
- (void)setState:(SlidingViewStates)state {
    _state = state;
    
    CGAffineTransform transform;
    
    if(state == SlidingViewDefault) {
        transform = CGAffineTransformIdentity;
    } else if(state == SlidingViewRightOpen) {
        transform = CGAffineTransformMakeTranslation(-self.rightView.bounds.size.width, 0.0f);
    }
    
    [UIView animateWithDuration:0.2f animations:^{
        self.centerView.transform = transform;
        self.rightView.transform = transform;
    }];
}

- (void)onPan:(UIPanGestureRecognizer *)sender {
    CGPoint translation = [sender translationInView:self];
    
    if(sender.state == UIGestureRecognizerStateBegan) {
        if(abs(translation.x) > abs(translation.y)) {
            self.direction = SlidingViewDirectionHorizontal;
        }
    } else if(sender.state == UIGestureRecognizerStateChanged) {
        if(self.direction == SlidingViewDirectionHorizontal) {
            CGFloat offset = 0.0f;
            
            if(self.state == SlidingViewDefault) {
                offset = translation.x;
            } else if(self.state == SlidingViewRightOpen) {
                offset = translation.x - self.bounds.size.width;
            }
            
            offset = MAX(MIN(offset, 0), -self.bounds.size.width);
            
            [self moveContentOffset:offset];
        }
    } else if(sender.state == UIGestureRecognizerStateEnded || sender.state == UIGestureRecognizerStateCancelled) {
        if(self.state == SlidingViewDefault && translation.x < - self.rightView.bounds.size.width * kSlidingViewThreshold) {
            self.state = SlidingViewRightOpen;
            return;
        }
        self.state = SlidingViewDefault;
    }
}

- (void)moveContentOffset:(CGFloat)offset {
    CGAffineTransform transform = CGAffineTransformMakeTranslation(offset, 0.0f);
    self.centerView.transform = transform;
    self.rightView.transform = transform;
}

@end
