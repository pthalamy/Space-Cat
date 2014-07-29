//
//  PTHYGameOverNode.m
//  Space Cat
//
//  Created by Pierre Thalamy on 29/07/14.
//  Copyright (c) 2014 Pierre Thalamy. All rights reserved.
//

#import "PTHYGameOverNode.h"

@implementation PTHYGameOverNode

+ (instancetype)gameOverAtPosition:(CGPoint)position
{
    PTHYGameOverNode *gameOver = [self node];
    
    SKLabelNode *gameOverLabel = [SKLabelNode labelNodeWithFontNamed:@"Futura-CondensedExtraBold"];
    gameOverLabel.name = @"Game Over";
    gameOverLabel.text = @"Game Over";
    gameOverLabel.fontSize = 48;
    gameOverLabel.position = position;
    
    [gameOver addChild:gameOverLabel];
    
    return gameOver;
}

- (void)performAnimation
{
    SKLabelNode *label = (SKLabelNode*)[self childNodeWithName:@"Game Over"];
    label.xScale = 0;
    label.yScale = 0;
    
    SKAction *scaleUp = [SKAction scaleTo:1.2f duration:0.75f];
    SKAction *scaleDown = [SKAction scaleTo:0.9f duration:0.25f];
    
    SKAction *run = [SKAction runBlock:^{
        SKLabelNode *touchToRestart = [SKLabelNode labelNodeWithFontNamed:@"Futura-CondensedExtraBold"];
    
        touchToRestart.text = @"Touch To Restart";
        touchToRestart.fontSize = 24;
        touchToRestart.position = CGPointMake(label.position.x, label.position.y - 40);
        
        SKAction *blink = [SKAction repeatActionForever:
                           [SKAction sequence:@[[SKAction waitForDuration:0.5],
                                                [SKAction fadeOutWithDuration:0.2],
                                                [SKAction waitForDuration:0.5],
                                                [SKAction fadeInWithDuration:0.2]]]];
        [touchToRestart runAction:blink];
        [self addChild:touchToRestart];
    }];
    
    SKAction *scale = [SKAction sequence:@[scaleUp, scaleDown, run]];
    [label runAction:scale];
}

@end
