//
//  PaletteView.h
//  colordot
//
//  Created by Devin Hunt on 6/14/13.
//  Copyright (c) 2013 Devin Hunt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIPaletteViewDataSource.h"

@interface UIPaletteView : UIView

@property (strong, nonatomic) UILabel *label;
@property (weak) id<UIPaletteViewDataSource> dataSource;

- (void)reloadData;

@end
