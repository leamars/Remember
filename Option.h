//
//  Option.h
//  Remember
//
//  Created by Lea Marolt on 1/13/14.
//  Copyright (c) 2014 Lea Marolt Sonnenschein. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Option : NSObject

@property (nonatomic, strong) UIImage *shape;
@property (nonatomic, strong) UIColor *color;
@property (nonatomic, strong) NSString *word;


-(instancetype)optionWithShape:(UIImage *)shape andWord:(NSString *)word andColor:(UIColor *)color;
-(NSString *)describeOption:(Option*)opt;

@end
