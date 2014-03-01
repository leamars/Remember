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

@interface HubViewController : UIViewController <SelectionViewControllerDelegate,DailyDareViewControllerDelegate, FirstViewControllerDelegate>

@property (strong, nonatomic) IBOutlet UILabel *welcomeLabel;
@property (strong, nonatomic) IBOutlet UILabel *gamesPlayed;
@property (strong, nonatomic) IBOutlet UILabel *dailyDareState;
@property (strong, nonatomic) IBOutlet UIImageView *smileyView;
@property BOOL acceptedDare;

- (void)recieveDataForGamesPlayed:(int) games andGamesWon:(int)gamesWon;
- (void) recieveDataForDailyeDare:(BOOL)dareAccepted;
- (void)recieveOverallData:(int) gamesToday andWonData:(int) gamesWon;

@end
