//
//  ScreenshotView.m
//  Folding Controller Experiment
//
//  Created by Devin Hunt on 7/28/13.
//  Copyright (c) 2013 Devin Hunt. All rights reserved.
//

#import "ScreenshotView.h"
#import <QuartzCore/QuartzCore.h>

@implementation ScreenshotView

- (UIImage *)screenshot {
    CGFloat scale = 1.0;
    
    if([[UIScreen mainScreen] respondsToSelector:@selector(scale)]) {
        CGFloat tmpScale = [[UIScreen mainScreen] scale];
        if(tmpScale > 1.5) {
            scale = 2.0;
        }
    }
    
    if(scale > 1.5) {
        UIGraphicsBeginImageContextWithOptions(self.frame.size, NO, scale);
    } else {
        UIGraphicsBeginImageContext(self.frame.size);
    }
    
    [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *screenshot = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return screenshot;
}

@end
