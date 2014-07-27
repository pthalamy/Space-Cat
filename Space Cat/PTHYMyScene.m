//
//  PTHYMyScene.m
//  Space Cat
//
//  Created by Pierre Thalamy on 27/07/14.
//  Copyright (c) 2014 Pierre Thalamy. All rights reserved.
//

#import "PTHYMyScene.h"

@implementation PTHYMyScene

-(id)initWithSize:(CGSize)size {    
    if (self = [super initWithSize:size]) {
        /* Setup your scene here */
        
        self.backgroundColor = [SKColor colorWithRed:0.15 green:0.15 blue:0.3 alpha:1.0];
        
        SKSpriteNode *greenNode = [SKSpriteNode spriteNodeWithColor:[SKColor greenColor]
                                                               size:CGSizeMake(15, 150)];
        greenNode.position = CGPointMake(10, 10);
        greenNode.anchorPoint = CGPointMake(0, 0);
        [self addChild:greenNode];
        
        SKSpriteNode *redNode = [SKSpriteNode spriteNodeWithColor:[SKColor redColor]
                                                             size:CGSizeMake(150, 15)];
        redNode.position = CGPointMake(10, 10);
        redNode.anchorPoint = CGPointMake(0, 0);
        [self addChild:redNode];
    }
    return self;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    /* Called when a touch begins */
    
    for (UITouch *touch in touches) {
        CGPoint location = [touch locationInNode:self];
        
        SKSpriteNode *sprite = [SKSpriteNode spriteNodeWithImageNamed:@"Spaceship"];
        
        sprite.position = location;
        
        SKAction *action = [SKAction rotateByAngle:M_PI duration:1];
        
        [sprite runAction:[SKAction repeatActionForever:action]];
        
        [self addChild:sprite];
    }
}

-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
}

@end
