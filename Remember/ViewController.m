//
//  ViewController.m
//  Remember
//
//  Created by Lea Marolt on 1/10/14.
//  Copyright (c) 2014 Lea Marolt Sonnenschein. All rights reserved.
//

#import "ViewController.h"
#import <Parse/Parse.h>
#import "HubViewController.h"

@interface ViewController ()

@end

@implementation ViewController {
    NSString *username;
    NSString *password;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    PFUser *currentUser = [PFUser currentUser];
    if (currentUser) {
        
        [self performSegueWithIdentifier:@"toHub" sender:self];
        
    } else {
        
    }
    
    self.usernameTextField.delegate = self;
    self.passwordTextField.delegate = self;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    // get rid of keyboard when you touch anywhere on the screen
    [self.view endEditing:YES];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    username = self.usernameTextField.text;
    password = self.passwordTextField.text;
    
    [textField resignFirstResponder];
    
    return NO;
}

- (IBAction)signIn:(id)sender {
    
    [PFUser logInWithUsernameInBackground:username password:password
                                    block:^(PFUser *user, NSError *error) {
                                        if (user) {
                                            
                                            [self performSegueWithIdentifier:@"toHub" sender:self];
                                            
                                            
                                        } else {
                                            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Oops!" message:@"Something went wrong. Make sure you're entering the right username and password, and try again." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                                            [alert show];
                                        }
                                    }];
}



@end
