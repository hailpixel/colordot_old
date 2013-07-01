//
//  UISwatchListViewController.h
//  colordot
//
//  Created by Devin Hunt on 6/28/13.
//  Copyright (c) 2013 Devin Hunt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UISwatchListDataSource.h"
@class UISwatchListView;

@interface UISwatchListViewController : UIViewController <UISwatchListDataSource> {
    UISwatchListView *swatchListView;
    NSMutableArray *swatches;
}

@property (nonatomic, strong) NSMutableArray *swatches;

- (void)fetchSwatches;

@end
