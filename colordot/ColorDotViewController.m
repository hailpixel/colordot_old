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
        
        self.foldingView.activeArea = CGRectMake(0.0f, 0.0f, 50.0f, self.foldingView.frame.size.height);
    }
    return self;
}

- (void)setManagedObjectContext:(NSManagedObjectContext *)managedObjectContext {
    _managedObjectContext = managedObjectContext;
    
    self.paletteTableController.managedObjectContext = managedObjectContext;
    [self.paletteTableController fetchPalettes];
    [self.paletteTableController.tableView reloadData];
    
    //TODO: We need to use the last palette being worked on,
    // or if there are none, create a new a new VALID palette object.
    self.paletteController.palette = self.paletteTableController.palettes[0];
    
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
