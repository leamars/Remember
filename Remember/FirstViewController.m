//
//  FirstViewController.m
//  Remember
//
//  Created by Lea Marolt on 1/10/14.
//  Copyright (c) 2014 Lea Marolt Sonnenschein. All rights reserved.
//

#import "FirstViewController.h"
#import "SelectionViewController.h"
#import "Option.h"

@interface FirstViewController () {
    UIColor *keyColor;
    NSString *keyWord;
    NSString *keyShape;
    int numOfGames;
    Option *key;
    int chooseVersion;
    BOOL shapeVersion;
    BOOL shapeVersionShape;
    BOOL wordVersionColor;
}

@end

@implementation FirstViewController

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
    
    self.theWords = [[NSMutableArray alloc] initWithObjects:@"bird", @"snake", @"table", @"keys", @"picture", @"radio", @"folder", @"hanger", @"post", @"cucumber", @"elephant", @"crocodile", @"plastic", @"mortgage", @"sinister", @"sleep", @"park", @"prison", @"level", @"smile", @"stop", @"spot", @"elastic", @"gorge", @"mister", @"slap", @"fonder", @"hamper", @"rake", @"lake", @"letter", @"better", @"dark", @"eagle", @"eager", nil];
    
    self.theShapes = [[NSMutableArray alloc] initWithObjects:@"circleEmptyReverse", @"triangleEmptyReverse", @"squareEmptyReverse", @"circleFullReverse", @"triangleFullReverse", @"squareFullReverse", nil];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    
    chooseVersion = arc4random() % 2;
    shapeVersionShape = arc4random() % 2;
    wordVersionColor = arc4random() % 2;
    
    if (chooseVersion == 0) {
        shapeVersion = YES;
    }
    else {
        shapeVersion = NO;
    }
    
    keyColor = [self randomColor];
    int randomWord = arc4random() % ([self.theWords count] - 1);
    int randomShape = arc4random() % ([self.theShapes count] - 1);
    keyWord = self.theWords[randomWord];
    keyShape = self.theShapes[randomShape];
    
    key = [[Option alloc] optionWithShape:[UIImage imageNamed:keyShape] andWord:keyWord andColor:keyColor];
    
    
    // set up the game version
    if (shapeVersion) {
        [self shapeGameForButton:self.puzzle withOption:key];
    }
    
    else if (!shapeVersion) {
        [self wordGameForButton:self.puzzle withOption:key];
    }
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    BOOL firstRun = [userDefaults boolForKey:@"firstRun"];
    if (firstRun) {
        numOfGames = self.games;
        [userDefaults setBool:YES forKey:@"firstRun"];
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

- (void) shapeGameForButton:(UIButton *) btn withOption:(Option *) option {
    
    CGRect frame = [btn frame];
    frame.origin.x = 80;
    frame.size.width = 150;
    [btn setFrame:frame];
    
    [btn setBackgroundColor:option.color];
    [btn setBackgroundImage:option.shape forState:UIControlStateNormal];
    [btn setTitleColor:nil forState:UIControlStateNormal];
    [btn setTitle:nil forState:UIControlStateNormal];
    
    if (!shapeVersionShape) {
        self.instructionLabel.text = @"color!";
    }
    else if (shapeVersionShape) {
        self.instructionLabel.text = @"shape!";
    }
    
    [self.instructionLabel setFont:[UIFont fontWithName:@"HelveticaNeue" size:26]];
}

- (void) wordGameForButton:(UIButton *) btn withOption:(Option *) option {
    
    [btn setBackgroundColor:[UIColor clearColor]];
    [btn setBackgroundImage:nil forState:UIControlStateNormal];
    
    CGRect frame = [btn frame];
    frame.origin.x = 40;
    frame.size.width = 250;
    [btn setFrame:frame];
    
    btn.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    btn.titleLabel.textAlignment = NSTextAlignmentCenter;
    
    [btn setTitleColor:option.color forState:UIControlStateNormal];
    [btn setTitle:option.word forState:UIControlStateNormal];
    
    if (wordVersionColor) {
        self.instructionLabel.text = @"color!";
    }
    else if (!wordVersionColor) {
        self.instructionLabel.text = @"word!";
    }
    
    [self.instructionLabel setFont:[UIFont fontWithName:@"HelveticaNeue" size:26]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)performSegueWithIdentifier:(NSString *)identifier sender:(id)sender {

}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    SelectionViewController *svc = [segue destinationViewController];
    svc.answerColor = keyColor;
    svc.gamesPlayed = numOfGames;
    svc.delegate = self;
    svc.answerWord = keyWord;
    svc.answerShape = keyShape;
    svc.shapeVersion = shapeVersion;
    svc.shapeVersionShape = shapeVersionShape;
    svc.wordVersionColor = wordVersionColor;
    svc.allShapes = self.theShapes;
    svc.allWords = self.theWords;
    
}

-(void)viewDidDisappear:(BOOL)animated {
    numOfGames++;
}

- (void)recieveData:(int) games {

}

- (IBAction)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)refresh:(id)sender {
    [self viewDidLoad];
    [self viewWillAppear:YES];
}

@end
