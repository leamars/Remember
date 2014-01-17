//
//  DailyDareViewController.h
//  Remember
//
//  Created by Lea Marolt on 1/14/14.
//  Copyright (c) 2014 Lea Marolt Sonnenschein. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Option.h"

@class DailyDareViewController;

@protocol DailyDareViewControllerDelegate <NSObject>

- (void) recieveDataForDailyeDare:(BOOL)dareAccepted;

@end

@interface DailyDareViewController : UIViewController <UIAlertViewDelegate>

@property (nonatomic, strong) id <DailyDareViewControllerDelegate> delegate;
@property (strong, nonatomic) IBOutlet UILabel *attributeLabel;
@property (strong, nonatomic) IBOutlet UIButton *dareImage;
@property (strong, nonatomic) Option *recievedDailyOption;
@property (nonatomic) BOOL selectedOption; // IF DAILY ANSWER IS SHAPE OR TEXT
@property (strong, nonatomic) IBOutlet UILabel *attributeTwoLabel;
@property (strong, nonatomic) IBOutlet UILabel *rememberLabel;
@property (strong, nonatomic) IBOutlet UILabel *andLabel;
@property (strong, nonatomic) IBOutlet UIButton *acceptedButton;
@property (strong, nonatomic) IBOutlet UILabel *goodLuck;
@property (strong, nonatomic) IBOutlet UILabel *acceptedSpiel;
@property (nonatomic, strong) NSMutableArray *optionsArray;
@property (strong, nonatomic) IBOutlet UIButton *firstOption;
@property (strong, nonatomic) IBOutlet UIButton *secondOption;
@property (strong, nonatomic) IBOutlet UIButton *thirdOption;


- (IBAction)back:(id)sender;
- (IBAction)acceptDare:(id)sender;
- (void) lockedView;

@end
