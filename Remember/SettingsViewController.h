//
//  SettingsViewController.h
//  Remember
//
//  Created by Lea Marolt on 1/13/14.
//  Copyright (c) 2014 Lea Marolt Sonnenschein. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SettingsViewController : UIViewController <UITextFieldDelegate>
@property (strong, nonatomic) IBOutlet UITextField *emailTextField;
@property (strong, nonatomic) IBOutlet UILabel *usernameLabel;
@property (strong, nonatomic) IBOutlet UILabel *emailLabel;

- (IBAction)done:(id)sender;
- (IBAction)logOut:(id)sender;
- (IBAction)passwordReset:(id)sender;

@end
