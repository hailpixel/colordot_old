//
//  FoldingViewController.h
//  Folding Controller Experiment
//
//  Created by Devin Hunt on 7/22/13.
//  Copyright (c) 2013 Devin Hunt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FoldingView.h"

@interface FoldingViewController : UIViewController

@property (nonatomic, strong) UIViewController *rootViewController, *leftViewController, *rightViewController;
@property (nonatomic, strong) FoldingView *foldingView;

- (id)initWithRootViewController:(UIViewController *)rootViewController;
- (void)setLeftViewController:(UIViewController *)leftViewController width:(float)width;
- (void)setRightViewController:(UIViewController *)rightViewController width:(float)width;

@end
