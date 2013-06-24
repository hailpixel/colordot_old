//
//  UIPaletteViewDelegate.h
//  colordot
//
//  Created by Devin Hunt on 6/17/13.
//  Copyright (c) 2013 Devin Hunt. All rights reserved.
//

#import <Foundation/Foundation.h>
@class UIPaletteView;
@class UIColorSwatch;

@protocol UIPaletteViewDataSource <NSObject>

// Number of colors in the palette
- (NSInteger)numberOfSwatchesInPaletteView:(UIPaletteView *)paletteView;

// Grab swatch view for color
- (UIColorSwatch *)paletteView:(UIPaletteView *)paletteView swatchForRow:(NSInteger) row;

@end