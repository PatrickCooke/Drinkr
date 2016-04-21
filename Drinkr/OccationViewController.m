//
//  OccationViewController.m
//  Drinkr
//
//  Created by Patrick Cooke on 4/21/16.
//  Copyright © 2016 Patrick Cooke. All rights reserved.
//

#import "OccationViewController.h"
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

@end

@implementation OccationViewController

#pragma mark - TableView Methods


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



#pragma mark - Drink Table Methods




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
