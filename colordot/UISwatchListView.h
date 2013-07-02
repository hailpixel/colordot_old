//
//  UISwatchListView.h
//  colordot
//
//  Created by Devin Hunt on 6/28/13.
//  Copyright (c) 2013 Devin Hunt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UISwatchListDataSource.h"

@interface UISwatchListView : UIView

@property (weak, nonatomic) id <UISwatchListDataSource> dataSource;

- (void)updateLayoutToFrame:(CGRect)frame;

@end
