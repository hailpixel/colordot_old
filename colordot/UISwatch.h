//
//  UISwatchView.h
//  colordot
//
//  Created by Devin Hunt on 6/28/13.
//  Copyright (c) 2013 Devin Hunt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QuartzCore/QuartzCore.h"

@interface UISwatch : UIView {
    UIView *colorView;
    UILabel *hexLabel;
    
    CGFloat _initialPanX;
}

@property (strong, nonatomic) UIColor *swatchColor;

- (id)initWithColor:(UIColor *) color;
- (void)setupSwatch;
- (void)respondToSlide:(UIPanGestureRecognizer *)sender;

@end
