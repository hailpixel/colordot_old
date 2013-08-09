//
//  FoldLeaf.m
//  Folding Controller Experiment
//
//  Created by Devin Hunt on 7/29/13.
//  Copyright (c) 2013 Devin Hunt. All rights reserved.
//

#import "FoldLeaf.h"

@implementation FoldLeaf

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _gradient = [CAGradientLayer layer];
        _gradient.frame = CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height);
        _gradient.startPoint = CGPointMake(0, 0);
        _gradient.endPoint = CGPointMake(1, 0);
        [self.layer addSublayer:_gradient];
    }
    return self;
}

- (void)setShadowColor:(NSArray *)colors {
    NSMutableArray *cols = [[NSMutableArray alloc] init];
    NSInteger i;
    
    for(i = 0; i < colors.count; i ++) {
        [cols addObject:(__bridge id)((UIColor *)colors[i]).CGColor];
    }
    self.gradient.colors = cols;
}

@end
