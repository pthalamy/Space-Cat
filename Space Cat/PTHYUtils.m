//
//  PTHYUtils.m
//  Space Cat
//
//  Created by Pierre Thalamy on 27/07/14.
//  Copyright (c) 2014 Pierre Thalamy. All rights reserved.
//

#import "PTHYUtils.h"

@implementation PTHYUtils

+ (NSInteger)randomWithMin:(NSInteger)min andMax:(NSInteger)max {
    return arc4random() % (max-min) + min;
}

@end
