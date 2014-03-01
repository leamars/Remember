//
//  StatisticsViewController.m
//  Remember
//
//  Created by Lea Marolt on 1/14/14.
//  Copyright (c) 2014 Lea Marolt Sonnenschein. All rights reserved.
//

#import "StatisticsViewController.h"
#import "PNChart.h"
#import <Parse/Parse.h>

@interface StatisticsViewController () {
    NSArray *gamesTotal;
    NSArray *gamesWon;
    NSArray *dailyDares;
}

@end

@implementation StatisticsViewController

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
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) viewDidAppear:(BOOL)animated {
    PFUser *currentUser = [PFUser currentUser];
    gamesTotal = [currentUser objectForKey:@"gamesToday"];
    gamesWon = [currentUser objectForKey:@"gamesWonToday"];
    dailyDares = [currentUser objectForKey:@"dailyDareWon"];
    
    NSLog(@"daily dares we get: %@", dailyDares);
    
    
    // set up x and y labels for the graph
    
    NSArray *yLabels = [self getWeeklyValuesArray];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *comps = [NSDateComponents new];
    NSDate *today = [calendar dateByAddingComponents:comps toDate:[NSDate date] options:0];
    NSDateComponents *components;
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MMM dd"];
    NSString *dayString;
    NSMutableArray *days = [[NSMutableArray alloc] init];
    NSDate *date;
    for (int i = 0; i < [yLabels count]; i++) {
        date = [today dateByAddingTimeInterval:-i * 60 * 60 * 24]; ;
        components = [calendar components:NSMonthCalendarUnit|NSDayCalendarUnit fromDate:date];
        dayString = [formatter stringFromDate:date];
        [days addObject:dayString];
    }
    
    // set up color
    float red = 62.0 / 255;
    float green = 156.0 / 255;
    float blue = 162.0 / 255;
    UIColor *color = [UIColor colorWithRed:red green:green blue:blue alpha:1.0];
    
    // GAMES WON IN A DAY GRAPH
    PNBarChart *wonChart = [[PNBarChart alloc] initWithFrame:CGRectMake(0, 95.0, SCREEN_WIDTH, 200.0)];
    [wonChart setXLabels:days];
    [wonChart setYValues:yLabels];
    [wonChart setStrokeColor:color];
    
    UILabel *wonChartLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 50, SCREEN_WIDTH, 30)];
    wonChartLabel.text = @"Games won";
    wonChartLabel.textColor = color;
    wonChartLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:30.0];
    wonChartLabel.textAlignment = NSTextAlignmentCenter;
    
    [self.view addSubview:wonChartLabel];
    [self.view addSubview:wonChart];
    [wonChart strokeChart];
    
    NSArray *dareYLabels = [self getDareArray];
    
    NSLog(@"DARE Y LABELS: %@", dareYLabels);
    
    // DARE GRAPH
    PNBarChart *dareChart = [[PNBarChart alloc] initWithFrame:CGRectMake(0, 375.0, SCREEN_WIDTH, 200.0)];
    [dareChart setXLabels:days];
    [dareChart setYValues:dareYLabels];
    [dareChart setStrokeColor:color];
    
    UILabel *dareChartLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 330, SCREEN_WIDTH, 30)];
    dareChartLabel.text = @"Daily dares";
    dareChartLabel.textColor = color;
    dareChartLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:30.0];
    dareChartLabel.textAlignment = NSTextAlignmentCenter;
    
    [self.view addSubview:dareChartLabel];
    [self.view addSubview:dareChart];
    [dareChart strokeChart];
    
}

- (IBAction)goBack:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (NSArray *) getDareArray {
    NSMutableArray *dareArray = [[NSMutableArray alloc] init];
    int numOfItems;
    int value;
    
    if ([dailyDares count] < 7) {
        numOfItems = [dailyDares count];
    }
    else {
        numOfItems = [dailyDares count];
    }
    
    for (int i = 1; i < 8; i++) {
        [dareArray addObject:dailyDares[numOfItems - i]];
    }
    
    return dareArray;
}

- (NSArray *) getWeeklyValuesArray {
    NSMutableArray *weeklyValues = [[NSMutableArray alloc] init];
    int lastItem = [gamesTotal count] - 1;
    int numOfItems;
    
    if ([gamesTotal count] < 7) {
        numOfItems = [gamesTotal count];
    }
    
    else {
        numOfItems = 7;
    }
    float value;
    
    for (int i = 0; i < numOfItems; i++) {
        
        NSNumber *total = gamesTotal[lastItem - i];
        NSNumber *won = gamesWon[lastItem - i];
        if ([total intValue] == 0 || [won intValue] == 0) {
            value = 0;
        }
        else {
            value = [total floatValue] / [won floatValue];
        }
        [weeklyValues addObject:[NSNumber numberWithFloat:value]];
    }
    return weeklyValues;
}

@end
