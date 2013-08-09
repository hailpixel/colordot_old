//
//  FoldingViewController.m
//  Folding Controller Experiment
//
//  Created by Devin Hunt on 7/22/13.
//  Copyright (c) 2013 Devin Hunt. All rights reserved.
//

#import "FoldingViewController.h"

@interface FoldingViewController ()

@end

@implementation FoldingViewController

- (id)initWithRootViewController:(UIViewController *)rootViewController {
    self = [super init];
    if(self) {
        self.view.autoresizesSubviews = YES;
        
        CGRect bounds = [self.view bounds];
        
        _foldingView = [[FoldingView alloc] initWithFrame:CGRectMake(0, 0, bounds.size.width, bounds.size.height)];
        [self.view addSubview:_foldingView];
        
        _rootViewController = rootViewController;
        _rootViewController.view.frame = CGRectMake(0, 0, bounds.size.width, bounds.size.height);
        _rootViewController.view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        [_foldingView setCenterContentView:_rootViewController.view];
    }
    return self;
}

- (void)setLeftViewController:(UIViewController *)leftViewController width:(float)width {
    _leftViewController = leftViewController;
    self.leftViewController.view.frame = CGRectMake(0, 0, width, self.view.bounds.size.height);
    [self.foldingView setLeftFoldView:self.leftViewController.view];
}

- (void)setRightViewController:(UIViewController *)rightViewController width:(float)width {
    _rightViewController = rightViewController;
    self.rightViewController.view.frame = CGRectMake(0, 0, width, self.view.bounds.size.height);
    [self.foldingView setRightFoldView:self.rightViewController.view];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
