//
//  FoldView.h
//  Folding Controller Experiment
//
//  Created by Devin Hunt on 7/22/13.
//  Copyright (c) 2013 Devin Hunt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FoldingViewConstants.h"
#import "FoldLeaf.h"

@interface FoldView : UIView

@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, strong) FoldLeaf  *leftLeafView, *rightLeafView;
@property (nonatomic) FoldViewType foldType;

- (id)initWithFrame:(CGRect)frame andFoldType:(FoldViewType)type;

- (void)setContentView:(UIView *)contentView;
- (void)drawImageOnLeaves;

// Unfold view to a fraction. 0 is closed, 1 is totally unfolded. 
- (void)unfoldViewToFraction:(float)fraction;
- (void)unfoldWithOffset:(float)offset;

@end
