//
//  HubViewController.h
//  Remember
//
//  Created by Lea Marolt on 1/12/14.
//  Copyright (c) 2014 Lea Marolt Sonnenschein. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FirstViewController.h"
#import "SelectionViewController.h"
#import "DailyDareViewController.h"

@interface HubViewController : UIViewController <SelectionViewControllerDelegate,DailyDareViewControllerDelegate>

@property (strong, nonatomic) IBOutlet UILabel *numOfPlays;
@property (strong, nonatomic) IBOutlet UILabel *welcomeLabel;
@property (strong, nonatomic) IBOutlet UILabel *gamesPlayed;

- (void)recieveDataForGamesPlayed:(int) games andGamesWon:(int)gamesWon;
- (void) recieveDataForDailyeDare:(BOOL)dareCompleted;

@end
