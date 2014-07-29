//
//  PTHYGroundNode.m
//  Space Cat
//
//  Created by Pierre Thalamy on 28/07/14.
//  Copyright (c) 2014 Pierre Thalamy. All rights reserved.
//

#import "PTHYGroundNode.h"
#import "PTHYUtils.h"

@implementation PTHYGroundNode

+ (instancetype)groundWithSize:(CGSize)size
{
    PTHYGroundNode *ground = [self spriteNodeWithColor:nil size:size];
 
    ground.name = @"Ground";
    ground.position = CGPointMake((size.width / 2), (size.height / 2));
    [ground setupPhysicsBody];
    
    return ground;
}

- (void)setupPhysicsBody
{
    self.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:self.frame.size];
    self.physicsBody.affectedByGravity = NO;
    self.physicsBody.dynamic = NO;
    
    self.physicsBody.categoryBitMask = PTHYCollisionCategoryGround;
    self.physicsBody.collisionBitMask = PTHYCollisionCategoryDebris;
    self.physicsBody.contactTestBitMask = PTHYCollisionCategoryEnemy;
}

@end
