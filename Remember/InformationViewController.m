//
//  InformationViewController.m
//  Remember
//
//  Created by Lea Marolt on 1/10/14.
//  Copyright (c) 2014 Lea Marolt Sonnenschein. All rights reserved.
//

#import "InformationViewController.h"

@interface InformationViewController ()

@end

@implementation InformationViewController

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
    
    self.pageActions = @[@"Remember the specified attribute of the object shown - SHAPE.", @"If you don't like the current task, refresh to get a new one.", @"Press play to be presented with three choices.", @"Pick the correct one based on the specified attribute. If the attribute is shape, there might be more than one correct answer."];
    self.pageImages = @[@"page1", @"page2", @"page3", @"page4"];
    
    self.infoPageViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"InfoPageViewController"];
    //NSLog(@"Data source is: %@", self.infoPageViewController)
    self.infoPageViewController.dataSource = self;
    
    InfoPageContentViewController *startingViewController = [self viewControllerAtIndex:0];
    
    NSArray *viewControllers = @[startingViewController];
    [self.infoPageViewController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    
    self.infoPageViewController.view.frame = CGRectMake(0, 90, self.view.frame.size.width, self.view.frame.size.height - 110);
    
    [self addChildViewController:self.infoPageViewController];
    [self.view addSubview:self.infoPageViewController.view];
    [self.infoPageViewController didMoveToParentViewController:self];
    
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
    InfoPageContentViewController *startingViewController = [self viewControllerAtIndex:0];
    NSArray *viewControllers = @[startingViewController];
    [self.infoPageViewController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionReverse animated:NO completion:nil];
    [self viewDidLoad];
}

- (InfoPageContentViewController *) viewControllerAtIndex:(NSUInteger) index {
    if (([self.pageActions count] == 0) || (index >= [self.pageActions count])) {
        return nil;
    }
    
    NSLog(@"Index in the what to set for each controller is: %i", index);
    
    InfoPageContentViewController *ipcvc = [self.storyboard instantiateViewControllerWithIdentifier:@"InfoPageContentViewController"];
    
    ipcvc.action = self.pageActions[index];
    ipcvc.imageFile = self.pageImages[index];
    ipcvc.pageIndex = index;
    
    return ipcvc;
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    
    NSUInteger index = ((InfoPageContentViewController *) viewController).pageIndex;
    
    if (index == 0 || (index == NSNotFound)) {
        return nil;
    }
    
    index--;
    return [self viewControllerAtIndex:index];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
    
    NSUInteger index = ((InfoPageContentViewController *) viewController).pageIndex;
    
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
