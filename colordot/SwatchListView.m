//
//  UISwatchListView.m
//  colordot
//
//  Created by Devin Hunt on 6/28/13.
//  Copyright (c) 2013 Devin Hunt. All rights reserved.
//

#import "SwatchListView.h"

@implementation SwatchListView
@synthesize state = _state, detailView = _detailView;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.state = SwatchListViewStateDefault;
        
        self.listView = [[UIView alloc] initWithFrame:frame];
        self.listView.autoresizingMask = (UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight);
        [self addSubview:self.listView];
        
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onTap:)];
        tapGesture.numberOfTapsRequired = 1;
        [self.listView addGestureRecognizer:tapGesture];
    }
    return self;
}

#pragma mark State switching
- (void)setState:(SwatchListViewState)state {
    _state = state;
    
    if(self.state == SwatchListViewStateDefault) {
        targetSwatch.hexLabel.hidden = NO;
        self.detailView.hidden = YES;
        [self layoutSwatchesWithAnimation:YES];
    } else if(self.state == SwatchListViewStateEditing) {
        
        if(self.delegate) {
            [self.delegate swatchListView:self swatchEditedAtRow:targetSwatch.representedRow];
        }
        
        SwatchView *swatch;
        NSInteger i, swatchCount = [self.dataSource numberOfSwatches];
        CGFloat padding = 0.0f;
        CGRect frame, editFrame;
        
        if(swatchCount > 1) {
            CGFloat runningHeight = 0.0f;
            CGFloat editHeight = self.listView.bounds.size.height - 160.0f;
            CGFloat swatchHeight = 160.0f / (swatchCount - 1);
            
            for(i = 0; i < swatchCount; i ++) {
                swatch = (SwatchView *)[self.listView subviews][i];
                if(swatch == targetSwatch) {
                    editFrame = CGRectMake(padding, runningHeight + padding, self.listView.bounds.size.width - (padding * 2), editHeight - (padding * 2));
                    frame = editFrame;
                    runningHeight += editHeight;
                } else {
                    frame = CGRectMake(0.0f, runningHeight, self.listView.bounds.size.width, swatchHeight);
                    runningHeight += swatchHeight;
                }
                
                [UIView animateWithDuration:0.2f animations:^{
                    swatch.frame = frame;
                }];
            }
    
        } else {
            editFrame = CGRectMake(padding, padding, self.bounds.size.width - (padding * 2), self.bounds.size.height - (padding * 2));
            [UIView animateWithDuration:0.2f animations:^{
                targetSwatch.frame = frame;
            }];
        }
        
        targetSwatch.hexLabel.hidden = YES;
        self.detailView.hidden = NO;
        [self bringSubviewToFront:self.detailView];
        self.detailView.frame = editFrame;
    }
}


- (SwatchView *)swatchAtRow:(NSUInteger)row {
    return (SwatchView *) [self.listView subviews][row];
}

- (void)reloadSwatches {
    int i, swatchCount = [self.dataSource numberOfSwatches];
    SwatchView *swatch;
    
    if([self.listView.subviews count] > 0) {
        [self.listView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    }
    
    for(i = 0; i < swatchCount; i ++) {
        swatch = [self.dataSource swatchForListRow:i];
        swatch.representedRow = i;
        swatch.delegate = self;
        [self.listView addSubview:swatch];
    }
    
    [self layoutSwatchesWithAnimation:NO];
}

- (void)updateSwatches {
    NSUInteger i, swatchCount = [[self.listView subviews] count];
    SwatchView *swatch;
    
    for(i = 0; i < swatchCount; i ++) {
        swatch = (SwatchView *) [self subviews][i];
        swatch.representedRow = i;
    }
    
    [self layoutSwatchesWithAnimation:YES];
}

- (void)setFrame:(CGRect)frame {
    super.frame = frame;
    [self layoutSwatchesWithAnimation:YES];
}

- (void)layoutSwatchesWithAnimation:(BOOL)isAnimated {
    NSInteger i, swatchCount = [[self.listView subviews] count];
    
    if(swatchCount > 0) {
        SwatchView *swatch;
        CGFloat height = self.frame.size.height / swatchCount;
        
        for(i = 0; i < swatchCount; i ++) {
            swatch = (SwatchView *) [self.listView subviews][i];
            
            if(isAnimated) {
                [UIView animateWithDuration:0.2f animations:^{
                    swatch.frame = CGRectMake(0.0f, i * height, self.listView.frame.size.width, height);
                }];
            } else {
                swatch.frame = CGRectMake(0.0f, i * height, self.listView.frame.size.width, height);
            }
        }
    }
}

- (void)setDetailView:(UIView *)detailView {
    if(self.detailView) {
        [self.detailView removeFromSuperview];
    }
    
    _detailView = detailView;
    self.detailView.hidden = YES;
    [self addSubview:detailView];
}

#pragma mark Gestures
- (void)onTap:(UITapGestureRecognizer *)sender {
    if(self.state == SwatchListViewStateEditing) {
        CGPoint tap = [sender locationInView:self];
        
        if(! CGRectContainsPoint(targetSwatch.frame, tap)) {
            self.state = SwatchListViewStateDefault;
        }
    }
}

#pragma mark SwatchView delegates
- (void)swatchView:(SwatchView *)swatchView onDoubleTap:(UIGestureRecognizer *)sender {
    targetSwatch = swatchView;
    self.state = SwatchListViewStateEditing;
}

@end
