//
//  FoldingView.m
//  Folding Controller Experiment
//
//  Created by Devin Hunt on 7/22/13.
//  Copyright (c) 2013 Devin Hunt. All rights reserved.
//

#import "FoldingView.h"

@implementation FoldingView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initialize];
    }
    return self;
}

- (void)initialize {
    self.backgroundColor = [UIColor colorWithWhite:0.1f alpha:1.0f];
    self.autoresizesSubviews = YES;
    self.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    _contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height)];
    _contentView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    _contentView.backgroundColor = [UIColor whiteColor];
    _contentView.autoresizesSubviews = YES;
    [self addSubview:_contentView];
    
    UIPanGestureRecognizer *panRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(onContentViewPanned:)];
    [self addGestureRecognizer:panRecognizer];
    panRecognizer.delegate = self;
}

- (void)setCenterContentView:(UIView *)view {
    view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self.contentView addSubview:view];
}

- (void)setLeftFoldView:(UIView *)view {
    if(self.leftView) {
        [self.leftView removeFromSuperview];
    }
    
    self.leftView = [[FoldView alloc] initWithFrame:CGRectMake(0, 0, view.bounds.size.width, view.bounds.size.height) andFoldType:FoldViewTypeLeft];
    [self insertSubview:self.leftView belowSubview:self.contentView];
    [self.leftView setContentView:view];
}

- (void)setRightFoldView:(UIView *)view {
    if(self.rightView) {
        [self.rightView removeFromSuperview];
    }
    
    self.rightView = [[FoldView alloc] initWithFrame:CGRectMake(self.bounds.size.width - view.bounds.size.width, 0, view.bounds.size.width, view.bounds.size.height) andFoldType:FoldViewTypeRight];
    [self insertSubview:self.rightView belowSubview:self.contentView];
    [self.rightView setContentView:view];
}

- (void)onContentViewPanned:(UIPanGestureRecognizer *)gesture {
    if(gesture.state == UIGestureRecognizerStateBegan) {
        CGPoint velocity = [gesture velocityInView:self];
        
        if(abs(velocity.x) > abs(velocity.y)) {
            self.foldDirection = FoldingViewDirectionHorizontal;
        } else {
            self.foldDirection = FoldingViewDirectionVertical;
        }
    } else {
        if(self.foldDirection == FoldingViewDirectionHorizontal) {
            [self onPannedHorizontally:gesture];
        }
    }
}

- (void)onPannedHorizontally:(UIPanGestureRecognizer *)gesture {
    CGPoint point = [gesture translationInView:self];
    float x;
    
    if(gesture.state == UIGestureRecognizerStateChanged) {
        if(self.state == FoldingStateDefault) {
            x = point.x;

            if(point.x < 0) {
                self.rightView.hidden = NO;
                self.leftView.hidden = YES;
            } else {
                self.rightView.hidden = YES;
                self.leftView.hidden = NO;
            }
            
            [self animateContentOffset:point panned:YES];
        } else if(self.state == FoldingStateRightUnfolded) {
            x = point.x - self.rightView.frame.size.width;
            x = MIN(MAX(x, - self.rightView.frame.size.width), 0);
            point = CGPointMake(x, 0);
            self.rightView.hidden = NO;
            self.leftView.hidden = YES;
            [self animateContentOffset:point panned:YES];
        } else if(self.state == FoldingStateLeftUnfolded) {
            x = self.leftView.frame.size.width + point.x;
            x = MAX(MIN(x, self.leftView.frame.size.width), 0);
            point = CGPointMake(x, 0);
            self.rightView.hidden = YES;
            self.leftView.hidden = NO;
            [self animateContentOffset:point panned:YES];
        }
    } else if(gesture.state == UIGestureRecognizerStateEnded || gesture.state == UIGestureRecognizerStateCancelled) {
        if(self.state == FoldingStateDefault) {
            if(point.x < 0) {
                if(abs(point.x) > kUnfoldThreshold * self.contentView.frame.size.width) {
                    self.state = FoldingStateRightUnfolded;
                    return;
                }
            } else if(point.x > 0) {
                if(abs(point.x) > kUnfoldThreshold * self.contentView.frame.size.width) {
                    self.state = FoldingStateLeftUnfolded;
                    return;
                }
            }
        }
        self.state = FoldingStateDefault;
    }
}

#pragma mark View state
- (void)setState:(FoldingViewState)state {
    _state = state;
    
    if(_state == FoldingStateDefault) {
        [NSTimer scheduledTimerWithTimeInterval:0.01f target:self selector:@selector(restoreView:) userInfo:nil repeats:YES];
    } else if(_state == FoldingStateRightUnfolded) {
        [NSTimer scheduledTimerWithTimeInterval:0.01f target:self selector:@selector(unfoldRightView:) userInfo:nil repeats:YES];
    } else if(_state == FoldingStateLeftUnfolded) {
        [NSTimer scheduledTimerWithTimeInterval:0.01f target:self selector:@selector(unfoldLeftView:) userInfo:nil repeats:YES];
    }
}


#pragma mark Animation methods

- (void)animateContentOffset:(CGPoint)point panned:(BOOL)hasPanned {
    if(point.x < 0 && self.rightView) {
        self.contentView.transform = CGAffineTransformMakeTranslation(point.x, 0);
        [self.rightView unfoldWithOffset:point.x];
    } else if(point.x > 0 && self.leftView) {
        self.contentView.transform = CGAffineTransformMakeTranslation(point.x, 0);
        [self.leftView unfoldWithOffset:point.x];
    }
}

- (void)unfoldRightView:(NSTimer *)timer {
    CGAffineTransform transform = self.contentView.transform;
    float x = transform.tx - (transform.tx + self.rightView.frame.size.width) / 8;
    
    if(x < -self.rightView.frame.size.width + 1) {
        [timer invalidate];
        x = -self.rightView.frame.size.width;
    }
       
    transform = CGAffineTransformMakeTranslation(x, 0);
    self.contentView.transform = transform;
    [self animateContentOffset:CGPointMake(self.contentView.frame.origin.x, 0) panned:NO];
}

- (void)unfoldLeftView:(NSTimer *)timer {
    CGAffineTransform transform = self.contentView.transform;
    float x = transform.tx + (self.leftView.frame.size.width - transform.tx) / 8;
    
    if(x > self.leftView.frame.size.width - 1) {
        [timer invalidate];
        x = self.leftView.frame.size.width;
    }
    
    transform = CGAffineTransformMakeTranslation(x, 0);
    self.contentView.transform = transform;
    [self animateContentOffset:CGPointMake(self.contentView.frame.origin.x, 0) panned:NO];
}

- (void)restoreView:(NSTimer *)timer {
    if(self.foldDirection == FoldingViewDirectionHorizontal) {
        float x = self.contentView.transform.tx * 3 / 4;
        
        if(x > -1 && x < 1) {
            [timer invalidate];
            x = 0;
        }
        
        CGAffineTransform transform = CGAffineTransformMakeTranslation(x, 0);
        self.contentView.transform = transform;
        [self animateContentOffset:CGPointMake(self.contentView.frame.origin.x, 0) panned:NO];
    }
}

#pragma mark Gesture recognizer delegate methods
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    return YES;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return YES;
}

@end
