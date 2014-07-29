//
//  PTHYUtils.h
//  Space Cat
//
//  Created by Pierre Thalamy on 27/07/14.
//  Copyright (c) 2014 Pierre Thalamy. All rights reserved.
//

#import <Foundation/Foundation.h>

static const int PTHYProjectileSpeed = 400;

static const int PTHYSpaceDogMinSpeed = -100;
static const int PTHYSpaceDogMaxSpeed = -50;

static const int PTHYSpaceDogInitialHealthPoints = 1;
static const int PTHYProjectileHitPoints = 1;

static const int PTHYMaxLives = 4;

static const int PTHYPointsPerHit = 25;
static const int PTHYPointsPerKill = 100;

typedef NS_OPTIONS(uint32_t, PTHYCollisionCategory) {
    PTHYCollisionCategoryEnemy      = 1 << 0,
    PTHYCollisionCategoryProjectile = 1 << 1,
    PTHYCollisionCategoryDebris     = 1 << 2,
    PTHYCollisionCategoryGround     = 1 << 3,
};

@interface PTHYUtils : NSObject

+ (NSInteger)randomWithMin:(NSInteger)min andMax:(NSInteger)max;

@end
