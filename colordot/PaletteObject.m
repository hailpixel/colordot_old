//
//  PaletteObject.m
//  colordot
//
//  Created by Devin Hunt on 8/7/13.
//  Copyright (c) 2013 Devin Hunt. All rights reserved.
//

#import "PaletteObject.h"
#import "ColorObject.h"


@implementation PaletteObject

@dynamic created;
@dynamic name;
@dynamic colors;

- (NSArray *)colorsArray {
    NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"order" ascending:YES];
    return [self.colors sortedArrayUsingDescriptors:[NSArray arrayWithObject:sort]];
}

@end
