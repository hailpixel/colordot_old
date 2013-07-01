//
//  UISwatchView.m
//  colordot
//
//  Created by Devin Hunt on 6/28/13.
//  Copyright (c) 2013 Devin Hunt. All rights reserved.
//

#import "UISwatch.h"

@implementation UISwatch

- (id)initWithColor:(UIColor *)color {
    self = [self initWithFrame:CGRectMake(0.0f, 0.0f, 0.0f, 0.0f)];
    if(self) {
        swatchColor = color;
        self.backgroundColor = swatchColor;
    }
    return self;
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
