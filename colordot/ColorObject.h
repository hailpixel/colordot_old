//
//  ColorObject.h
//  colordot
//
//  Created by Devin Hunt on 8/7/13.
//  Copyright (c) 2013 Devin Hunt. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class PaletteObject;

@interface ColorObject : NSManagedObject

@property (nonatomic, retain) NSNumber * brightness;
@property (nonatomic, retain) NSNumber * hue;
@property (nonatomic, retain) NSNumber * saturation;
@property (nonatomic, retain) NSNumber * order;
@property (nonatomic, retain) PaletteObject *palette;

- (UIColor *)uiColor;

@end
