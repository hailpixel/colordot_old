//
//  PaletteTableViewController.h
//  colordot
//
//  Created by Devin Hunt on 8/7/13.
//  Copyright (c) 2013 Devin Hunt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PaletteObject.h"

@interface PaletteTableViewController : UITableViewController

@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, strong) NSMutableArray *palettes;

- (void)fetchPalettes;
- (PaletteObject *)makeNewPalette;


@end
