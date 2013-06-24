//
//  UIColorPickerView.h
//  colordot
//
//  Created by Devin Hunt on 6/18/13.
//  Copyright (c) 2013 Devin Hunt. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColorPickerView : UIView

@property (nonatomic, retain) UILabel *valueLable;

- (void)setColor:(UIColor *)color;

@end
