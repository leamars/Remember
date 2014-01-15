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
    NSNumber *shapeWithShapeAndColor;
    NSNumber *wordWithTextAndColor;
    NSMutableArray *optionsArr;
    BOOL chosenOption;
    CGFloat hue;
    CGFloat brightness;
    CGFloat saturation;
    BOOL acceptedDare;
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

    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *dict = [defaults dictionaryRepresentation];
    
    NSLog(@"My defaults: %@", dict);
    
    if (!acceptedDare) {
        [self setUpDailyDare];
    }
    

}

- (void) viewDidAppear:(BOOL)animated {
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSLog(@"Games played today: %i", [userDefaults integerForKey:@"GamesToday"]);
    
    self.gamesPlayed.text = [NSString stringWithFormat:@"%i", [userDefaults integerForKey:@"GamesToday"]];
    
    [self animateSmiley];
    
    [NSTimer scheduledTimerWithTimeInterval:2.8
                                     target:self
                                   selector:@selector(smileyToWinky)
                                   userInfo:nil
                                    repeats:NO];
}

- (void) viewWillAppear:(BOOL)animated {
    self.smileyView.image = [UIImage imageNamed:@"smiley"];
}

- (void) smileyToWinky {
    self.smileyView.image = [UIImage imageNamed:@"winky"];
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

- (void) animateSmiley {
    CABasicAnimation*    layerAnimation = [CABasicAnimation animationWithKeyPath:@"transform"];
    layerAnimation.duration = 0.8;
    layerAnimation.beginTime = CACurrentMediaTime() + 2;
    layerAnimation.valueFunction = [CAValueFunction functionWithName:kCAValueFunctionRotateZ];
    layerAnimation.timingFunction = [CAMediaTimingFunction
                                     functionWithName:kCAMediaTimingFunctionLinear];
    layerAnimation.fromValue = [NSNumber numberWithFloat:0.0];
    layerAnimation.toValue = [NSNumber numberWithFloat:6];
    layerAnimation.byValue = [NSNumber numberWithFloat:1];
    [self.smileyView.layer addAnimation:layerAnimation forKey:@"layerAnimation"];
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
        [self saveInfoInUserDefaults];
    }
    
    [self setUpDailyOption];

}

- (void) setUpDailyAnswersView {
    
}

- (Option *)setUpDailyOption {
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    int shape = [userDefaults integerForKey:@"randomShape"];
    int word = [userDefaults integerForKey:@"randomWord"];
    
    int iH = [userDefaults integerForKey:@"hue"];
    int iS = [userDefaults integerForKey:@"saturation"];
    int iB = [userDefaults integerForKey:@"brightness"];
    
    CGFloat h = iH / 255.0;
    CGFloat s = iS / 255.0;
    CGFloat b = iB / 255.0;
    
    UIColor *color = [UIColor colorWithHue:h saturation:s brightness:b alpha:1.0];
    
    dailyOption = [[Option alloc] optionWithShape:[UIImage imageNamed:theShapes[shape]] andWord:theWords[word] andColor:color];
    
    return dailyOption;
}

- (UIColor *)randomColor
{
    hue = (arc4random() % 256 / 256.0f);
    saturation = (arc4random() % 128 / 256.0f) + 0.5f;
    brightness = (arc4random() % 128 / 256.0f) + 0.5f;
    UIColor *color = [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:1.0f];
    
    return color;
}

- (void) saveInfoInUserDefaults {
    shapeWithShapeAndColor = [NSNumber numberWithBool:YES];
    wordWithTextAndColor = [NSNumber numberWithBool:YES];
    
    optionsArr = [[NSMutableArray alloc] init];
    
    [optionsArr addObject:shapeWithShapeAndColor];
    [optionsArr addObject:wordWithTextAndColor];
    
    randomWord = arc4random()% ([theWords count] - 1);
    randomShape = arc4random()% ([theShapes count] - 1);
    randomColor = [self randomColor];
    
    // converting the color into CGFloats, and then ints, so it can be stores in
    // NSUserdefaults, and then converted back to the correct color
    // There's probably an easier way to do this using categories, but everything I've
    // found up to now deals with RGB nos HSB
    
    CGFloat hFloat,sFloat,bFloat,aFloat;
    [randomColor getHue:&hFloat saturation:&sFloat brightness:&bFloat alpha:&aFloat];
    
    int h, s, b;
    
    h = (int)(255.0 * hFloat);
    s = (int)(255.0 * sFloat);
    b = (int)(255.0 * bFloat);
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setInteger:randomWord forKey:@"randomWord"];
    [userDefaults setInteger:randomShape forKey:@"randomShape"];
    [userDefaults setInteger:h forKey:@"hue"];
    [userDefaults setInteger:s forKey:@"saturation"];
    [userDefaults setInteger:b forKey:@"brightness"];

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
        ddvc.selectedOption = chosenOption;
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

- (void) recieveDataForDailyeDare:(BOOL)dareAccepted {
    acceptedDare = dareAccepted;
}


@end
