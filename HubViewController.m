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
#import "Option.h"
#import "DailyDareViewController.h"

@interface HubViewController () {
    int num;
    int gamesToday;
}

@end

@implementation HubViewController {
    NSString *name;
    NSArray *theWords;
    NSArray *theShapes;
    int randomWord;
    int randomShape;
    UIColor *randomColor;
    Option *dailyOption;
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
    
    theWords = [[NSMutableArray alloc] initWithObjects:@"bird", @"snake", @"table", @"keys", @"picture", @"radio", @"folder", @"hanger", @"post", @"cucumber", @"elephant", @"crocodile", @"plastic", @"mortgage", @"sinister", @"sleep", @"park", @"prison", @"level", @"smile", @"stop", @"spot", @"elastic", @"gorge", @"mister", @"slap", @"fonder", @"hamper", @"rake", @"lake", @"letter", @"better", @"dark", @"eagle", @"eager", nil];
    
    theShapes = [[NSMutableArray alloc] initWithObjects:@"circleEmptyReverse", @"triangleEmptyReverse", @"squareEmptyReverse", @"circleFullReverse", @"triangleFullReverse", @"squareFullReverse", nil];
}

- (void) viewDidAppear:(BOOL)animated {
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSLog(@"Games played today: %i", [userDefaults integerForKey:@"GamesToday"]);
    
    self.gamesPlayed.text = [NSString stringWithFormat:@"%i", [userDefaults integerForKey:@"GamesToday"]];
    
    [self setUpDailyDare];
    [self resetNumOfGamesPlayedInDay];

}

- (float)timeToDailyReset {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDate *today = [NSDate date];
    NSDateComponents *components = [calendar components:(NSDayCalendarUnit | NSMonthCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit) fromDate:today];
    
    int hour = [components hour];
    int minute = [components minute];
    int seconds = [components second];
    
    float timeToReset = 24*60*60 - hour*60*60 - minute*60 - seconds;

    return timeToReset;
}

- (void) resetNumOfGamesPlayedInDay {
    
    // get the current time, to know when the next day starts to reset the amount
    // of total games played during  the day back to 0
    
    float timeToReset = [self timeToDailyReset];
    
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
    [userDefaults setBool:YES forKey:@"firstRunOfDay"];
}

- (void) setUpDailyDare {
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    BOOL firstRunOfDay = [userDefaults boolForKey:@"firstRunOfDay"];
    if (firstRunOfDay) {
        [self setUpDailyOption];
    }
}

- (Option *)setUpDailyOption {
    
    NSArray *bools = 
    
    randomWord = arc4random()% ([theWords count] - 1);
    randomShape = arc4random()% ([theShapes count] - 1);
    randomColor = [self randomColor];
    
    dailyOption = [[Option alloc] optionWithShape:[UIImage imageNamed:theShapes[randomShape]] andWord:theWords[randomWord] andColor:randomColor];
    
    return dailyOption;
}

- (UIColor *)randomColor
{
    CGFloat hue = (arc4random() % 256 / 256.0f);
    CGFloat saturation = (arc4random() % 128 / 256.0f) + 0.5f;
    CGFloat brightness = (arc4random() % 128 / 256.0f) + 0.5f;
    UIColor *color = [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:1.0f];
    
    return color;
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
    
    if ([segue.identifier isEqualToString:@"dailyDareSegue"]) {
        DailyDareViewController *ddvc = [segue destinationViewController];
        
        ddvc.recievedDailyOption = dailyOption;
        NSLog(@"Daily options is: %@", [dailyOption description]);
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
