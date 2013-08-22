//
//  UISwatchView.m
//  colordot
//
//  Created by Devin Hunt on 6/28/13.
//  Copyright (c) 2013 Devin Hunt. All rights reserved.
//

#import "SwatchView.h"

@implementation SwatchView
@synthesize hexLabel, color = _color;

- (id)initWithFrame:(CGRect)frame andColor:(ColorObject *)color {
    self = [super initWithFrame:frame];
    
    if(self) {
        [self setupSwatch];
        self.color = color;
    }
    
    return self;
}

- (void)setupSwatch {
    // Gestures
    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onDoubleTap:)];
    tapRecognizer.numberOfTapsRequired = 2;
    [self addGestureRecognizer:tapRecognizer];
    
    // UI
    self.hexLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 100.0f, 30.0f)];
    self.hexLabel.textAlignment = NSTextAlignmentCenter;
    self.hexLabel.autoresizingMask = (UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleBottomMargin);
    self.hexLabel.backgroundColor = [UIColor clearColor];
    [self addSubview:self.hexLabel];
}

- (void)setColor:(ColorObject *)color {
    _color = color;
    UIColor *uiColor = [self.color uiColor];
    self.backgroundColor = uiColor;
    
    CGFloat r, g, b, a;
    [uiColor getRed:&r green:&g blue:&b alpha:&a];
    self.hexLabel.text = [NSString stringWithFormat:@"#%.2X%.2X%.2X", (NSInteger)(r * 255), (NSInteger)(g * 255), (NSInteger)(b * 255)];
}

#pragma mark Gesture methods

- (void)onDoubleTap:(UITapGestureRecognizer *)sender {
    if([self.delegate respondsToSelector:@selector(swatchView:onDoubleTap:)]) {
        [self.delegate swatchView:self onDoubleTap:sender];
    }
}

@end
