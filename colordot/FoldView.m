//
//  FoldView.m
//  Folding Controller Experiment
//
//  Created by Devin Hunt on 7/22/13.
//  Copyright (c) 2013 Devin Hunt. All rights reserved.
//

#import "FoldView.h"
#import "ScreenshotView.h"
#import <QuartzCore/QuartzCore.h>

@implementation FoldView

- (id)initWithFrame:(CGRect)frame {
    return [self initWithFrame:frame andFoldType:FoldViewTypeRight];
}

- (id)initWithFrame:(CGRect)frame andFoldType:(FoldViewType)type {
    self = [super initWithFrame:frame];
    
    if (self) {
        
        _foldType = type;
        _state = FoldViewStateClosed;
        
        _contentView = [[ScreenshotView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        _contentView.backgroundColor = [UIColor clearColor];
        [self addSubview:_contentView];
        
        if(self.foldType == FoldViewTypeRight) {
            // left fold is anchord on the left side
            // the (-1 * self.frame.size.width / 4) frame.origin.x is need since the "center" is the left edge of the view.
            // without it, the layer is render in the "middle" of it's frame. This pulls it back.
            _leftLeafView = [[FoldLeaf alloc] initWithFrame:CGRectMake(3 * self.frame.size.width / 4, 0, self.frame.size.width / 2, self.frame.size.height)];
            
            // right fold is anchord on the right side
            _rightLeafView = [[FoldLeaf alloc] initWithFrame:CGRectMake(3 * self.frame.size.width / 4, 0, self.frame.size.width / 2, self.frame.size.height)];
        } else if(self.foldType == FoldViewTypeLeft) {
            _leftLeafView = [[FoldLeaf alloc] initWithFrame:CGRectMake(-1 * self.frame.size.width /   4, 0, self.frame.size.width / 2, self.frame.size.height)];
            _rightLeafView = [[FoldLeaf alloc] initWithFrame:CGRectMake(-1 * self.frame.size.width / 4, 0, self.frame.size.width / 2, self.frame.size.height)];
        }
        
        _leftLeafView.backgroundColor = [UIColor whiteColor];
        [_leftLeafView setShadowColor:[NSArray arrayWithObjects:[UIColor colorWithWhite:0 alpha:0.05f], [UIColor colorWithWhite:0 alpha:0.4f], nil]];
        [_leftLeafView.layer setAnchorPoint:CGPointMake(0.0, 0.5)];
        [self addSubview:_leftLeafView];
        
        _rightLeafView.backgroundColor = [UIColor whiteColor];
        [_rightLeafView setShadowColor:[NSArray arrayWithObjects:[UIColor colorWithWhite:0 alpha:0.4f], [UIColor colorWithWhite:0 alpha:0.05f], nil]];
        [_rightLeafView.layer setAnchorPoint:CGPointMake(1.0, 0.5)];
        [self addSubview:_rightLeafView];
        
        // Set perspective on leaves
        CATransform3D transform = CATransform3DIdentity;
        transform.m34 = -1 / 800.0;
        self.layer.sublayerTransform = transform;
        
        _rightLeafView.layer.transform = CATransform3DMakeRotation(M_PI_2, 0, -1, 0);
        _leftLeafView.layer.transform = CATransform3DMakeRotation(M_PI_2, 0, 1, 0);
        
        self.autoresizesSubviews = YES;
        _contentView.autoresizesSubviews = YES;
        _contentView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    }
    return self;
}

- (void)setContentView:(UIView *)contentView {
    contentView.frame = CGRectMake(0, 0, contentView.frame.size.width, contentView.frame.size.height);
    [self.contentView addSubview:contentView];
    [self drawImageOnLeaves];
}

- (void)drawImageOnLeaves {
    UIImage *image = [(ScreenshotView *)_contentView screenshot];
    CGImageRef leftImageRef = CGImageCreateWithImageInRect([image CGImage], CGRectMake(0, 0, image.size.width * image.scale / 2, image.size.height * image.scale));
    [self.leftLeafView.layer setContents:(__bridge id)leftImageRef];
    
    CGImageRef rightImageRef = CGImageCreateWithImageInRect([image CGImage], CGRectMake(image.size.width * image.scale / 2, 0, image.size.width * image.scale / 2, image.size.height * image.scale));
    [self.rightLeafView.layer setContents:(__bridge id)rightImageRef];
}

- (void)unfoldWithOffset:(float)offset {
    CGFloat fraction = offset / self.frame.size.width;
    
    if(fraction < 0) fraction *= -1.0f;
    if(fraction > 1) fraction = 1.0f;
    
    [self setHiddenStatesFromFraction:fraction];
    [self unfoldViewToFraction:fraction];
}

- (void)unfoldViewToFraction:(float)fraction {
    float delta = asinf(fraction);
    
    if(self.foldType == FoldViewTypeRight) {
        _rightLeafView.layer.transform = CATransform3DMakeRotation(M_PI_2 - delta, 0, -1, 0);
        
        CATransform3D transform1 = CATransform3DMakeTranslation(-2 * _rightLeafView.frame.size.width, 0, 0);
        CATransform3D transform2 = CATransform3DMakeRotation(M_PI_2 - delta, 0, 1, 0);
        CATransform3D leftTransform = CATransform3DConcat(transform2, transform1);
        _leftLeafView.layer.transform = leftTransform;
    }
    else {
        _leftLeafView.layer.transform = CATransform3DMakeRotation(delta - M_PI_2, 0, -1, 0);
        
        CATransform3D transform1 = CATransform3DMakeTranslation(2 * _leftLeafView.frame.size.width, 0, 0);
        CATransform3D transform2 = CATransform3DMakeRotation(delta - M_PI_2, 0, 1, 0);
        CATransform3D rightTransform = CATransform3DConcat(transform2, transform1);
        _rightLeafView.layer.transform = rightTransform;
    }
    
    _rightLeafView.gradient.opacity = 1.0f - fraction;
    _leftLeafView.gradient.opacity = 1.0f - fraction;
}

- (void)setHiddenStatesFromFraction:(float)fraction {
    if(self.state == FoldViewStateClosed && fraction > 0) {
        [self drawImageOnLeaves];
        self.state = FoldViewStateTransition;
        self.contentView.hidden = YES;
        [self hideLeaves:NO];
    } else if(self.state == FoldViewStateOpen && fraction < 1) {
        self.state = FoldViewStateTransition;
        self.contentView.hidden = YES;
        [self hideLeaves:NO];
    } else {
        if(fraction == 0) {
            self.state = FoldViewStateClosed;
            self.contentView.hidden = NO;
            [self hideLeaves:NO];
        } else if(fraction == 1) {
            self.state = FoldViewStateOpen;
            self.contentView.hidden = NO;
            [self hideLeaves:YES];
        }
    }
}

- (void)hideLeaves:(BOOL)isHidden {
    self.leftLeafView.hidden = isHidden;
    self.rightLeafView.hidden = isHidden;
}

@end
