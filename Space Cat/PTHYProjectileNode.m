//
//  PTHYProjectileNode.m
//  Space Cat
//
//  Created by Pierre Thalamy on 27/07/14.
//  Copyright (c) 2014 Pierre Thalamy. All rights reserved.
//

#import "PTHYProjectileNode.h"
#import "PTHYUtils.h"

@implementation PTHYProjectileNode

+ (instancetype)projectileAtPosition:(CGPoint)position
{
    PTHYProjectileNode *projectile = [self spriteNodeWithImageNamed:@"projectile_1"];
    projectile.position = position;
    projectile.name = @"Projectile";
    
    [projectile setupAnimation];
    
    return projectile;
}

- (void)setupAnimation
{
    NSArray *textures = @[[SKTexture textureWithImageNamed:@"projectile_1"],
                          [SKTexture textureWithImageNamed:@"projectile_2"],
                          [SKTexture textureWithImageNamed:@"projectile_3"]];
    SKAction *singleShootingAnimation = [SKAction animateWithTextures:textures timePerFrame:0.1];
    SKAction *shootingAnimation = [SKAction repeatActionForever:singleShootingAnimation];
    [self runAction:shootingAnimation];
}

- (void)moveTowardsPosition:(CGPoint)position
{
//    Get position of offscreen point (trajectory end)
    float slope = (position.y - self.position.y) / (position.x - self.position.x);
    
    float offscreenX;
    if (position.x <= self.position.x)
        offscreenX = -10;
    else
        offscreenX = self.parent.self.frame.size.width + 10;
    
    float offscreenY = slope * (offscreenX - self.position.x) + self.position.y;
    
    CGPoint offscreenPoint = CGPointMake(offscreenX, offscreenY);

//    Calculate distance to offscreen point
    float xDistance = offscreenX - self.position.x;
    float yDistance = offscreenY - self.position.y;
    float distance = sqrtf(powf(xDistance, 2) + powf(yDistance, 2));
    
// Calculate time to reach point
    float time = distance / PTHYProjectileSpeed;
    float waitToFade = 0.75 * time;
    float fadeTime = time - waitToFade;
    
    NSArray *projectileFading = @[[SKAction waitForDuration:waitToFade],
                                   [SKAction fadeOutWithDuration:fadeTime],
                                   [SKAction removeFromParent]];
    SKAction *moveProjectile = [SKAction moveTo:offscreenPoint duration:time];

    [self runAction:moveProjectile];
    [self runAction:[SKAction sequence:projectileFading]];
}

@end
