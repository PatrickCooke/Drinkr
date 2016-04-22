//
//  Drink+CoreDataProperties.h
//  Drinkr
//
//  Created by Patrick Cooke on 4/22/16.
//  Copyright © 2016 Patrick Cooke. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Drink.h"

NS_ASSUME_NONNULL_BEGIN

@interface Drink (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *drinkName;
@property (nullable, nonatomic, retain) NSString *drinkAmount;
@property (nullable, nonatomic, retain) NSString *drinkABV;
@property (nullable, nonatomic, retain) NSDate *drinkDate;
@property (nullable, nonatomic, retain) Occasion *relationshipDrinkToOccassion;

@end

NS_ASSUME_NONNULL_END
