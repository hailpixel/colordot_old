//
//  PaletteTableViewController.m
//  colordot
//
//  Created by Devin Hunt on 8/7/13.
//  Copyright (c) 2013 Devin Hunt. All rights reserved.
//

#import "PaletteTableViewController.h"
#import "PaletteObject.h"
#import "UIPaletteViewController.h"

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
    
    [self fetchPalettes];
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
    
    UIPaletteViewController *paletteViewController = [[UIPaletteViewController alloc] init];
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
    return [self.palettes count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"PaletteCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if(! cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
    }
    
    PaletteObject *palette = [self.palettes objectAtIndex:[indexPath row]];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateStyle = NSDateFormatterShortStyle;
    dateFormatter.timeStyle = NSDateFormatterShortStyle;
    
    cell.textLabel.text = [dateFormatter stringFromDate:palette.created];
    
    return cell;
}


#pragma mark - Table view delegate

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    UIPaletteViewController *paletteViewController = [[UIPaletteViewController alloc] init];
    paletteViewController.palette = [self.palettes objectAtIndex:[indexPath row]];
    [self.navigationController pushViewController:paletteViewController animated:YES];
}


@end
