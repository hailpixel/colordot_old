//
//  UISwatchView.h
//  colordot
//
//  Created by Devin Hunt on 6/28/13.
//  Copyright (c) 2013 Devin Hunt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ColorObject.h"
@class SwatchView;

@protocol SwatchViewDelegate <NSObject>

@optional
- (void)swatchView:(SwatchView *)swatchView onDoubleTap:(UIGestureRecognizer *)sender;

@end

@interface SwatchView : UIView

@property (nonatomic, strong) ColorObject *color;
@property (nonatomic, weak) id <SwatchViewDelegate> delegate;
@property NSUInteger representedRow;

@property (nonatomic, strong) UILabel *hexLabel;

- (id)initWithFrame:(CGRect)frame andColor:(ColorObject *)color;

@end