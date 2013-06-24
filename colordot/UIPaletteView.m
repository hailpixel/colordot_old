//
//  PaletteView.m
//  colordot
//
//  Created by Devin Hunt on 6/14/13.
//  Copyright (c) 2013 Devin Hunt. All rights reserved.
//

#import "UIPaletteView.h"
#import "UIColorSwatch.h"

@implementation UIPaletteView
@synthesize dataSource;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

- (void)reloadData {
    CGRect viewRect = [self bounds];
    CGFloat width = viewRect.size.width, height;
    NSInteger i, total = [dataSource numberOfSwatchesInPaletteView:self];
    
    if(total > 0) {
        height = viewRect.size.height / total;
        for(i = 0; i < total; i ++) {
            UIColorSwatch *swatch = [dataSource paletteView:self swatchForRow:i];
            swatch.frame = CGRectMake(0, height * i, width, height);
            [self addSubview:swatch];
        }
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
