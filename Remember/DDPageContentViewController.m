//
//  DDPageContentViewController.m
//  Remember
//
//  Created by Lea Marolt on 1/17/14.
//  Copyright (c) 2014 Lea Marolt Sonnenschein. All rights reserved.
//

#import "DDPageContentViewController.h"

@interface DDPageContentViewController ()

@end

@implementation DDPageContentViewController

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
    self.screen.image = [UIImage imageNamed:self.imageFile];
    self.actionTaken.text = self.action;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
