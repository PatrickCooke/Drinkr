//
//  DrinkViewController.h
//  Drinkr
//
//  Created by Patrick Cooke on 4/22/16.
//  Copyright © 2016 Patrick Cooke. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Drink.h"

@interface DrinkViewController : UIViewController

@property (nonatomic,strong) Occasion *currentOccasion;
@property (nonatomic,strong) Drink *currentDrink;

@end
