//
//  DailyDareViewController.h
//  Remember
//
//  Created by Lea Marolt on 1/14/14.
//  Copyright (c) 2014 Lea Marolt Sonnenschein. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol DailyDareViewControllerDelegate <NSObject>

- (void) recieveDataForDailyeDare:(BOOL)dareCompleted;

@end

@interface DailyDareViewController : UIViewController

@property (nonatomic, strong) id <DailyDareViewControllerDelegate> delegate;
@property (strong, nonatomic) IBOutlet UILabel *attributeLabel;

- (IBAction)back:(id)sender;
- (IBAction)acceptDare:(id)sender;

@end
