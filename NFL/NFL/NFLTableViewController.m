//
//  ViewController.m
//  NFL
//
//  Created by David Cabrera on 10/21/13.
//  Copyright (c) 2013 David Cabrera. All rights reserved.
//

#import "NFLTableViewController.h"

@interface NFLTableViewController ()
@property (nonatomic, strong) NSString *websiteURL;
@property (nonatomic, strong) NSString *teamName;
@property (nonatomic, strong) NSString *googleMapsLink;
@end

@implementation NFLTableViewController

- (void)viewDidLoad
{
    // Instantiate a static dictionary object and initialize it with the content of the Countries.plist
    // file, which resides on a server computer requiring network connection to access it.
    self.nflDictionary = [[NSDictionary alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"NFL" ofType:@"plist"]];
    
    /*
     Send allKeys message to the dictionary object and obtain all of the keys (NFL codes) in an array.
     Send the sortedArrayUsingSelector: message to that array. It returns an array that lists the receiver’s
     elements in ascending order, as determined by the comparison method specified by a given selector.
     */
    self.teamNicknames = [[self.nflDictionary allKeys] sortedArrayUsingSelector:@selector(compare:)];
    
    [super viewDidLoad];   // Inform super
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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


// Informs the table view delegate that the specified row is now selected.
- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath {
    
    NSUInteger rowNumber = [indexPath row];
    NSString *nflTeamNicknames = [self.teamNicknames objectAtIndex:rowNumber];
    
    self.teamData = [self.nflDictionary objectForKey:nflTeamNicknames];
    self.teamName = [self.teamData objectAtIndex:1];
    
    // get the name of stadium and put an & instead of spaces
    NSString *stadiumString = [[self teamData] objectAtIndex:3];
    NSString *webReadyStadiumString = [stadiumString stringByReplacingOccurrencesOfString:@" " withString:@"+"];
    
    NSString *teamStadiumNameQuery = [webReadyStadiumString stringByReplacingOccurrencesOfString:@"&" withString:@"%26"];
    
    // Compose the query URL for Google's map API
    self.websiteURL = [NSString stringWithFormat:@"http://maps.google.com/?q=%@", teamStadiumNameQuery];
    
    // Perform the segue named NFLWebView
    [self performSegueWithIdentifier:@"NFLWebView" sender:self];
}


// Informs the table view delegate that the user tapped the detail accessory button
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSUInteger rowNumber = [indexPath row];
    NSString *teamNickname = [self.teamNicknames objectAtIndex:rowNumber];
    
    self.teamData = [self.nflDictionary objectForKey:teamNickname];
    
    self.teamName = [self.teamData objectAtIndex:1];
    self.websiteURL = [self.teamData objectAtIndex:4];
    
    // Perform the segue named NFLWebView
    [self performSegueWithIdentifier:@"NFLWebView" sender:self];
}


#pragma mark - Preparing for Segue

// This method is called by the system whenever you invoke the method performSegueWithIdentifier:sender:
// You never call this method. It is invoked by the system.
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
//    if ([[segue identifier] isEqualToString:@"NFLMapView"]) {
//        
//        // Obtain the object reference of the destination view controller
//        NFLMapViewController *mapViewController = [segue destinationViewController];
//        
//        // Pass the data object NFLData to the downstream view controller NFLMapViewController
//        mapViewController.dataForSelectedTeam = self.teamData;
//        
//    } else
    if ([[segue identifier] isEqualToString:@"NFLWebView"]) {
    
        // Obtain the object reference of the destination view controller
        NFLWebViewController *webViewController = [segue destinationViewController];
        
        // Pass the data objects NFLName and websiteURL to the downstream view controller NFLWebViewController
        webViewController.teamName = self.teamName;
        webViewController.websiteURL = self.websiteURL;
    }
}

@end
