//
//  ColorObject.m
//  colordot
//
//  Created by Devin Hunt on 8/7/13.
//  Copyright (c) 2013 Devin Hunt. All rights reserved.
//

#import "ColorObject.h"
#import "PaletteObject.h"


@implementation ColorObject

@dynamic brightness;
@dynamic hue;
@dynamic saturation;
@dynamic palette;
@dynamic order;

- (UIColor *)uiColor {
    return [UIColor colorWithHue:[self.hue floatValue] saturation:[self.saturation floatValue] brightness:[self.brightness floatValue] alpha:1.0f];
}

@end
