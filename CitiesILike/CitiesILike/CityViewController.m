//
//  ViewController.m
//  CitiesILike
//
//  Created by David Cabrera on 10/23/13.
//  Copyright (c) 2013 David Cabrera. All rights reserved.
//

#import "CityViewController.h"
#import "AddCityViewController.h"
#import "CityMapViewController.h"
#import "CityWebViewController.h"
#import "AppDelegate.h"

@interface CityViewController ()

@property (nonatomic, strong) NSMutableDictionary *countryCities;
@property (nonatomic, strong) NSMutableArray *countries;

// cityData is the data object to be passed to the downstream view controller
@property (nonatomic, strong) NSMutableArray *cityData;

// This method is invoked when the user taps the Add button created at run time.
- (void)addCity:(id)sender;

@end


@implementation CityViewController


#pragma mark - View Life Cycle

- (void)viewDidLoad
{
    // Obtain an object reference to the App Delegate object
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    // Set the local instance variable to the obj ref of the countryCities dictionary
    // data structure created in the App Delegate class
    self.countryCities = appDelegate.countryCities;
    
    // You can set the navigation bar's title either here or in the storyboard
    // self.title = @"My Favorite Cities";
    
    // Set up the Edit system button on the left of the navigation bar
    self.navigationItem.leftBarButtonItem = self.editButtonItem;
    
    /*
     editButtonItem is provided by the system with its own functionality. Tapping it triggers editing by
     displaying the red minus sign icon on all rows. Tapping the minus sign displays the Delete button.
     The Delete button is handled in the method tableView: commitEditingStyle: forRowAtIndexPath:
     */
    
    // Instantiate an Add button (with plus sign icon) to invoke the addCity: method when tapped.
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc]
                                  initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                                  target:self action:@selector(addCity:)];
    
    // Set up the Add custom button on the right of the navigation bar
    self.navigationItem.rightBarButtonItem = addButton;
    
    // Obtain a sorted list of country names and store them in a mutable array
    NSMutableArray *sortedCountryNames = (NSMutableArray *)[[self.countryCities allKeys] sortedArrayUsingSelector:@selector(compare:)];
    
    // Set the mutable sorted array to countries
    self.countries = sortedCountryNames;
    
    // Instantiate the City Data object to pass to the downstream view controller
    self.cityData = [[NSMutableArray alloc] init];
    
    [super viewDidLoad];
}


#pragma mark - Add City Method

// The addCity: method is invoked when the user taps the Add button created at run time.
- (void)addCity:(id)sender
{
    // Perform the segue named AddCity
    [self performSegueWithIdentifier:@"AddCity" sender:self];
}


#pragma mark - AddCityViewControllerDelegate Protocol Method

/*
 This is the AddCityViewController's delegate method we created. AddCityViewController informs
 the delegate CityViewController that the user tapped the Save button if the parameter is YES.
 */
- (void)addCityViewController:(AddCityViewController *)controller didFinishWithSave:(BOOL)save
{
    if (save) {
        // Get the country name entered by the user on the AddCityViewController's UI
        NSString *countryNameEntered = controller.countryName.text;
        
        // Get the city name entered by the user on the AddCityViewController's UI
        NSString *cityNameEntered = controller.cityName.text;
        
        if ([self.countries containsObject:countryNameEntered]) {
            
            // Get the list of current cities for the country name entered
            NSMutableArray *citiesForCountryNameEntered = [self.countryCities objectForKey:countryNameEntered];
            
            // Add the new city to that list
            [citiesForCountryNameEntered addObject:cityNameEntered];
            
            // Set the new list of cities for the country name entered
            [self.countryCities setValue:citiesForCountryNameEntered forKey:countryNameEntered];
            
        }
        else {  // The entered country name does not exist in the current dictionary
            // Create a mutable array containing cityNameEntered
            NSMutableArray *citiesForCountryNameEntered = [NSMutableArray arrayWithObject:cityNameEntered];
            
            // Add the new country-city key-value pair to the countryCities mutable dictionary
            [self.countryCities setObject:citiesForCountryNameEntered forKey:countryNameEntered];
        }
        
        // Obtain a sorted list of country names and store them in a mutable array
        NSMutableArray *sortedCountryNames = (NSMutableArray *)[[self.countryCities allKeys]
                                                                sortedArrayUsingSelector:@selector(compare:)];
        
        self.countries = sortedCountryNames;  // Set the mutable sorted array to countries
        
        // Reload the rows and sections of the Table View countryCityTableView
        [self.countryCityTableView reloadData];
    }
    
    /*
     Pop the current view controller AddCityViewController from the stack
     and show the next view controller in the stack, which is ViewController.
     */
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark - UITableViewDataSource Protocol Methods

/*
 We are implementing a Grouped table view style. In the storyboard file,
 select the Table View. Under the Attributes Inspector, set the Style attribute to Grouped.
 */

// Each table view section corresponds to a country
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self.countries count];
}


// Number of cities is the number of rows in the given section (country)
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSString *markedCountry = [self.countries objectAtIndex:section];
    NSMutableArray *cities = [self.countryCities objectForKey:markedCountry];
    return [cities count];
}


// Set the table view section header
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [self.countries objectAtIndex:section];
}


// Set the table view section footer
- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section
{
    NSString *footer = [[NSString alloc] initWithFormat:@"My Favorite Cities in %@", [self.countries objectAtIndex:section]];
    return footer;
}


// Customize the appearance of the table view cells
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CityTableView"];
    
    // Configure the cell
    NSUInteger sectionNumber = [indexPath section];
    NSUInteger rowNumber = [indexPath row];
    
    NSString *markedCountry = [self.countries objectAtIndex:sectionNumber];
    NSMutableArray *markedCities = [self.countryCities objectForKey:markedCountry];
    
    /*
     Note that city names must not be sorted. The order shows how favorite the city is.
     The higher the order the more favorite the city is. The user specifies the ordering
     in the Edit mode by moving a row from one location to another for the same country.
     */
    cell.imageView.image = [UIImage imageNamed:@"favoriteIcon.png"];
    
    cell.textLabel.text = [markedCities objectAtIndex:rowNumber];
    
    /*
     Set up a detail disclosure button to be displayed on the right side of each row.
     The button is handled in the method tableView: accessoryButtonTappedForRowWithIndexPath:
     */
    cell.accessoryType = UITableViewCellAccessoryDetailButton;
    
    return cell;
}


// We allow each row (city) of the table view to be editable, i.e., deletable or movable
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}


// This is the method invoked when the user taps the Delete button in the Edit mode
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {  // Handle the Delete action
        
        NSString *countryOfCityToDelete = [self.countries objectAtIndex:[indexPath section]];
        NSMutableArray *currentCities = [self.countryCities objectForKey:countryOfCityToDelete];
        NSString *cityToDelete = [currentCities objectAtIndex:[indexPath row]];
        
        [currentCities removeObject:cityToDelete];  // Remove the city marked for delete
        
        if ([currentCities count] == 0) {
            // If no city exists in the currentCities array after deletion, then we need to also delete the country.
            [self.countryCities removeObjectForKey:countryOfCityToDelete];
            
            // Update the list of countries since one is deleted
            NSMutableArray *sortedCountryNames = (NSMutableArray *)[[self.countryCities allKeys]
                                                                    sortedArrayUsingSelector:@selector(compare:)];
            self.countries = sortedCountryNames;
        }
        else {
            // Set the new list of cities for the country
            [self.countryCities setValue:currentCities forKey:countryOfCityToDelete];
        }
        
        // Reload the rows and sections of the Table View countryCityTableView
        [self.countryCityTableView reloadData];
    }
}


/*
 This method is invoked to carry out the row (city) movement after the method
 tableView: targetIndexPathForMoveFromRowAtIndexPath: toProposedIndexPath: approved the move.
 */
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
    NSString *country = [self.countries objectAtIndex:[fromIndexPath section]];
    NSMutableArray *cities = [self.countryCities objectForKey:country];
    
    NSUInteger rowNumberFrom = fromIndexPath.row;
    NSUInteger rowNumberTo = toIndexPath.row;
    
    NSString *cityToMoveFrom = [cities objectAtIndex:rowNumberFrom];
    NSString *cityToMoveTo = [cities objectAtIndex:rowNumberTo];
    
    [cities replaceObjectAtIndex:rowNumberTo withObject:cityToMoveFrom];
    [cities replaceObjectAtIndex:rowNumberFrom withObject:cityToMoveTo];
    
    // After the change of order, set the countryCities dictionary with the new list of cities
    [self.countryCities setObject:cities forKey:country];
    
    // No need to reload the table view data since the view is updated automatically
}


// Allow the movement of each row (city)
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}


#pragma mark - UITableViewDelegate Protocol Methods

// Tapping a row (city) displays an alert panel informing the user for the selection
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *selectedCountryName = [self.countries objectAtIndex:[indexPath section]];
    NSMutableArray *citiesForSelectedCountry = [self.countryCities objectForKey:selectedCountryName];
    NSString *selectedCityName = [citiesForSelectedCountry objectAtIndex:[indexPath row]];
    
    // Prepare the city data object to pass to the downstream view controller
    [self.cityData insertObject:selectedCityName atIndex:0];
    [self.cityData insertObject:selectedCountryName atIndex:1];
    
    // Perform the segue named ShowCityDetail
    [self performSegueWithIdentifier:@"CityMap" sender:self];
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


// This is the method invoked when the user taps the detail accessory button
- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath
{
    NSString *selectedCountryName = [self.countries objectAtIndex:[indexPath section]];
    NSMutableArray *citiesForSelectedCountry = [self.countryCities objectForKey:selectedCountryName];
    NSString *selectedCityName = [citiesForSelectedCountry objectAtIndex:[indexPath row]];
    
    // Prepare the city data object to pass to the downstream view controller
    [self.cityData insertObject:selectedCityName atIndex:0];
    [self.cityData insertObject:selectedCountryName atIndex:1];
    
    // Perform the segue named ShowCityDetail
    [self performSegueWithIdentifier:@"CityWeb" sender:self];
}


// This method is invoked when the user attempts to move a row (city)
- (NSIndexPath *)tableView:(UITableView *)tableView targetIndexPathForMoveFromRowAtIndexPath:(NSIndexPath *)sourceIndexPath
       toProposedIndexPath:(NSIndexPath *)proposedDestinationIndexPath
{
    NSString *countryFrom = [self.countries objectAtIndex:[sourceIndexPath section]];
    NSString *countryTo = [self.countries objectAtIndex:[proposedDestinationIndexPath section]];
    
    if (countryFrom != countryTo) {
        
        // The user attempts to move a city from one country to another, which is prohibited
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle:@"Move Not Allowed"
                              message:@"Order cities according to your liking only within the same country!"
                              delegate:self cancelButtonTitle:@"Okay" otherButtonTitles:nil];
        [alert show];
        
        return sourceIndexPath;  // The row (city) movement is denied
    }
    else {
        return proposedDestinationIndexPath;  // The row (city) movement is approved
    }
}


#pragma mark - Preparing for Segue

// This method is called by the system whenever you invoke the method performSegueWithIdentifier:sender:
// You never call this method. It is invoked by the system.
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSString *segueIdentifier = [segue identifier];
    
    if ([segueIdentifier isEqualToString:@"AddCity"]) {
        
        // Obtain the object reference of the destination view controller
        AddCityViewController *addCityViewController = [segue destinationViewController];
        
        // Under the Delegation Design Pattern, set the addCityViewController's delegate to be self
        addCityViewController.delegate = self;
        
    } else if ([segueIdentifier isEqualToString:@"CityMap"]) {
        
        // Obtain the object reference of the destination view controller
        CityMapViewController *cityMapViewController = [segue destinationViewController];
        
        // Pass the cityData array obj ref to downstream CityMapViewController
        cityMapViewController.cityData = self.cityData;
        
    } else if ([segueIdentifier isEqualToString:@"CityWeb"]) {
        
        // Obtain the object reference of the destination view controller
        CityWebViewController *cityWebViewController = [segue destinationViewController];
        
        // Pass the cityData array obj ref to downstream CityWebViewController
        cityWebViewController.cityData = self.cityData;
    }
}

@end

