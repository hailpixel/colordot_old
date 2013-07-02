//
//  DirectionalPanGestureRecognizer.m
//  colordot
//
//  Created by Devin Hunt on 7/2/13.
//  Copyright (c) 2013 Devin Hunt. All rights reserved.
//

#import "DirectionalPanGestureRecognizer.h"

int const static dragThreshold = 10;

@implementation DirectionalPanGestureRecognizer

@synthesize direction = _direction;

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesMoved:touches withEvent:event];
    
    if(self.state == UIGestureRecognizerStateFailed) {
        return;
    }
    
    CGPoint nowPoint = [[touches anyObject] locationInView:self.view];
    CGPoint oldPoint = [[touches anyObject] previousLocationInView:self.view];
    
    _dX += oldPoint.x - nowPoint.x;
    _dY += oldPoint.y - nowPoint.y;
    
    if(! _isDragging) {
        if(abs(_dX) > dragThreshold) {
            if(_direction == DirectionalPanGestureHorizontal) {
                _isDragging = YES;
            } else {
                self.state = UIGestureRecognizerStateFailed;
            }
        } else if(abs(_dY) > dragThreshold) {
            if(_direction == DirectionalPanGestureVertical ) {
                _isDragging = YES;
            } else {
                self.state = UIGestureRecognizerStateFailed;
            }
        }
    }
}

- (void)reset {
    [super reset];
    _isDragging = NO;
    _dX = 0;
    _dY = 0;
}

@end
