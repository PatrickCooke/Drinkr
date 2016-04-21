//
//  Occasion+CoreDataProperties.h
//  Drinkr
//
//  Created by Patrick Cooke on 4/21/16.
//  Copyright © 2016 Patrick Cooke. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Occasion.h"

NS_ASSUME_NONNULL_BEGIN

@interface Occasion (CoreDataProperties)

@property (nullable, nonatomic, retain) NSDate *occasionDate;
@property (nullable, nonatomic, retain) NSString *occasionName;
@property (nullable, nonatomic, retain) NSString *occasionLat;
@property (nullable, nonatomic, retain) NSString *occasionLon;
@property (nullable, nonatomic, retain) NSSet<Drink *> *relationshipOccassionToDrink;

@end

@interface Occasion (CoreDataGeneratedAccessors)

- (void)addRelationshipOccassionToDrinkObject:(Drink *)value;
- (void)removeRelationshipOccassionToDrinkObject:(Drink *)value;
- (void)addRelationshipOccassionToDrink:(NSSet<Drink *> *)values;
- (void)removeRelationshipOccassionToDrink:(NSSet<Drink *> *)values;

@end

NS_ASSUME_NONNULL_END
