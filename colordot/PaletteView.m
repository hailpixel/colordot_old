//
//  PaletteView.m
//  colordot
//
//  Created by Devin Hunt on 8/12/13.
//  Copyright (c) 2013 Devin Hunt. All rights reserved.
//

#import "PaletteView.h"

@implementation PaletteView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initialize];
    }
    return self;
}

- (void)initialize {
    self.state = PaletteViewClosed;
    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(onPan:)];
    panGesture.delegate = self;
    [self addGestureRecognizer:panGesture];
}

#pragma mark View setters
- (void)setMainView:(UIView *)mainView {
    if(_mainView) {
        [_mainView removeFromSuperview];
    }
    
    _mainView = mainView;
    [self addSubview:_mainView];
}

- (void)setBottomView:(UIView *)bottomView {
    if(_bottomView) {
        [_bottomView removeFromSuperview];
    }
    
    _bottomView = bottomView;
    self.bottomView.frame = CGRectMake(0.0f, self.bounds.size.height, self.bounds.size.width, self.bounds.size.width);
    [self insertSubview:self.bottomView belowSubview:self.mainView];
}

#pragma mark State handling
- (void)setState:(PaletteViewState)state {
    _state = state;
    void (^animation)();

    
    if(state == PaletteViewClosed) {
        animation = ^{
            self.mainView.frame = self.bounds;
            self.bottomView.transform = CGAffineTransformIdentity;
        };
    } else if (state == PaletteViewOpen) {
        animation = ^{
            self.mainView.frame = CGRectMake(0.0f, 0.0f, self.bounds.size.width, self.bounds.size.height - self.bottomView.frame.size.height);
            self.bottomView.transform = CGAffineTransformMakeTranslation(0.0f, -self.bottomView.frame.size.height);
        };
    }
    
    [UIView animateWithDuration:0.2f
                          delay:0.0f
                        options:(UIViewAnimationOptions) UIViewAnimationCurveEaseOut
                     animations:animation
                     completion:nil];
}

#pragma mark Panning
- (void)onPan:(UIPanGestureRecognizer *)gesture {
    CGPoint translation = [gesture translationInView:self];
    
    if(gesture.state == UIGestureRecognizerStateChanged) {
        CGFloat offset;
        
        if(self.state == PaletteViewClosed) {
            offset = translation.y;
            [self moveContentOffset:offset hasPanned:YES];
        } else if(self.state == PaletteViewOpen) {
            offset = translation.y - self.bottomView.bounds.size.height;
            [self moveContentOffset:offset hasPanned:YES];
        }
    } else if(gesture.state == UIGestureRecognizerStateEnded || gesture.state == UIGestureRecognizerStateFailed) {
        if(self.state == PaletteViewClosed) {
            if(-1.0f * translation.y > (self.bottomView.frame.size.height * kPaletteViewTriggerThreshold)) {
                self.state = PaletteViewOpen;
                return;
            }
        }
        
        self.state = PaletteViewClosed;
    }
}

- (void)moveContentOffset:(CGFloat)offset hasPanned:(BOOL)hasPanned {
    CGFloat y = MAX(MIN(0.0f, offset), -self.bottomView.frame.size.height);
    
    self.mainView.frame = CGRectMake(0.0f, 0.0f, self.bounds.size.width, self.bounds.size.height + y);
    self.bottomView.transform = CGAffineTransformMakeTranslation(0.0f, y);
}

#pragma mark Gesture delegate methods
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    return YES;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return NO;
}

@end
