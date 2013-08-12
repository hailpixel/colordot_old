//
//  ColorDotViewController.h
//  colordot
//
//  Created by Devin Hunt on 8/9/13.
//  Copyright (c) 2013 Devin Hunt. All rights reserved.
//

#import "FoldingViewController.h"
#import "PaletteTableViewController.h"
#import "PaletteViewController.h"

@interface ColorDotViewController : FoldingViewController <UITableViewDelegate>

@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, strong) PaletteTableViewController *paletteTableController;
@property (nonatomic, strong) PaletteViewController *paletteController;

@end
