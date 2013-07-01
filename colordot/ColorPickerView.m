//
//  ColorPickerView.m
//  colordot
//
//  Created by Devin Hunt on 6/28/13.
//  Copyright (c) 2013 Devin Hunt. All rights reserved.
//

#import "ColorPickerView.h"

@implementation ColorPickerView
@synthesize hexLabel;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        hexLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 100.0f, 100.0f)];
        hexLabel.autoresizingMask = (UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin);
        
        hexLabel.backgroundColor = [UIColor blackColor];
        hexLabel.textColor = [UIColor whiteColor];
        hexLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:hexLabel];
        
        [self setColor:[UIColor greenColor]];
    }
    return self;
}

- (void)setColor:(UIColor *)color {
    self.backgroundColor = color;
    CGFloat r, g, b, a;
    [color getRed:&r green:&g blue:&b alpha:&a];
    [hexLabel setText:[NSString stringWithFormat:@"#%.2X%.2X%.2X", (NSInteger)(r * 255), (NSInteger)(g * 255), (NSInteger)(b * 255)]];
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
