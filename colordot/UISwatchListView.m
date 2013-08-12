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
        self.backgroundColor = [UIColor orangeColor];
    }
    return self;
}

- (UISwatch *)swatchAtRow:(NSUInteger)row {
    return (UISwatch *) [self subviews][row];
}

#pragma todo this assumes the view is always starting empty
- (void)reloadSwatches {
    int i, swatchCount = [self.dataSource numberOfSwatches];
    UISwatch *swatch;
    
    if([self.subviews count] > 0) {
        [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    }
    
    for(i = 0; i < swatchCount; i ++) {
        swatch = [self.dataSource swatchForListRow:i];
        [self addSubview:swatch];
    }
    
    [self layoutSwatches];
}

- (void)updateSwatches {
    NSUInteger i, swatchCount = [[self subviews] count];
    UISwatch *swatch;
    
    for(i = 0; i < swatchCount; i ++) {
        swatch = (UISwatch *) [self subviews][i];
        swatch.representedRow = i;
    }
    
    [self layoutSwatches];
}

- (void)setFrame:(CGRect)frame {
    super.frame = frame;
    [self layoutSwatches];
}

- (void)layoutSwatches {
    NSInteger i, swatchCount = [[self subviews] count];
    
    if(swatchCount > 0) {
        UISwatch *swatch;
        CGFloat height = self.frame.size.height / swatchCount;
        
        for(i = 0; i < swatchCount; i ++) {
            swatch = (UISwatch *) [self subviews][i];
            swatch.frame = CGRectMake(0.0f, i * height, self.frame.size.width, height);
        }
    }
}

@end
