//
//  HubViewController.m
//  Remember
//
//  Created by Lea Marolt on 1/12/14.
//  Copyright (c) 2014 Lea Marolt Sonnenschein. All rights reserved.
//

#import "HubViewController.h"
#import "FirstViewController.h"
#import <Parse/Parse.h>

@interface HubViewController () {
    int num;
    int gamesToday;
}

@end

@implementation HubViewController {
    NSString *name;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    PFUser *currentUser = [PFUser currentUser];
    name = [currentUser objectForKey:@"name"];
    
    self.welcomeLabel.text = [NSString stringWithFormat:@"Welcome back, %@!", name];
}

- (void) viewDidAppear:(BOOL)animated {
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSLog(@"Games played today: %i", [userDefaults integerForKey:@"GamesToday"]);
    
    self.gamesPlayed.text = [NSString stringWithFormat:@"%i", [userDefaults integerForKey:@"GamesToday"]];
    
    [self resetNumOfGamesPlayedInDay];

}

- (void) resetNumOfGamesPlayedInDay {
    
    // get the current time, to know when the next day starts to reset the amount
    // of total games played during  the day back to 0
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDate *today = [NSDate date];
    NSDateComponents *components = [calendar components:(NSDayCalendarUnit | NSMonthCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit) fromDate:today];
    
    int hour = [components hour];
    int minute = [components minute];
    int seconds = [components second];
    
    float timeToReset = 24*60*60 - hour*60*60 - minute*60 - seconds;
    
    [NSTimer scheduledTimerWithTimeInterval:timeToReset
                                     target:self
                                   selector:@selector(setGamesPlayedToZeroOnNewDay)
                                   userInfo:nil
                                    repeats:NO];
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    BOOL firstRunOfDay = [userDefaults boolForKey:@"firstRunOfDay"];
    if (firstRunOfDay) {
        [userDefaults setBool:NO forKey:@"firstRunOfDay"];
        gamesToday = 0;
        [userDefaults setInteger:gamesToday forKey:@"GamesToday"];
    }
}

- (void) setGamesPlayedToZeroOnNewDay {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setInteger:0 forKey:@"GamesToday"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"gameSegue"]) {
        FirstViewController *fvc = [segue destinationViewController];
        
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        BOOL firstRunOfDay = [userDefaults boolForKey:@"firstRunOfDay"];
        if (firstRunOfDay) {
            fvc.games = num;
        }
    
    }
    
}

- (void)recieveDataForGamesPlayed:(int) games andGamesWon:(int)gamesWon; {
    // get the amount od games played during the last session, and adds it to the total
    // amount of games played today
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    gamesToday = [userDefaults integerForKey:@"GamesToday"] + games;
    //NSLog(@"games played today: %i", gamesToday);
    [userDefaults setInteger:gamesToday forKey:@"GamesToday"];
    
    //NSLog(@"Games won today: %i", gamesWon);
}

- (void) recieveDataForDailyeDare:(BOOL)dareCompleted {
    
}


@end
