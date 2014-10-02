//
//  PlacesTableViewController.m
//  Blacksburg
//
//  Created by David Cabrera on 9/29/13.
//  Copyright (c) 2013 David Cabrera. All rights reserved.
//

#import "PlacesTableViewController.h"

@interface PlacesTableViewController ()
/*
 When a table view row is expanded, new rows are inserted after it into the table view.
 When a table view row is shrunk, the rows expanded under it are deleted.
 
 These insertions and deletions will change to table view content. We define
 tableViewContent as a changeable array to hold the current rows of the table view.
 */
@property (strong, nonatomic) NSMutableArray *tableViewContent;
@property (strong, nonatomic) NSString *urlOfWebsite;
@end

@implementation PlacesTableViewController

- (void)viewDidLoad
{
    // hold the menu items
    self.btMenu = @[@"Restaurants", @"Hotels", @"Parking", @"Bars"];
    
    // the location of the images for each item in the table view
    self.btLogoLocation = [[NSBundle mainBundle] pathForResource:@"bInCircle30" ofType:@"png"];
    
    
    // Instantiate a dynamic (changable) array to hold the current rows of the table view
    self.tableViewContent = [[NSMutableArray alloc] init];
    
    // Set the current rows to be the list of the university names
    [self.tableViewContent addObjectsFromArray:self.btMenu];
    
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


// Asks the data source to return the number of sections in the table view
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

// Asks the data source to return the number of rows in a section, the number of which is given
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.tableViewContent count];
}

// Asks the data source to return a cell to insert in a particular table view location
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSUInteger rowNumber = [indexPath row];          // Identify the row number
    
    // Obtain the object reference of the UITableViewCell object instantiated with respect to
    // the identifier TableViewCellReuseID
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TableViewCellReuseID"];
    
    NSString *rowName = [self.tableViewContent objectAtIndex:rowNumber];
    cell.textLabel.text = rowName;
    
    cell.indentationWidth = 10.0;         // 10.0 points is the default value
    cell.textLabel.lineBreakMode = NSLineBreakByWordWrapping;
    cell.textLabel.numberOfLines = 0;
    if ([self.btMenu containsObject:rowName]) {        // Level=0
        cell.indentationLevel = 0;
        
        cell.imageView.image = [UIImage imageNamed:@"bInCircle30.png"];
    }
    
    return cell;
}

// Prepare the table view cell before it is displayed to the user
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    // Set the cell's selected background view
    UIView *cellBackgroundView = [[UIView alloc] initWithFrame:cell.frame];
    cell.selectedBackgroundView = cellBackgroundView;
}

// get the cell that was selected to push a website into view
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // get the cell
    UITableViewCell *cell = (UITableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
    
    // get the text and set the segue
    NSString *cellText = cell.textLabel.text;
    
    if ([cellText isEqualToString:@"Restaurants"])
    {
        self.urlOfWebsite = @"http://maps.google.com/?q=24060+Restaurants";
        self.titleName = @"Restaurants";
        [self performSegueWithIdentifier:@"Website" sender:self];
    }
    if ([cellText isEqualToString:@"Hotels"])
    {
        self.urlOfWebsite = @"http://maps.google.com/?q=24060+Hotels";
        self.titleName = @"Hotels";
        [self performSegueWithIdentifier:@"Website" sender:self];
    }
    if ([cellText isEqualToString:@"Parking"])
    {
        self.urlOfWebsite = @"http://maps.google.com/?q=24060+Parking";
        self.titleName = @"Parking";
        [self performSegueWithIdentifier:@"Website" sender:self];
    }
    if ([cellText isEqualToString:@"Bars"])
    {
        self.urlOfWebsite = @"http://maps.google.com/?q=24060+Bars";
        self.titleName = @"Bars";
        [self performSegueWithIdentifier:@"Website" sender:self];
    }
}

// This method is called by the system whenever you invoke the method performSegueWithIdentifier:sender:
// You never call this method. It is invoked by the system.
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([[segue identifier] isEqualToString:@"Website"]) {
        
        // Obtain the object reference of the destination view controller
        WebsiteViewController *websiteViewController = [segue destinationViewController];
        
        //Pass the data object to the destination view controller object
        websiteViewController.websiteURL = self.urlOfWebsite;
        
        websiteViewController.navigationBar.title = self.titleName;
    }
}


@end
