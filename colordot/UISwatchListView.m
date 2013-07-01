//
//  UISwatchListView.m
//  colordot
//
//  Created by Devin Hunt on 6/28/13.
//  Copyright (c) 2013 Devin Hunt. All rights reserved.
//

#import "UISwatchListView.h"
#import "UISwatch.h"

@implementation UISwatchListView
@synthesize dataSource;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)updateSwatches {
    NSInteger i, count = [dataSource numberOfSwatches];
    UISwatch *swatch;
    CGFloat height = self.bounds.size.height, width = self.bounds.size.width;
    
    for(i = 0; i < count; i ++) {
        swatch = [dataSource swatchForListRow:i];
        swatch.frame = CGRectMake(0.0f, i * height / count, width, height / count);
        swatch.autoresizingMask = (UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin);
        
        [self addSubview:swatch];
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
