//
//  DailyDareInfoViewController.m
//  Remember
//
//  Created by Lea Marolt on 1/14/14.
//  Copyright (c) 2014 Lea Marolt Sonnenschein. All rights reserved.
//

#import "DailyDareInfoViewController.h"

@interface DailyDareInfoViewController ()

@end

@implementation DailyDareInfoViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    self.pageActions = @[@"Remember the specified attributes - SHAPE & COLOR.", @"The view will lock for the day, and you will be presented with this screen.", @"At the start of the next day, you will be presented with three choices", @"Make sure you really remember the object, to answer it correctly the next day."];
    self.pageImages = @[@"ddpage1", @"ddpage2", @"ddpage3", @"ddpage4"];
    
    self.ddPageViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"DDPageViewController"];
    //NSLog(@"Data source is: %@", self.infoPageViewController)
    self.ddPageViewController.dataSource = self;
    
    DDPageContentViewController *startingViewController = [self viewControllerAtIndex:0];
    
    NSArray *viewControllers = @[startingViewController];
    [self.ddPageViewController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    
    self.ddPageViewController.view.frame = CGRectMake(0, 90, self.view.frame.size.width, self.view.frame.size.height - 110);
    
    [self addChildViewController:self.ddPageViewController];
    [self.view addSubview:self.ddPageViewController.view];
    [self.ddPageViewController didMoveToParentViewController:self];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)done:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Page View Controller Methods

- (IBAction)startWalkthrough {
    DDPageContentViewController *startingViewController = [self viewControllerAtIndex:0];
    NSArray *viewControllers = @[startingViewController];
    [self.ddPageViewController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionReverse animated:NO completion:nil];
    [self viewDidLoad];
}

- (DDPageContentViewController *) viewControllerAtIndex:(NSUInteger) index {
    if (([self.pageActions count] == 0) || (index >= [self.pageActions count])) {
        return nil;
    }
    
    NSLog(@"Index in the what to set for each controller is: %i", index);
    
    DDPageContentViewController *ddpcvc = [self.storyboard instantiateViewControllerWithIdentifier:@"DDPageContentViewController"];
    
    ddpcvc.action = self.pageActions[index];
    NSLog(@"WHAT IS THE ACTION? %@", ddpcvc.action);
    ddpcvc.imageFile = self.pageImages[index];
    NSLog(@"WHAT IS THE IMAGE? %@", ddpcvc.imageFile);
    ddpcvc.pageIndex = index;
    
    return ddpcvc;
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    
    NSUInteger index = ((DDPageContentViewController *) viewController).pageIndex;
    
    if (index == 0 || (index == NSNotFound)) {
        return nil;
    }
    
    index--;
    return [self viewControllerAtIndex:index];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
    
    NSUInteger index = ((DDPageContentViewController *) viewController).pageIndex;
    
    if (index == NSNotFound) {
        return nil;
    }
    
    index++;
    
    if (index == [self.pageActions count]) {
        return [self viewControllerAtIndex:0];
    }
    
    return [self viewControllerAtIndex:index];
}

// present the dots

- (NSInteger)presentationCountForPageViewController:(UIPageViewController *)pageViewController {
    return [self.pageActions count];
}

- (NSInteger)presentationIndexForPageViewController:(UIPageViewController *)pageViewController {
    return 0;
}

@end
