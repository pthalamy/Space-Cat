//
//  PTHYGameplayScene.m
//  Space Cat
//
//  Created by Pierre Thalamy on 27/07/14.
//  Copyright (c) 2014 Pierre Thalamy. All rights reserved.
//

#import "PTHYGameplayScene.h"
#import "PTHYMachineNode.h"
#import "PTHYSpaceCatNode.h"
#import "PTHYProjectileNode.h"

@implementation PTHYGameplayScene

-(id)initWithSize:(CGSize)size {
    if (self = [super initWithSize:size]) {
        /* Setup your scene here */
        SKSpriteNode *background = [SKSpriteNode spriteNodeWithImageNamed:@"background_1"];
        background.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
        [self addChild:background];
        
        PTHYMachineNode *machine = [PTHYMachineNode machineAtPosition:
                                    CGPointMake(CGRectGetMidX(self.frame), 12)];
        [self addChild:machine];
        
        PTHYSpaceCatNode *spaceCat = [PTHYSpaceCatNode spaceCatAtPosition:
                                      CGPointMake(machine.position.x, machine.position.y - 2)];
        [self addChild:spaceCat];
    }
    return self;
}

#pragma mark - gameplay loop methods
- (void)update:(NSTimeInterval)currentTime
{
    
}

#pragma mark - action handlers
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    for (UITouch *touch in touches) {
        CGPoint tapPosition = [touch locationInNode:self];
        [self shootProjectileTowardsPosition:tapPosition];
    }
}

- (void)shootProjectileTowardsPosition:(CGPoint)position
{
    PTHYSpaceCatNode *spaceCat = (PTHYSpaceCatNode*)[self childNodeWithName:@"Space Cat"];
    [spaceCat performTap];
    
    PTHYMachineNode *machine = (PTHYMachineNode*)[self childNodeWithName:@"Machine"];
    
    PTHYProjectileNode *projectile = [PTHYProjectileNode projectileAtPosition:CGPointMake(machine.position.x, machine.position.y + machine.frame.size.height - 15)];
    [self addChild:projectile];
    [projectile moveTowardsPosition:position];
}

@end
