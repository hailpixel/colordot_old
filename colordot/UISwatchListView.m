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

- (void)updateLayoutToFrame:(CGRect)frame {
    NSInteger i, swatchCount = [[self subviews] count];
    
    if(swatchCount > 0) {
        UISwatch *swatch;
        CGFloat height = frame.size.height / swatchCount;
        
        for(i = 0; i < swatchCount; i ++) {
            swatch = (UISwatch *) [self subviews][i];
            
            [UIView animateWithDuration:0.3 animations:^{
                swatch.frame = CGRectMake(0.0f, i * height, frame.size.width, height);
            }];
        }
    }
    
    [UIView animateWithDuration:0.3 animations:^{
        self.frame = frame;
    }];
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
