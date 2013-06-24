//
//  UIColorPickerView.m
//  colordot
//
//  Created by Devin Hunt on 6/18/13.
//  Copyright (c) 2013 Devin Hunt. All rights reserved.
//

#import "UIColorPickerView.h"

@implementation UIColorPickerView
@synthesize valueLable;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        valueLable = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 100.0f, 30.0f)];
        [valueLable setText:@"#000000"];
        [self addSubview:self.valueLable];
    }
    return self;
}

- (void)setColor:(UIColor *)color {
    self.backgroundColor = color;
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
