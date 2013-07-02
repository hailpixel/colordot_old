//
//  DirectionalPanGestureRecognizer.h
//  colordot
//
//  Created by Devin Hunt on 7/2/13.
//  Copyright (c) 2013 Devin Hunt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <UIKit/UIGestureRecognizerSubclass.h>

typedef enum {
    DirectionalPanGestureVertical,
    DirectionalPanGestureHorizontal
} DirectionalPanGestureRecognizerDirection;

@interface DirectionalPanGestureRecognizer : UIPanGestureRecognizer {
    BOOL _isDragging;
    CGFloat _dX;
    CGFloat _dY;
    DirectionalPanGestureRecognizerDirection _direction;
}

@property (nonatomic) DirectionalPanGestureRecognizerDirection direction;

@end
