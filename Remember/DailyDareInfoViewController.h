//
//  DailyDareInfoViewController.h
//  Remember
//
//  Created by Lea Marolt on 1/14/14.
//  Copyright (c) 2014 Lea Marolt Sonnenschein. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DDPageContentViewController.h"

@interface DailyDareInfoViewController : UIViewController <UIPageViewControllerDataSource>

- (IBAction)done:(id)sender;

@property (nonatomic, strong) UIPageViewController *ddPageViewController;
@property (strong, nonatomic) NSArray *pageActions;
@property (strong, nonatomic) NSArray *pageImages;

@end
