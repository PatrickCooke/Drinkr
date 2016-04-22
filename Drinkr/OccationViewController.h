//
//  OccationViewController.h
//  Drinkr
//
//  Created by Patrick Cooke on 4/21/16.
//  Copyright © 2016 Patrick Cooke. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Drink.h"

@interface OccationViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic,strong) Occasion *currentOccasion;
@property (nonatomic,strong) Drink *currentDrink;

@end
