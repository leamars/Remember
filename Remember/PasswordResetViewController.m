//
//  PasswordResetViewController.m
//  Remember
//
//  Created by Lea Marolt on 1/14/14.
//  Copyright (c) 2014 Lea Marolt Sonnenschein. All rights reserved.
//

#import "PasswordResetViewController.h"
#import <Parse/Parse.h>

@interface PasswordResetViewController () {
    NSString *email;
}

@end

@implementation PasswordResetViewController

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
    self.emailTextField.delegate = self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    email = self.emailTextField.text;
    
    [textField resignFirstResponder];
    
    return NO;
}

- (IBAction)done:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)passwordReset:(id)sender {
    [PFUser requestPasswordResetForEmailInBackground:email];
    NSLog(@"%@", email);
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Request sent!" message:@"You should recieve an email with a password reset link. Follow the instructions in the email to reset your password." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    
    [alert show];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    // get rid of keyboard when you touch anywhere on the screen
    [self.view endEditing:YES];
}

@end
