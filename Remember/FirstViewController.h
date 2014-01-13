//
//  FirstViewController.h
//  Remember
//
//  Created by Lea Marolt on 1/10/14.
//  Copyright (c) 2014 Lea Marolt Sonnenschein. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SelectionViewController.h"

@protocol FirstViewControllerDelegate <NSObject>

- (void)finallyRecieveData:(int) games;

@end

@interface FirstViewController : UIViewController <SelectionViewControllerDelegate>

@property int games;
@property (strong, nonatomic) IBOutlet UIButton *puzzle;
@property (nonatomic, strong) id <FirstViewControllerDelegate> delegate;
@property (nonatomic, strong) NSMutableArray *theWords;
@property (nonatomic, strong) NSMutableArray *theShapes;
@property (strong, nonatomic) IBOutlet UILabel *instructionLabel;

- (void)recieveData:(int) games;
- (IBAction)back:(id)sender;
- (IBAction)refresh:(id)sender;

@end
