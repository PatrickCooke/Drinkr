//
//  OccationViewController.m
//  Drinkr
//
//  Created by Patrick Cooke on 4/21/16.
//  Copyright © 2016 Patrick Cooke. All rights reserved.
//

#import "OccationViewController.h"
#import "DrinkViewController.h"
#import "AppDelegate.h"
#import "Occasion.h"
#import "Drink.h"

@interface OccationViewController ()

@property (nonatomic,strong)        AppDelegate  *appDelegate;
@property (nonatomic,strong)    NSManagedObjectContext *managedObjectContext;
@property(nonatomic,weak) IBOutlet UITextField   *occasionName;
@property(nonatomic,weak) IBOutlet UIDatePicker  *occasionDate;
@property(nonatomic,weak) IBOutlet UITextField   *occasionLat;
@property(nonatomic,weak) IBOutlet UITextField   *occasionLon;
@property(nonatomic,weak) IBOutlet UITableView   *drinkTableView;
@property(nonatomic,strong)        NSArray       *drinkArray;

@end

@implementation OccationViewController

#pragma mark - TableView Methods

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _drinkArray.count;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *dcell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    Drink *currentdrink = _drinkArray[indexPath.row];
    dcell.textLabel.text = currentdrink.drinkName;
    dcell.detailTextLabel.text = currentdrink.drinkABV;
    return dcell;
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
        Drink *drinkToDelete = _drinkArray[indexPath.row];
        [_managedObjectContext deleteObject:drinkToDelete];
        [_appDelegate saveContext];
    }];
    return @[deleteAction];
}


#pragma mark - Reoccuring Methods

-(void)saveAndPop {
    [_appDelegate saveContext];
    [self.navigationController popViewControllerAnimated:true];
}
#pragma mark - Interactivity Methods
-(IBAction)deleteButtonPressed:(id)sender {
    NSLog(@"Delete");
    [_managedObjectContext deleteObject:_currentOccasion];
    [self saveAndPop];
}

-(IBAction)saveButtonPressed:(id)sender {
    NSLog(@"save");
    _currentOccasion.occasionName = _occasionName.text;
    _currentOccasion.occasionLat = _occasionLat.text;
    _currentOccasion.occasionLon = _occasionLon.text;
    _currentOccasion.occasionDate = _occasionDate.date;
    [self saveAndPop];
}

#pragma mark - Drink Segue

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    DrinkViewController *destcontroller = [segue destinationViewController];
    if ([[segue identifier] isEqualToString:@"editDrinkSegue"]) {
        NSIndexPath *indexPath = [_drinkTableView indexPathForSelectedRow];
        Drink *selectedDrink = _drinkArray[indexPath.row];
        destcontroller.currentDrink = selectedDrink;
    } else if ([[segue identifier] isEqualToString:@"addDrinkSegue"]) {
        destcontroller.currentDrink=nil;
    }
}

#pragma mark - Life Cycle Methods
- (void)viewDidLoad {
    [super viewDidLoad];
    _appDelegate = [[UIApplication sharedApplication] delegate];
    _managedObjectContext = _appDelegate.managedObjectContext;
}

-(void)viewWillAppear:(BOOL)animated {
    if (_currentOccasion == nil) {
        Occasion *newoccasion = (Occasion *) [NSEntityDescription insertNewObjectForEntityForName:@"Occasion" inManagedObjectContext:_managedObjectContext];
        _currentOccasion=newoccasion;
        _occasionName.text = @"";
        _occasionLat.text = @"";
        _occasionLon.text = @"";
        _occasionDate.date = [NSDate date];
    } else {
        _occasionName.text = _currentOccasion.occasionName;
        _occasionLat.text = _currentOccasion.occasionLat;
        _occasionLon.text = _currentOccasion.occasionLon;
        _occasionDate.date = _currentOccasion.occasionDate;
        _drinkArray = [_currentOccasion.relationshipOccassionToDrink allObjects];
        [_drinkTableView reloadData];
    }
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    if ([_managedObjectContext hasChanges]) {
        [_managedObjectContext rollback];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
