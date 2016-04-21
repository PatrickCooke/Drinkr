//
//  Drink+CoreDataProperties.m
//  Drinkr
//
//  Created by Patrick Cooke on 4/21/16.
//  Copyright © 2016 Patrick Cooke. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Drink+CoreDataProperties.h"

@implementation Drink (CoreDataProperties)

@dynamic drinkName;
@dynamic drinkAmount;
@dynamic drinkABV;
@dynamic drinkDate;
@dynamic relationshipDrinkToOccassion;

@end
