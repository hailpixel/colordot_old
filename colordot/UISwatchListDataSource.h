//
//  ISwatchListDataSource.h
//  colordot
//
//  Created by Devin Hunt on 6/28/13.
//  Copyright (c) 2013 Devin Hunt. All rights reserved.
//

#import <Foundation/Foundation.h>
@class UISwatch;

@protocol UISwatchListDataSource <NSObject>

- (NSUInteger)numberOfSwatches;
- (UISwatch *)swatchForListRow: (NSUInteger)row;

@end
