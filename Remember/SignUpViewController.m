//
//  SignUpViewController.m
//  Remember
//
//  Created by Lea Marolt on 1/13/14.
//  Copyright (c) 2014 Lea Marolt Sonnenschein. All rights reserved.
//

#import "SignUpViewController.h"
#import <Parse/Parse.h>
#import "HubViewController.h"

@interface SignUpViewController ()

@end

@implementation SignUpViewController {
    NSString *name;
    NSInteger age;
    NSString *username;
    NSString *password;
    NSString *email;
}

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
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setBool:YES forKey:@"firstAppRun"];
    
    self.nameTextField.delegate = self;
    self.usernameTextField.delegate = self;
    self.passwordTextField.delegate = self;
    self.emailTextField.delegate = self;
    
    self.nameTextField.enablesReturnKeyAutomatically = YES;
    self.usernameTextField.enablesReturnKeyAutomatically = YES;
    self.passwordTextField.enablesReturnKeyAutomatically = YES;
    self.emailTextField.enablesReturnKeyAutomatically = YES;
}

- (void)viewWillAppear:(BOOL)animated {
    PFUser *currentUser = [PFUser currentUser];
    if (currentUser) {
        
        NSArray *viewControllers = [self.navigationController viewControllers];
        [self.navigationController pushViewController:viewControllers[3] animated:YES];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    name = [self.nameTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    username = [self.usernameTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    password = [self.passwordTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    email = [self.emailTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    [textField resignFirstResponder];

    return NO;
}

- (IBAction)signUp:(id)sender {
    if ([name length] == 0 || [username length] == 0 || [password length] == 0 || [email length] == 0) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Oops!" message:@"Looks like you didn't enter information for all the fields." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];
    }
    else {
        PFUser *newUser = [PFUser user];
        newUser.username = username;
        newUser.password = password;
        newUser.email = email;
        
        newUser[@"name"] = name;
        
        [newUser signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            if (error) {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Sorry." message:[error.userInfo objectForKey:@"error"] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                
                [alert show];
            }
            else {
                [self performSegueWithIdentifier:@"toWelcome" sender:self];
            }
            
        }];
    }
}

- (IBAction)goBack:(id)sender {
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:0.75];
    [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:self.navigationController.view cache:NO];
    [UIView commitAnimations];
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDelay:0.375];
    
    [self.navigationController popToRootViewControllerAnimated:YES];
    [UIView commitAnimations];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    // get rid of keyboard when you touch anywhere on the screen
    [self.view endEditing:YES];
}

@end
