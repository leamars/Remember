//
//  SelectionViewController.m
//  Remember
//
//  Created by Lea Marolt on 1/10/14.
//  Copyright (c) 2014 Lea Marolt Sonnenschein. All rights reserved.
//

#import "SelectionViewController.h"
#import "HubViewController.h"
#import "Option.h"
#import <Parse/Parse.h>
#import "SettingsViewController.h"

@interface SelectionViewController () {
    int answer;
    NSArray *possibleColors;
    NSArray *possibleShapes;
    NSArray *possibleWords;
    Option *opt1;
    Option *opt2;
    Option *opt3;
    UIImage *answerImage;
    int won;
}

@end

@implementation SelectionViewController

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
    NSLog(@"who is my current user in selection? %@", currentUser);
    
    answer = arc4random() % 3;
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    BOOL firstSelectionRunOfDay = [userDefaults boolForKey:@"firstSelectionRunOfDay"];
    NSLog(@"first selection run of day: %hhd", firstSelectionRunOfDay);
    if (firstSelectionRunOfDay) {
        NSLog(@"Games won today: %i", won);
        [userDefaults setBool:NO forKey:@"firstSelectionRunOfDay"];
        won = 0;
        [userDefaults setInteger:won forKey:@"GamesWonToday"];
    }
    else if (!firstSelectionRunOfDay) {
        won = [userDefaults integerForKey:@"GamesWonToday"];
        NSLog(@"Games won today: %i", won);
    }
}

- (void) viewDidAppear:(BOOL)animated {
}

- (void)viewWillAppear:(BOOL)animated {
    
    
    //[self setRandomShapesForNum:shapeNumber forBtn1:self.selection1 Btn2:self.selection2 Btn3:self.selection3];
    //[self setRandomColorsForNum:colorNumber];
    
    NSArray *possibleAnswers = [self createPossibleAnswers];
    
    opt1 = possibleAnswers[0];
    opt2 = possibleAnswers[1];
    opt3 = possibleAnswers[2];
    
    if (self.shapeVersion) {
        
        [self.selection1 setBackgroundImage: opt1.shape forState:UIControlStateNormal];
        [self.selection2 setBackgroundImage: opt2.shape forState:UIControlStateNormal];
        [self.selection3 setBackgroundImage: opt3.shape forState:UIControlStateNormal];
        
        [self.selection1 setBackgroundColor:opt1.color];
        [self.selection2 setBackgroundColor:opt2.color];
        [self.selection3 setBackgroundColor:opt3.color];
        
        [self.selection1 setHighlighted:NO];
        [self.selection2 setHighlighted:NO];
        [self.selection3 setHighlighted:NO];
        
    }
    else {
        // span button title for more than 1 line if needed
        
        [self setUpWordButtonForOption:opt1 forButton:self.selection1];
        [self setUpWordButtonForOption:opt2 forButton:self.selection2];
        [self setUpWordButtonForOption:opt3 forButton:self.selection3];
        
    }
    
}

- (void) setUpWordButtonForOption:(Option *) option forButton:(UIButton *)btn {
    
    CGRect frame = [btn frame];
    frame.origin.x -= 50;
    frame.size.width +=100;
    [btn setFrame:frame];
    
    btn.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    btn.titleLabel.textAlignment = NSTextAlignmentCenter;
    
    [btn setTitleColor:option.color forState:UIControlStateNormal];
    [btn setTitle:option.word forState:UIControlStateNormal];
    
}

- (UIColor *)randomColor
{
    CGFloat hue = (arc4random() % 256 / 256.0f);
    CGFloat saturation = (arc4random() % 128 / 256.0f) + 0.5f;
    CGFloat brightness = (arc4random() % 128 / 256.0f) + 0.5f;
    UIColor *color = [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:1.0f];
    
    return color;
}

- (NSArray *) createPossibleAnswers {
    
    int colorNumber = arc4random() % 3;
    int shapeNumber = arc4random() % 3;
    int wordNumber = arc4random() % 3;
    
    NSMutableArray *possibleAnswers = [[NSMutableArray alloc] initWithCapacity:3];
    possibleColors = [self getRandomColorsForNum:colorNumber];
    
    possibleShapes = [self getRandomOptionsForNum:shapeNumber withData:self.allShapes];
    possibleWords = [self getRandomOptionsForNum:wordNumber withData:self.allWords];
    
    for (int i = 0; i < 3; i++) {
        Option *opt = [[Option alloc] optionWithShape:[UIImage imageNamed:possibleShapes[i]] andWord:possibleWords[i] andColor:possibleColors[i]];
        
        [possibleAnswers addObject:opt];
    }
    
    return possibleAnswers;
}

- (NSArray *) getRandomColorsForNum:(int)num {
    
    NSMutableArray *randomColors = [[NSMutableArray alloc] initWithObjects:[self randomColor],[self randomColor],[self randomColor], nil];
    
    
    randomColors[num] = self.answerColor;
    randomColors[(num+1)%3] = [self randomColor];
    randomColors[(num+2)%3] = [self randomColor];
    
    return randomColors;
}

- (NSArray *) getRandomOptionsForNum:(int)num withData:(NSMutableArray *)rawData {
    NSArray *randomData = [self shuffledArray:rawData];
    NSMutableArray *selectedData = [[NSMutableArray alloc] initWithObjects:@"",@"",@"", nil];
    
    for (int i = 0; i < 3; i++) {
        int r = arc4random() % ([randomData count] - 1);
        selectedData[i] = randomData[r];
    }
    
    if (self.shapeVersion) {
        selectedData[num] = self.answerShape;
        answerImage = [UIImage imageNamed:self.answerShape];
   }
    if (!self.shapeVersion) {
        selectedData[num] = self.answerWord;
    }
    
    return selectedData;
}

- (void) setUpButton:(UIButton *) btn; {
    
}


-(NSArray *)shuffledArray:(NSMutableArray *)toShuffle {
    for (int i = 0; i < [toShuffle count]; i++) {
        int r = arc4random() % [toShuffle count];
        [toShuffle exchangeObjectAtIndex:i withObjectAtIndex:r];
    }
    
    return toShuffle;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)checkAnswer:(id)sender {
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    UIAlertView *correct = [[UIAlertView alloc] initWithTitle:@"Yay!"
                                                      message:@"Your answer is correct!"
                                                     delegate:self
                                            cancelButtonTitle:@"Quit"
                                            otherButtonTitles:@"Play Again", nil];
    
    UIAlertView *incorrect = [[UIAlertView alloc] initWithTitle:@"Bummer..."
                                                        message:@"Your answer is incorrect."
                                                       delegate:self
                                              cancelButtonTitle:@"Quit"
                                              otherButtonTitles:@"Play Again", nil];
    
    UIButton *btn = (UIButton *)sender;
    
    // button background color, text color, and the answer color
    UIColor *btnClr = [btn backgroundColor];
    UIColor *btnTextColor = [btn titleColorForState:UIControlStateNormal];
    UIColor *corClr = [self answerColor];
    
    // button background image
    UIImage *answerShape = [UIImage imageNamed:self.answerShape];
    
    if (self.shapeVersion) {
        if (self.shapeVersionShape) {
            if ([answerImage isEqual:answerShape]) {
                [correct show];
                won++;
            }
            else {
                [incorrect show];
            }
        }
        
        else if (!self.shapeVersionShape) {
            if ([btnClr isEqual:corClr]) {
                [correct show];
                won++;

            }
            
            else {
                [incorrect show];
            }
        }
    }
    else if (!self.shapeVersion) {
        if (self.wordVersionColor) {
            if ([btnTextColor isEqual:corClr]) {
                [correct show];
                won++;

            }
            
            else {
                [incorrect show];
            }
        }
        
        else if (!self.wordVersionColor) {
            if ([btn.titleLabel.text isEqualToString:self.answerWord]) {
                [correct show];
                won++;

            }
            
            else {
                [incorrect show];
            }
        }
    }
    
    else {
        [incorrect show];
    }
    
    [userDefaults setInteger:won forKey:@"GamesWonToday"];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    
    if (buttonIndex == 1) {
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        [UIView setAnimationDuration:0.75];
        [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:self.navigationController.view cache:NO];
        [UIView commitAnimations];
        
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDelay:0.375];
        self.gamesPlayed++;
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        [userDefaults setInteger:self.gamesPlayed forKey:@"GamesToday"];
        
        [self.navigationController popViewControllerAnimated:NO];
        
        [UIView commitAnimations];
    }
    
    if (buttonIndex == 0) {
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        [UIView setAnimationDuration:0.75];
        [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:self.navigationController.view cache:NO];
        [UIView commitAnimations];
        
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDelay:0.375];
        
        // send information to delegate - HubViewController
        HubViewController *hvc = [[HubViewController alloc] init];
        self.gamesPlayed++;
        [hvc recieveDataForGamesPlayed:self.gamesPlayed andGamesWon:won];
        
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        [userDefaults setInteger:self.gamesPlayed forKey:@"GamesToday"];
        
        NSArray *viewControllers = [self.navigationController viewControllers];
        if ([viewControllers[1] isEqual: hvc]) {
            NSLog(@"LEA I PRETTY");
        }
        
        NSLog(@"MY VIEW CONTROLLERS: %@", viewControllers);
        
        [self.navigationController popToViewController:viewControllers[1] animated:NO];
        
        [UIView commitAnimations];
    }
}

@end
