//
//  UIColorPickerDelegate.h
//  colordot
//
//  Created by Devin Hunt on 7/1/13.
//  Copyright (c) 2013 Devin Hunt. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol UIColorPickerDelegate <NSObject>

- (void)colorPicked: (UIColor *)color;

@end
