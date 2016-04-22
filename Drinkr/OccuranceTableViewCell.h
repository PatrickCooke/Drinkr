//
//  OccuranceTableViewCell.h
//  Drinkr
//
//  Created by Patrick Cooke on 4/22/16.
//  Copyright © 2016 Patrick Cooke. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OccuranceTableViewCell : UITableViewCell

@property(nonatomic,weak) IBOutlet UILabel *dateLabel;
@property(nonatomic,weak) IBOutlet UILabel *nameLabel;
@property(nonatomic,weak) IBOutlet UILabel *drinksLabel;

@end
