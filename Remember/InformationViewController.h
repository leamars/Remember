//
//  InformationViewController.h
//  Remember
//
//  Created by Lea Marolt on 1/10/14.
//  Copyright (c) 2014 Lea Marolt Sonnenschein. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "InfoPageContentViewController.h"

@interface InformationViewController : UIViewController <UIPageViewControllerDataSource>

@property (nonatomic) NSInteger index;

- (IBAction)done:(id)sender;
- (IBAction)startWalkthrough;

@property (strong, nonatomic) UIPageViewController *infoPageViewController;
@property (strong, nonatomic) NSArray *pageActions;
@property (strong, nonatomic) NSArray *pageImages;

@end
