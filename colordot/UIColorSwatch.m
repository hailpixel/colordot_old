//
//  UIColorSwatch.m
//  colordot
//
//  Created by Devin Hunt on 6/14/13.
//  Copyright (c) 2013 Devin Hunt. All rights reserved.
//

#import "UIColorSwatch.h"

@implementation UIColorSwatch

@synthesize color = _color;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setColor:(UIColor *)color {
    _color = color;
    self.backgroundColor = color;
}

- (UIColor *)getColor {
    return _color;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    // UITouch *touch = [touches anyObject];
    // self.color = [UIColor colorWithRed:1.0f green:0.0f blue:0.0f alpha:1.0f];
}

@end
