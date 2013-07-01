//
//  ColorPickerView.h
//  colordot
//
//  Created by Devin Hunt on 6/28/13.
//  Copyright (c) 2013 Devin Hunt. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ColorPickerView : UIView {
    UILabel *hexLabel;
}

@property (nonatomic, strong) UILabel *hexLabel;
- (void)setColor:(UIColor *) color;

@end
