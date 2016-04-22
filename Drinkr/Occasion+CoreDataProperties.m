//
//  Occasion+CoreDataProperties.m
//  Drinkr
//
//  Created by Patrick Cooke on 4/22/16.
//  Copyright © 2016 Patrick Cooke. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Occasion+CoreDataProperties.h"

@implementation Occasion (CoreDataProperties)

@dynamic occasionDate;
@dynamic occasionName;
@dynamic occasionLat;
@dynamic occasionLon;
@dynamic relationshipOccassionToDrink;

@end
