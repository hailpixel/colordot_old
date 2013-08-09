//
//  UISwatchView.h
//  colordot
//
//  Created by Devin Hunt on 6/28/13.
//  Copyright (c) 2013 Devin Hunt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QuartzCore/QuartzCore.h"
#import "UISwatchListDelegate.h"

typedef enum {
    SwatchPullOptionEdit,
    SwatchPullOptionRemove
} SwatchPullOptions;

@interface UISwatch : UIView {
    UIView *colorView;
    UILabel *hexLabel;
    
    BOOL _pullThresholdReached;
    SwatchPullOptions _pullOptionType;
}

@property NSUInteger representedRow;
@property (strong, nonatomic) UIColor *swatchColor;
@property (weak, nonatomic) id <UISwatchListDelegate> delegate;

- (id)initWithColor:(UIColor *) color;
- (void)setupSwatch;
- (void)respondToSlide:(UIPanGestureRecognizer *)sender;

@end
