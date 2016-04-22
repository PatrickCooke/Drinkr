//
//  ViewController.m
//  Drinkr
//
//  Created by Patrick Cooke on 4/21/16.
//  Copyright © 2016 Patrick Cooke. All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate.h"
#import "Drink.h"
#import "Occasion.h"
#import "OccationViewController.h"
#import "OccuranceTableViewCell.h"

@interface ViewController ()


@property (nonatomic, strong) AppDelegate            *appDelegate;
@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, strong) NSArray                *occasionArray;
@property (nonatomic,weak)    IBOutlet UITableView   *ocassionTableView;

@end

@implementation ViewController


#pragma mark - Regularly Occuring Methods

-(void) refreshDataAndTable {
    _occasionArray=[self fetchOccasion];
    [_ocassionTableView reloadData];
     }



#pragma mark - Table View Methods
- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _occasionArray.count;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    OccuranceTableViewCell *cell = (OccuranceTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"OccCell" forIndexPath:indexPath];
    Occasion *currentOccasion = _occasionArray[indexPath.row ];
    //cell.textLabel.text = currentOccasion.occasionName;
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"MMMM d, yyyy";
    cell.dateLabel.text = [formatter stringFromDate:currentOccasion.occasionDate];
    cell.nameLabel.text = currentOccasion.occasionName;
    cell.drinksLabel.text = [NSString stringWithFormat:@"%li",[[currentOccasion.relationshipOccassionToDrink allObjects] count]];
    
    //cell.detailTextLabel.text = [formatter stringFromDate:currentOccasion.occasionDate];
    return cell;
}
-(double)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100.0;
}

//the follow code (BOOL, void, and NSArray) is for swip to delete functionality
-(BOOL) tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return true;
}
-(void) tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
}
-(NSArray *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    UITableViewRowAction *deleteAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive title:@"Delete" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        NSLog(@"delete");
        Occasion *occasionToDelete = _occasionArray[indexPath.row];
        [_managedObjectContext deleteObject:occasionToDelete];
        [_appDelegate saveContext];
        [self refreshDataAndTable];
    }];
    return @[deleteAction];
}


#pragma mark - Segue
-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    OccationViewController *destcontroller = [segue destinationViewController];
    if ([[segue identifier] isEqualToString:@"editOccasionSegue"]) {
        NSIndexPath *indexPath = [_ocassionTableView indexPathForSelectedRow];
        Occasion *selectedOccasion = _occasionArray[indexPath.row];
        destcontroller.currentOccasion = selectedOccasion;
    } else if ([[segue identifier] isEqualToString:@"addOccasionSegue"]) {
        destcontroller.currentOccasion=nil;
    }
}

#pragma mark - Temp Data Creation/Fetch

- (void)tempAddRecords { //creates command to fill database with temp info
    Occasion *newoccasion = (Occasion *) [NSEntityDescription insertNewObjectForEntityForName:@"Occasion" inManagedObjectContext:_managedObjectContext];
    [newoccasion setOccasionDate:[NSDate date]];
    [newoccasion setOccasionLon:@"-83.323451"];
    [newoccasion setOccasionName: @"Ted's HouseParty"];
    [newoccasion setOccasionLat:@"42.591832"];
    
    Occasion *newoccasion2 = (Occasion *) [NSEntityDescription insertNewObjectForEntityForName:@"Occasion" inManagedObjectContext:_managedObjectContext];
    [newoccasion2 setOccasionDate:[NSDate date]];
    [newoccasion2 setOccasionLon:@"-83.047633"];
    [newoccasion2 setOccasionName: @"Iron Pints"];
    [newoccasion2 setOccasionLat:@"42.332013"];
    
     Occasion *newoccasion3 = (Occasion *) [NSEntityDescription insertNewObjectForEntityForName:@"Occasion" inManagedObjectContext:_managedObjectContext];
    [newoccasion3 setOccasionDate:[NSDate date]];
    [newoccasion3 setOccasionLon:@"42.591832"];
    [newoccasion3 setOccasionName: @"Getting to know you Party"];
    [newoccasion3 setOccasionLat:@"-83.323451"];
    Drink *drink1 = (Drink *)[NSEntityDescription insertNewObjectForEntityForName:@"Drink" inManagedObjectContext:_managedObjectContext];
    [drink1 setDrinkName:@"budlight"];
    [drink1 setDrinkABV:@"12"];
    [drink1 setDrinkAmount:@"2"];
    [drink1 setDrinkDate: [NSDate date]];
    drink1.relationshipDrinkToOccassion = newoccasion;

    Drink *drink2 = (Drink *)[NSEntityDescription insertNewObjectForEntityForName:@"Drink" inManagedObjectContext:_managedObjectContext];
    [drink2 setDrinkName:@"coors"];
    [drink2 setDrinkABV:@"12"];
    [drink2 setDrinkAmount:@"12"];
    [drink2 setDrinkDate: [NSDate date]];
    drink2.relationshipDrinkToOccassion = newoccasion;
      
    Drink *drink3 = (Drink *)[NSEntityDescription insertNewObjectForEntityForName:@"Drink" inManagedObjectContext:_managedObjectContext];
      [drink3 setDrinkName:@"bud"];
      [drink3 setDrinkABV:@"12"];
      [drink3 setDrinkAmount:@"12"];
      [drink3 setDrinkDate: [NSDate date]];
      drink3.relationshipDrinkToOccassion = newoccasion2;
    
    [_appDelegate saveContext]; //saves into persistent memory
}

- (NSArray*)fetchOccasion {
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Occasion" inManagedObjectContext:_managedObjectContext];
    [fetchRequest setEntity:entity];
    //this area up sets up the core Fetch
    //this code creates a sort descriptor
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"occasionDate" ascending:true];
    [fetchRequest setSortDescriptors:@[sortDescriptor]]; //writing "@[sortDescriptor] creates an array on the spot
    
    
    
    //this part below runs the fetch
    NSError *error;
    NSArray *fetchResults = [_managedObjectContext executeFetchRequest:fetchRequest error:&error];
    return fetchResults;
}



#pragma mark - Life Cycle Methods

- (void)viewDidLoad {
    [super viewDidLoad];
    _appDelegate = [[UIApplication sharedApplication] delegate];
    _managedObjectContext = _appDelegate.managedObjectContext;
//    [self tempAddRecords];
    NSLog(@"Occasions %li",_occasionArray.count);
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self refreshDataAndTable];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
