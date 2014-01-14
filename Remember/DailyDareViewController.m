//
//  DailyDareViewController.m
//  Remember
//
//  Created by Lea Marolt on 1/14/14.
//  Copyright (c) 2014 Lea Marolt Sonnenschein. All rights reserved.
//

#import "DailyDareViewController.h"

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
    [self setUpDare];
}

- (void)setUpDare {
    
    // set up random choices for color, word, shape
    
    dailyOption = self.recievedDailyOption;
    
    // randomly select what kind of a challenge it will be
    
    // set up the challenge image
    self.dareImage.backgroundColor = dailyOption.color;
    [self.dareImage setBackgroundImage:dailyOption.shape forState:UIControlStateNormal];
    
    // set up the label
    self.attributeLabel.text = @"shape!";

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

- (IBAction)back:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)acceptDare:(id)sender {
}
@end
