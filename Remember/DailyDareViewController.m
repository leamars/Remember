//
//  DailyDareViewController.m
//  Remember
//
//  Created by Lea Marolt on 1/14/14.
//  Copyright (c) 2014 Lea Marolt Sonnenschein. All rights reserved.
//

#import "DailyDareViewController.h"
#import "HubViewController.h"

@interface DailyDareViewController ()

@end

@implementation DailyDareViewController {
    NSArray *theWords;
    NSArray *theShapes;
    Option *dailyOption;
    int randomWord;
    int randomShape;
    UIColor *randomColor;
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
    theWords = [[NSMutableArray alloc] initWithObjects:@"bird", @"snake", @"table", @"keys", @"picture", @"radio", @"folder", @"hanger", @"post", @"cucumber", @"elephant", @"crocodile", @"plastic", @"mortgage", @"sinister", @"sleep", @"park", @"prison", @"level", @"smile", @"stop", @"spot", @"elastic", @"gorge", @"mister", @"slap", @"fonder", @"hamper", @"rake", @"lake", @"letter", @"better", @"dark", @"eagle", @"eager", nil];
    
    theShapes = [[NSMutableArray alloc] initWithObjects:@"circleEmptyReverse", @"triangleEmptyReverse", @"squareEmptyReverse", @"circleFullReverse", @"triangleFullReverse", @"squareFullReverse", nil];

    NSLog(self.selectedOption ? @"Yes" : @"No");

}

- (void)viewWillAppear:(BOOL)animated {
    [self setUpFirstDareView];
}

- (void)setUpFirstDareView {
    
    // set up random choices for color, word, shape
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    dailyOption = self.recievedDailyOption;
    
    // randomly select what kind of a challenge it will be
    
    NSLog(@"WHAT ARE MY BOOLS?\n [userDefaults boolForKey:@'throughSelection']: %hhd\n[userDefaults boolForKey:@'dailyDareOpenedForFirstTime'] %hhd\n[userDefaults boolForKey:@'dareAccepted']: %hhd\n[userDefaults boolForKey:@'firstAppRun']: %hhd\n[userDefaults boolForKey:@'dailyDareOpenedForFirstTime']: %hhd\nDid I get my daily option? :%@", [userDefaults boolForKey:@"throughSelection"], [userDefaults boolForKey:@"dailyDareOpenedForFirstTime"], [userDefaults boolForKey:@"dareAccepted"], [userDefaults boolForKey:@"firstAppRun"], [userDefaults boolForKey:@"dailyDareOpenedForFirstTime"], self.recievedDailyOption);
    
    if ([userDefaults boolForKey:@"firstAppRun"]) {
        [self dailyOptionView];
        [userDefaults setBool:NO forKey:@"firstAppRun"];
        [userDefaults setBool:NO forKey:@"dailyDareOpenedForFirstTime"];
    }
    
    if (self.recievedDailyOption && ![userDefaults boolForKey:@"dareAccepted"]) {
        
        [self dailyOptionView];
        
        [userDefaults setBool:NO forKey:@"dailyDareOpenedForFirstTime"];
        [userDefaults setBool:YES forKey:@"dareAccepted"];
        [userDefaults setBool:NO forKey:@"resetCalled"];
    }
    
    else if (!self.recievedDailyOption && [userDefaults boolForKey:@"dareAccepted"] && ![userDefaults boolForKey:@"resetCalled"]) {
        [self lockedView];
        
    }
    
    else if (!self.recievedDailyOption && [userDefaults boolForKey:@"dareAccepted"] && [userDefaults boolForKey:@"resetCalled"]) {
        [self optionsView];
        [userDefaults setBool:NO forKey:@"dareAccepted"];
        [userDefaults setBool:NO forKey:@"throughSelection"];
        [userDefaults setBool:NO forKey:@"firstAppRun"];
        [userDefaults setBool:NO forKey:@"resetCalled"];
    }
    

}

- (UIColor *)randomColor
{
    CGFloat hue = (arc4random() % 256 / 256.0f);
    CGFloat saturation = (arc4random() % 128 / 256.0f) + 0.5f;
    CGFloat brightness = (arc4random() % 128 / 256.0f) + 0.5f;
    UIColor *color = [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:1.0f];
    
    return color;
}

- (void) dailyOptionView {
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        
        if (self.selectedOption) {
            
            // set up the challenge image
            self.dareImage.backgroundColor = dailyOption.color;
            [self.dareImage setBackgroundImage:dailyOption.shape forState:UIControlStateNormal];
            
            // set up the label
            self.attributeLabel.text = @"shape";
            self.attributeTwoLabel.text = @"color!";
        }
        
        else if (!self.selectedOption) {
            
            CGRect frame = [self.dareImage frame];
            frame.origin.x -= 50;
            frame.size.width +=100;
            [self.dareImage setFrame:frame];
            
            self.dareImage.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
            self.dareImage.titleLabel.textAlignment = NSTextAlignmentCenter;
            
            [self.dareImage setTitleColor:dailyOption.color forState:UIControlStateNormal];
            [self.dareImage setTitle:dailyOption.word forState:UIControlStateNormal];
            
            self.attributeLabel.text = @"text";
            self.attributeTwoLabel.text = @"color!";
        }
        
        [self.acceptedButton setTitle:@"Accept Dare!" forState:UIControlStateNormal];
        [self.acceptedSpiel setHidden:YES];
        [self.goodLuck setHidden:YES];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)back:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void) lockedView {
    
    self.attributeTwoLabel.text = nil;
    self.attributeLabel.text = nil;
    self.dareImage.imageView.image = nil;
    self.rememberLabel.text = nil;
    self.andLabel.text = nil;
    self.acceptedButton.enabled = NO;
    [self.acceptedButton setTitle:@"Dare Activated!" forState:UIControlStateDisabled];
    [self.acceptedButton setTitle:@"Dare Activated!" forState:UIControlStateNormal];
    [self.acceptedSpiel setHidden:NO];
    [self.goodLuck setHidden:NO];
}

- (void) optionsView {
    Option *opt1 = self.optionsArray[2];
    Option *opt2 = self.optionsArray[1];
    Option *opt3 = self.optionsArray[0];
    
    int select1 = arc4random()%1;
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    BOOL shapeSelected = [userDefaults boolForKey:@"chosenOption"];
    opt3.shape = [userDefaults objectForKey:@"theDailyShape"];
    
    if (select1 == 0) {
        [self setUpWordButtonForOption:opt1 forButton:self.firstOption];
    }
    if (select1 == 1) {
        [self setUpShapeButtonForOption:opt1 forButton:self.firstOption];
    }
    
    int select2 = arc4random()%1;
    if (select2 == 0) {
    
        [self setUpShapeButtonForOption:opt2 forButton:self.secondOption];
    }
    if (select2 == 1) {
        [self setUpWordButtonForOption:opt2 forButton:self.secondOption];
    }
    
    if (shapeSelected) {
        [self setUpShapeButtonForOption:opt3 forButton:self.thirdOption];
    }
    
    else if (!shapeSelected) {
        [self setUpWordButtonForOption:opt3 forButton:self.thirdOption];
    }
    
    // randomly move them, to create randomness, instead of randomly assigning attributes,
    // kind of cheating, but the other way was becoming waaaaay too much of a hassle :(
    
    CGRect frame1 = self.firstOption.frame;
    CGRect frame2 = self.secondOption.frame;
    CGRect frame3 = self.thirdOption.frame;
    
    CGRect cgrects[] = {frame1, frame2, frame3};
    
    int r1 = arc4random() % 3;
    int r2;
    int r3;
    
    if (r1 == 0) {
        r2 = arc4random() % 2 + 1;
        if (r2 == 1) {
            r3 = 2;
            r2 = 1;
        }
        
        else {
            r3 = 1;
            r2 = 2;
        }
    }
    
    else if (r1 == 1) {
        r2 = arc4random() % 2;
        if (r2 == 1) {
            r2 = 2;
            r3 = 0;
        }
        else {
            r2 = 0;
            r3 = 2;
        }
    }

    else {
        r2 = arc4random() % 2;
        if (r2 == 1) {
            r2 = 1;
            r3 = 0;
        }
        else {
            r2 = 0;
            r3 = 1;
        }
    }
    
    
    self.firstOption.frame =  cgrects[r1];
    if (![self.firstOption backgroundImageForState:UIControlStateNormal]) {
        [self fixButton:self.firstOption];
    }
    self.secondOption.frame =  cgrects[r2];
    if (![self.secondOption backgroundImageForState:UIControlStateNormal]) {
        [self fixButton:self.secondOption];
    }
    self.thirdOption.frame =  cgrects[r3];
    if (![self.thirdOption backgroundImageForState:UIControlStateNormal]) {
        [self fixButton:self.thirdOption];
    }
 
    [self.acceptedSpiel setHidden:YES];
    [self.goodLuck setHidden:YES];
    self.attributeTwoLabel.text = @"";
    self.attributeLabel.text = @"";
    [self.dareImage setHidden:YES];
    self.rememberLabel.text = @"";
    self.andLabel.text = @"";
    self.acceptedButton.enabled = NO;
    [self.acceptedButton setTitle:@"Answer!" forState:UIControlStateDisabled];
    [self.acceptedButton setTitle:@"Answer!" forState:UIControlStateNormal];
}

- (void) fixButton:(UIButton *)btn {
    CGRect frame = [btn frame];
    frame.origin.x -= 50;
    frame.size.width +=100;
    [btn setFrame:frame];
}

- (void) setUpWordButtonForOption:(Option *) option forButton:(UIButton *)btn {
    
    [btn setTitleColor:option.color forState:UIControlStateNormal];
    [btn setTitle:option.word forState:UIControlStateNormal];
}

- (void) setUpShapeButtonForOption:(Option *) option forButton:(UIButton *)btn {
    NSString *shape = option.shape;
    [btn setBackgroundImage: [UIImage imageNamed:shape] forState:UIControlStateNormal];
    [btn setBackgroundColor:option.color];
    [btn setHighlighted:NO];
}

- (IBAction)acceptDare:(id)sender {
    
    [self.delegate recieveDataForDailyeDare:YES];
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:0.75];
    [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:self.navigationController.view cache:NO];
    [UIView commitAnimations];
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDelay:0.375];
    
    [self.navigationController popViewControllerAnimated:NO];
    
    [UIView commitAnimations];
}

- (IBAction)checkAnswer:(id)sender {
    Option *the = self.optionsArray[0];

    UIButton *btn = (UIButton *)sender;
    
    if ([self btn:btn IsOption:the]) {
        UIAlertView *yay = [[UIAlertView alloc] initWithTitle:@"Yay!" message:@"You got it right. Good job (:!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [yay show];
    }
    else {
        UIAlertView *nay = [[UIAlertView alloc] initWithTitle:@"Oh no..." message:@"You didn't get the right answer. What a bummer. Try again tomorrow!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [nay show];
    }
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setBool:YES forKey:@"dailyDareOpenedForFirstTime"];
    
}

- (Option *) btnToOption:(UIButton *)btn {
    Option *opt = [[Option alloc] optionWithShape:[btn backgroundImageForState:UIControlStateNormal] andWord:btn.titleLabel.text andColor:btn.backgroundColor];
    return opt;
}

- (BOOL) btn:(UIButton *)btn IsOption:(Option *)opt {
    
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *theOptShape = [userDefaults objectForKey:@"theDailyShape"];
    UIImage *optImage = [UIImage imageNamed:theOptShape];
    
    BOOL shapeSelected = [userDefaults boolForKey:@"chosenOption"];
    
    if (shapeSelected) {
        if ([optImage isEqual:[btn backgroundImageForState:UIControlStateNormal]] && [opt.color isEqual:btn.backgroundColor]) {
            [userDefaults setInteger:1 forKey:@"dailyDareWon"];
            return YES;
        }
    }
    
    else if (!shapeSelected) {
        if ([opt.word isEqualToString:btn.titleLabel.text] && [opt.color isEqual:[btn titleColorForState:UIControlStateNormal]]) {
            [userDefaults setInteger:1 forKey:@"dailyDareWon"];
            return YES;
        }
    }
    
    [userDefaults setInteger:1 forKey:@"dailyDareWon"];
    return NO;
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0) {
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        [UIView setAnimationDuration:0.75];
        [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:self.navigationController.view cache:NO];
        [UIView commitAnimations];
        
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDelay:0.375];
        
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        [userDefaults boolForKey:@"throughSelection"];
    
        
        [self.navigationController popViewControllerAnimated:YES];
        
        [UIView commitAnimations];
    }
}

@end
