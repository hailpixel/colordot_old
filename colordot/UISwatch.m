//
//  UISwatchView.m
//  colordot
//
//  Created by Devin Hunt on 6/28/13.
//  Copyright (c) 2013 Devin Hunt. All rights reserved.
//

#import "UISwatch.h"
#import "DirectionalPanGestureRecognizer.h"

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
        _initialPanX = [sender locationInView:self].x;
    }
    if([sender state] == UIGestureRecognizerStateChanged) {
        CGPoint offset = [sender translationInView:self];
        colorView.transform = CGAffineTransformMakeTranslation(offset.x, 0.0f);
    }
    if([sender state] == UIGestureRecognizerStateEnded) {
        [UIView animateWithDuration:0.2f animations:^{
            colorView.transform = CGAffineTransformIdentity;
        }];
    }
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
