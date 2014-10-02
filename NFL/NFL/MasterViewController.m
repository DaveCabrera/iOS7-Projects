//
//  MasterViewController.m
//  NFL
//
//  Created by David Cabrera on 10/22/13.
//  Copyright (c) 2013 David Cabrera. All rights reserved.
//

#import "MasterViewController.h"

@interface MasterViewController ()

@end

@implementation MasterViewController

/*
 The awakeFromNib message is sent to each object recreated from an Interface Builder archive,
 but ONLY AFTER (a) all the objects in the archive have been loaded and initialized, and
 (b) all its outlet and action connections are already established.
 */
- (void)awakeFromNib
{
    /*
     The default value of this property is YES. When YES, the table view controller
     clears the table’s current selection when it receives a viewWillAppear: message.
     Setting this property to NO preserves the selection.
     */
    self.clearsSelectionOnViewWillAppear = NO;
    
    // Set the size of the master view controller’s view while displayed in a popover.
    self.preferredContentSize = CGSizeMake(320.0, 600.0);
    
    [super awakeFromNib];
}

- (void)viewDidLoad {
    
    // Set the navigation bar title
    self.title = @"NFL";
    
    // Instantiate a static dictionary object and initialize it with the content of the Countries.plist
    // file, which resides on a server computer requiring network connection to access it.
    self.nflDictionary = [[NSDictionary alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"NFL" ofType:@"plist"]];
    
    
    /*
     Send allKeys message to the dictionary object and obtain all of the keys in an array.
     Send the sortedArrayUsingSelector: message to that array. It returns an array that lists the receiver’s
     elements in ascending order, as determined by the comparison method specified by a given selector.
     */
    self.teamNicknames = [[self.nflDictionary allKeys] sortedArrayUsingSelector:@selector(compare:)];
    
    // Obtain the object reference (obj ref) to the Detail View Controller object for use later
    self.detailViewController = (DetailViewController *)[[self.splitViewController.viewControllers lastObject] topViewController];
    
    // Set redskins as the default selected  to show first upon launch of the app
    self.teamData = [self.nflDictionary objectForKey:@"Redskins"];
    
    // Pass the data object  to downstream Detail View Controller
    [self.detailViewController setWebsiteURL:[[self teamData] objectAtIndex:4]];
    [self.detailViewController setDataForSelectedTeam:self.teamData];

    [super viewDidLoad];   // Inform super
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

// Although the default is 1; it is still good to include this method for clarity
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

// Asks the data source to return the number of rows in a given section.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.teamNicknames count];
}

// Asks the data source to return a cell to insert in a particular table view location
- (TeamCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSUInteger rowNumber = [indexPath row];
    
    NSString *nflTeamCode = [self.teamNicknames objectAtIndex:rowNumber];
    NSArray *nflTeamData = [self.nflDictionary objectForKey:nflTeamCode];
    
    TeamCell *cell = (TeamCell *)[tableView dequeueReusableCellWithIdentifier:@"TeamCellType"];
    
    
    cell.teamCodeLabel.text = nflTeamCode;
    cell.teamLogo.image = [UIImage imageNamed:[nflTeamData objectAtIndex:0]];
    cell.teamNameLabel.text = [nflTeamData objectAtIndex:1];
    cell.divisionLabel.text = [nflTeamData objectAtIndex:2];
    cell.stadiumLabel.text = [nflTeamData objectAtIndex:3];
    
    return cell;
}


#pragma mark - Table View Delegate Methods

//       Asks the table view delegate to return the height of a given row.
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return kTableViewRowHeight;
}


//       Informs the table view delegate that the table view is about to display a cell for a particular row.
//       Just before the cell is displayed, we change the color of the cell's background.

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //   We use the modulus operator % to find the remainder of the division of row number by 2.
    //   If the remainder is 0, it is an even number (use MintCream); otherwise, it is an odd number (use OldLace).
    
    if (indexPath.row % 2 == 0) {
        // Set even numbered row background color to MintCream, #F5FFFA  245,255,250
        cell.backgroundColor = MINT_CREAM;
    } else {
        // Set odd numbered row background color to OldLace, #FDF5E6   253,245,230
        cell.backgroundColor = OLD_LACE;
    }
}

// Informs the table view delegate that the user tapped the detail accessory button
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSUInteger rowNumber = [indexPath row];
    NSString *teamNickname = [self.teamNicknames objectAtIndex:rowNumber];
    
    self.teamData = [self.nflDictionary objectForKey:teamNickname];
    
    [self.detailViewController setDataForSelectedTeam:self.teamData];
    [self.detailViewController setWebsiteURL:[[self teamData] objectAtIndex:4]];
    [self.detailViewController.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.detailViewController.websiteURL]]];
}

@end
