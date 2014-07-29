//
//  PTHYMachineNode.m
//  Space Cat
//
//  Created by Pierre Thalamy on 27/07/14.
//  Copyright (c) 2014 Pierre Thalamy. All rights reserved.
//

#import "PTHYMachineNode.h"

@implementation PTHYMachineNode

+ (instancetype)machineAtPosition:(CGPoint)position
{
    PTHYMachineNode *machine = [self spriteNodeWithImageNamed:@"machine_1"];
    machine.position = position;
    machine.anchorPoint = CGPointMake(0.5, 0);
    machine.zPosition = 8;
    machine.name = @"Machine";
    
    NSArray *textures = @[[SKTexture textureWithImageNamed:@"machine_1"],
                          [SKTexture textureWithImageNamed:@"machine_2"]];
    
    SKAction *machineAnimation = [SKAction animateWithTextures:textures timePerFrame:0.1];
    
    SKAction *machineRepeat = [SKAction repeatActionForever:machineAnimation];
    [machine runAction:machineRepeat];
    
    return machine;
}

@end
