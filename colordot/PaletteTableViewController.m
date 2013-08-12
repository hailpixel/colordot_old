//
//  PaletteTableViewController.m
//  colordot
//
//  Created by Devin Hunt on 8/7/13.
//  Copyright (c) 2013 Devin Hunt. All rights reserved.
//

#import "PaletteTableViewController.h"
#import "PaletteObject.h"
#import "PaletteViewController.h"

@interface PaletteTableViewController ()

@end

@implementation PaletteTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addPalette:)];
    self.navigationItem.rightBarButtonItem = addButton;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Core data methods
- (void)fetchPalettes {
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Palette" inManagedObjectContext:self.managedObjectContext];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entity];
    
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"created" ascending:NO];
    request.sortDescriptors = [NSArray arrayWithObject:sortDescriptor];
    
    NSError *error;
    NSMutableArray *fetchedPalettes = [[self.managedObjectContext executeFetchRequest:request error:&error] mutableCopy];
    if(error) {
        NSLog(@"Error grabbing palettes :(");
    }
    self.palettes = fetchedPalettes;
}

#pragma mark - Addition / deletion
- (void)addPalette:(id)sender {
    PaletteObject *newPalette = (PaletteObject *) [NSEntityDescription insertNewObjectForEntityForName:@"Palette" inManagedObjectContext:self.managedObjectContext];
    newPalette.created = [NSDate date];
    
    NSError *error;
    if(![self.managedObjectContext save:&error]) {
        NSLog(@"Error creating and saving new palette");
    }
    
    [self.palettes insertObject:newPalette atIndex:0];
    
    PaletteViewController *paletteViewController = [[PaletteViewController alloc] init];
    paletteViewController.palette = newPalette;
    
    [self.tableView reloadData];
    [self.navigationController pushViewController:paletteViewController animated:YES];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.palettes count] + 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"PaletteCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if(! cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
    }
    
    if(indexPath.row > 0) {

        PaletteObject *palette = [self.palettes objectAtIndex:(indexPath.row - 1)];

        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        dateFormatter.dateStyle = NSDateFormatterShortStyle;
        dateFormatter.timeStyle = NSDateFormatterShortStyle;

        cell.textLabel.text = [dateFormatter stringFromDate:palette.created];
    } else {
        cell.textLabel.text = @"New Palette";
    }
    
    return cell;
}


@end
