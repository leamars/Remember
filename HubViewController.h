//
//  HubViewController.h
//  Remember
//
//  Created by Lea Marolt on 1/12/14.
//  Copyright (c) 2014 Lea Marolt Sonnenschein. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FirstViewController.h"
#import "SelectionViewController.h"

@interface HubViewController : UIViewController <SelectionViewControllerDelegate>

@property (strong, nonatomic) IBOutlet UILabel *numOfPlays;
@property (strong, nonatomic) NSManagedObject *gameNum;

- (void)recieveData:(int)games;

@end
