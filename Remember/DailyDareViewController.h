//
//  DailyDareViewController.h
//  Remember
//
//  Created by Lea Marolt on 1/14/14.
//  Copyright (c) 2014 Lea Marolt Sonnenschein. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Option.h"

@protocol DailyDareViewControllerDelegate <NSObject>

- (void) recieveDataForDailyeDare:(BOOL)dareAccepted;

@end

@interface DailyDareViewController : UIViewController

@property (nonatomic, strong) id <DailyDareViewControllerDelegate> delegate;
@property (strong, nonatomic) IBOutlet UILabel *attributeLabel;
@property (strong, nonatomic) IBOutlet UIButton *dareImage;
@property (strong, nonatomic) Option *recievedDailyOption;
@property (nonatomic) BOOL selectedOption;
@property (strong, nonatomic) IBOutlet UILabel *attributeTwoLabel;


- (IBAction)back:(id)sender;
- (IBAction)acceptDare:(id)sender;

@end
