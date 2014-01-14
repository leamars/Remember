//
//  SelectionViewController.h
//  Remember
//
//  Created by Lea Marolt on 1/10/14.
//  Copyright (c) 2014 Lea Marolt Sonnenschein. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SelectionViewControllerDelegate <NSObject>

- (void)recieveDataForGamesPlayed:(int) games andGamesWon:(int)gamesWon;

@end

@interface SelectionViewController : UIViewController <UIAlertViewDelegate>
@property (strong, nonatomic) IBOutlet UIButton *selection2;
@property (strong, nonatomic) IBOutlet UIButton *selection1;
@property (strong, nonatomic) IBOutlet UIButton *selection3;
@property (strong, nonatomic) UIColor *answerColor;
@property (nonatomic, strong) NSString *answerAttribute;
@property (nonatomic) BOOL shapeVersion;
@property (nonatomic) BOOL shapeVersionShape;
@property (nonatomic) BOOL wordVersionColor;
@property int gamesPlayed;
@property (nonatomic, strong) NSString *answerWord;
@property (nonatomic, strong) NSString *answerShape;
@property (nonatomic, strong) NSMutableArray *allWords;
@property (nonatomic, strong) NSMutableArray *allShapes;
@property (strong, nonatomic) id <SelectionViewControllerDelegate> delegate;

@end
