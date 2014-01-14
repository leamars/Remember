//
//  InfoPageContentViewController.h
//  Remember
//
//  Created by Lea Marolt on 1/14/14.
//  Copyright (c) 2014 Lea Marolt Sonnenschein. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InfoPageContentViewController : UIViewController
@property (strong, nonatomic) IBOutlet UIImageView *screen;
@property (strong, nonatomic) IBOutlet UILabel *actionTaken;
@property (nonatomic) NSUInteger pageIndex;
@property (nonatomic, strong) NSString *imageFile;
@property (nonatomic, strong) NSString *action;

@end
