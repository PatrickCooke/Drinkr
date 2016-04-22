//
//  DrinkViewController.m
//  Drinkr
//
//  Created by Patrick Cooke on 4/22/16.
//  Copyright © 2016 Patrick Cooke. All rights reserved.
//

#import "DrinkViewController.h"
#import "AppDelegate.h"


@interface DrinkViewController ()

@property (nonatomic,strong)       AppDelegate  *appDelegate;
@property (nonatomic,strong)       NSManagedObjectContext *managedObjectContext;
@property(nonatomic,weak) IBOutlet UITextField   *drinkNameTextField;
@property(nonatomic,weak) IBOutlet UITextField   *drinkAmountTextField;
@property(nonatomic,weak) IBOutlet UITextField   *drinkABVTextField;
@property(nonatomic,weak) IBOutlet UIDatePicker   *drinkDatePicker;
@end

@implementation DrinkViewController

#pragma mark - Interactivity Methods

-(void)saveAndPop {
    [_appDelegate saveContext];
    [self.navigationController popViewControllerAnimated:true];
}

-(IBAction)deleteButtonPressed:(id)sender {
    NSLog(@"Delete");
    [_managedObjectContext deleteObject:_currentDrink];
    [self saveAndPop];
}

-(IBAction)saveButtonPressed:(id)sender {
    NSLog(@"save");
    _currentDrink.drinkName = _drinkNameTextField.text;
    _currentDrink.drinkAmount = _drinkAmountTextField.text;
    _currentDrink.drinkABV = _drinkABVTextField.text;
    _currentDrink.drinkDate = _drinkDatePicker.date;
    [self saveAndPop];
}


#pragma mark Life Cycle Methods

- (void)viewDidLoad {
    [super viewDidLoad];
    _appDelegate = [[UIApplication sharedApplication] delegate];
    _managedObjectContext = _appDelegate.managedObjectContext;
}

- (void)viewWillAppear:(BOOL)animated {
    if (_currentDrink == nil) {
        Drink *newdrink = (Drink *) [NSEntityDescription insertNewObjectForEntityForName:@"Drink" inManagedObjectContext:_managedObjectContext];
        _currentDrink=newdrink;
        _drinkNameTextField.text = @"";
        _drinkAmountTextField.text = @"";
        _drinkABVTextField.text = @"";
        _drinkDatePicker.date = [NSDate date];
    } else {
        _drinkNameTextField.text = _currentDrink.drinkName;
        _drinkAmountTextField.text = _currentDrink.drinkAmount;
        _drinkABVTextField.text = _currentDrink.drinkABV;
        _drinkDatePicker.date = _currentDrink.drinkDate;
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
