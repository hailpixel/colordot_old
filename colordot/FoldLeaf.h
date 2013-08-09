//
//  FoldLeaf.h
//  Folding Controller Experiment
//
//  Created by Devin Hunt on 7/29/13.
//  Copyright (c) 2013 Devin Hunt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface FoldLeaf : UIView

@property (nonatomic, strong) CAGradientLayer *gradient;

- (void)setShadowColor:(NSArray *)colors;

@end
