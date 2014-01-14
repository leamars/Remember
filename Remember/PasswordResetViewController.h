//
//  PasswordResetViewController.h
//  Remember
//
//  Created by Lea Marolt on 1/14/14.
//  Copyright (c) 2014 Lea Marolt Sonnenschein. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PasswordResetViewController : UIViewController <UITextFieldDelegate>
@property (strong, nonatomic) IBOutlet UITextField *emailTextField;
- (IBAction)done:(id)sender;
- (IBAction)passwordReset:(id)sender;

@end
