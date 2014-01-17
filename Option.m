//
//  Option.m
//  Remember
//
//  Created by Lea Marolt on 1/13/14.
//  Copyright (c) 2014 Lea Marolt Sonnenschein. All rights reserved.
//

#import "Option.h"

@implementation Option

- (instancetype)optionWithShape:(UIImage *)shape andWord:(NSString *)word andColor:(UIColor *)color {
    
    Option *option = [[Option alloc] init];
    
    [option setShape:shape];
    [option setWord:word];
    [option setColor:color];
    
    return option;
}

- (NSString *) describeOption:(Option *)opt {
    NSString *desc = [NSString stringWithFormat:@"%@, %@, %@", opt.word, opt.shape, opt.color];
    
    return desc;
}

@end
