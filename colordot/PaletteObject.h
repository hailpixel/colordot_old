//
//  PaletteObject.h
//  colordot
//
//  Created by Devin Hunt on 8/7/13.
//  Copyright (c) 2013 Devin Hunt. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class ColorObject;

@interface PaletteObject : NSManagedObject

@property (nonatomic, retain) NSDate * created;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSArray *colors;

- (NSArray *)colorsArray;

@end

@interface PaletteObject (CoreDataGeneratedAccessors)

- (void)addColorsObject:(ColorObject *)value;
- (void)removeColorsObject:(ColorObject *)value;
- (void)addColors:(NSSet *)values;
- (void)removeColors:(NSSet *)values;

@end
