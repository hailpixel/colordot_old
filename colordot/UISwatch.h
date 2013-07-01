//
//  UISwatchView.h
//  colordot
//
//  Created by Devin Hunt on 6/28/13.
//  Copyright (c) 2013 Devin Hunt. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UISwatch : UIView {
    UIColor *swatchColor;
}

- (id)initWithColor:(UIColor *) color;

@end
