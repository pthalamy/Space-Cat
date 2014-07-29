//
//  PTHYSpaceDogNode.m
//  Space Cat
//
//  Created by Pierre Thalamy on 28/07/14.
//  Copyright (c) 2014 Pierre Thalamy. All rights reserved.
//

#import "PTHYSpaceDogNode.h"
#import "PTHYUtils.h"

@implementation PTHYSpaceDogNode

+ (instancetype)spaceDogOfType:(PTHYSpaceDogType)type
{
    PTHYSpaceDogNode *spaceDog;
    NSArray *textures;
    
    if (type == PTHYSpaceDogTypeA) {
        spaceDog = [self spriteNodeWithImageNamed:@"spacedog_A_1"];
        textures = @[[SKTexture textureWithImageNamed:@"spacedog_A_1"],
                     [SKTexture textureWithImageNamed:@"spacedog_A_2"]];
    } else {
        spaceDog = [self spriteNodeWithImageNamed:@"spacedog_B_1"];
        textures = @[[SKTexture textureWithImageNamed:@"spacedog_B_1"],
                     [SKTexture textureWithImageNamed:@"spacedog_B_2"],
                     [SKTexture textureWithImageNamed:@"spacedog_B_3"]];
    }

    float scale = [PTHYUtils randomWithMin:85 andMax:100] / 100.0f;
    spaceDog.xScale = scale;
    spaceDog.yScale = scale;
    
    SKAction *animation = [SKAction animateWithTextures:textures timePerFrame:0.10];
    [spaceDog runAction:[SKAction repeatActionForever:animation]];
    [spaceDog setupPhysicsBody];
    
    spaceDog.health = PTHYSpaceDogInitialHealthPoints;
    spaceDog.type = type;
    
    return spaceDog;
}

- (void)setupPhysicsBody
{
    self.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:self.frame.size];
    self.physicsBody.affectedByGravity = NO;
    
    self.physicsBody.categoryBitMask = PTHYCollisionCategoryEnemy;
    self.physicsBody.contactTestBitMask = PTHYCollisionCategoryGround | PTHYCollisionCategoryProjectile;
    self.physicsBody.collisionBitMask = 0;
}

@end
