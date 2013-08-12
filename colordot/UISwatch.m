//
//  UISwatchView.m
//  colordot
//
//  Created by Devin Hunt on 6/28/13.
//  Copyright (c) 2013 Devin Hunt. All rights reserved.
//

#import "UISwatch.h"
#import "UISwatchListView.h"
#import "DirectionalPanGestureRecognizer.h"

const static NSInteger pullThreshold = 100;

@implementation UISwatch
@synthesize swatchColor = _swatchColor;

- (id)initWithColor:(UIColor *)color {
    self = [self initWithFrame:CGRectMake(0.0f, 0.0f, 0.0f, 0.0f)];
    if(self) {
        [self setupSwatch];
        self.swatchColor = color;
    }
    return self;
}

- (void)setupSwatch {
    
    self.backgroundColor = [UIColor colorWithHue:0.0f saturation:0.0f brightness:.1f alpha:1.0f];
    
    UILabel *deleteLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
    deleteLabel.autoresizingMask = (UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin);
    deleteLabel.textAlignment = NSTextAlignmentRight;
    [deleteLabel setText:@"remove"];
    [deleteLabel sizeToFit];
    deleteLabel.center = CGPointMake(270, 0);
    deleteLabel.backgroundColor = [UIColor colorWithWhite:1.0f alpha:0.0f];
    deleteLabel.textColor = [UIColor whiteColor];
    [self addSubview:deleteLabel];
    
    UILabel *editLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
    editLabel.autoresizingMask = (UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin);
    editLabel.textAlignment = NSTextAlignmentRight;
    [editLabel setText:@"edit"];
    [editLabel sizeToFit];
    editLabel.center = CGPointMake(30, 0);
    editLabel.backgroundColor = [UIColor colorWithWhite:1.0f alpha:0.0f];
    editLabel.textColor = [UIColor whiteColor];
    [self addSubview:editLabel];
    
    colorView = [[UIView alloc] initWithFrame:self.bounds];
    colorView.autoresizingMask = (UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight);
    [self addSubview:colorView];
    
    hexLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 100.0f, 50.0f)];
    hexLabel.autoresizingMask = (UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin);
    hexLabel.backgroundColor = [UIColor blackColor];
    hexLabel.textColor = [UIColor whiteColor];
    hexLabel.textAlignment = NSTextAlignmentCenter;
    
    [colorView addSubview:hexLabel];
    
    DirectionalPanGestureRecognizer *swipeGesture = [[DirectionalPanGestureRecognizer alloc] initWithTarget:self action:@selector(respondToSlide:)];
    swipeGesture.direction = DirectionalPanGestureHorizontal;
    [self addGestureRecognizer:swipeGesture];
}

- (void)setSwatchColor:(UIColor *)swatchColor {
    _swatchColor = swatchColor;
    colorView.backgroundColor = _swatchColor;
    
    CGFloat r, g, b, a;
    [swatchColor getRed:&r green:&g blue:&b alpha:&a];
    [hexLabel setText:[NSString stringWithFormat:@"#%.2X%.2X%.2X", (NSInteger)(r * 255), (NSInteger)(g * 255), (NSInteger)(b * 255)]];
}

- (void)respondToSlide:(UIPanGestureRecognizer *)sender {
    if([sender state] == UIGestureRecognizerStateBegan) {
        _pullThresholdReached = NO;
    }
    if([sender state] == UIGestureRecognizerStateChanged) {
        CGPoint offset = [sender translationInView:self];
        colorView.transform = CGAffineTransformMakeTranslation(offset.x, 0.0f);
        
        if(abs(offset.x) > pullThreshold) {
            _pullThresholdReached = YES;
            
            if(offset.x > 0) {
                _pullOptionType = SwatchPullOptionEdit;
            } else {
                _pullOptionType = SwatchPullOptionRemove;
            }
        } else {
            _pullThresholdReached = NO;
        }
    }
    if([sender state] == UIGestureRecognizerStateEnded) {
        if(_pullThresholdReached) {
            if(_pullOptionType == SwatchPullOptionRemove) {
                [self.delegate swatchListView:(UISwatchListView *)[self superview] swatchRemovedAtRow:self.representedRow];
            } else if (_pullOptionType == SwatchPullOptionEdit) {
                [self.delegate swatchListView:(UISwatchListView *)[self superview] swatchEditedAtRow:self.representedRow];
            }
        }
        
        [UIView animateWithDuration:0.2f animations:^{
            colorView.transform = CGAffineTransformIdentity;
        }];
    }
}

@end
