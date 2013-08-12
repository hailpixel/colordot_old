//
//  ColorDotViewController.m
//  colordot
//
//  Created by Devin Hunt on 8/9/13.
//  Copyright (c) 2013 Devin Hunt. All rights reserved.
//

#import "ColorDotViewController.h"
#import "PaletteObject.h"
#import "UISwatchListView.h"
#import "FoldingView.h"

@interface ColorDotViewController ()

@end

@implementation ColorDotViewController

- (id)init
{
    
    PaletteViewController *paletteController = [[PaletteViewController alloc] init];
    self = [super initWithRootViewController:paletteController];
    
    if (self) {
        _paletteController = paletteController;
        _paletteTableController = [[PaletteTableViewController alloc] initWithStyle:UITableViewStylePlain];
        _paletteTableController.tableView.delegate = self;
        [self setLeftViewController:self.paletteTableController width:220.0f];
    }
    return self;
}

- (void)setManagedObjectContext:(NSManagedObjectContext *)managedObjectContext {
    _managedObjectContext = managedObjectContext;
    
    self.paletteTableController.managedObjectContext = managedObjectContext;
    [self.paletteTableController fetchPalettes];
    [self.paletteTableController.tableView reloadData];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.row == 0) {
        // new palette
    } else {
        NSInteger row = indexPath.row - 1;
        PaletteObject *palette = self.paletteTableController.palettes[row];
        self.paletteController.palette = palette;
        self.foldingView.state = FoldingStateDefault;
    }
}

@end
