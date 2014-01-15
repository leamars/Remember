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
    
    dailyOption = self.recievedDailyOption;
    
    // randomly select what kind of a challenge it will be
    
    if (self.recievedDailyOption) {
        
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
    
    else if (!self.recievedDailyOption) {
        [self lockedView];
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
    
}

- (IBAction)acceptDare:(id)sender {
    
    HubViewController *hvc = [[HubViewController alloc] init];
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
@end
