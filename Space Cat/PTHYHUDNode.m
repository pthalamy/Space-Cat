//
//  PTHYHUDNode.m
//  Space Cat
//
//  Created by Pierre Thalamy on 29/07/14.
//  Copyright (c) 2014 Pierre Thalamy. All rights reserved.
//

#import "PTHYHUDNode.h"
#import "PTHYUtils.h"

@implementation PTHYHUDNode

+ (instancetype)HUDAtPosition:(CGPoint)position inFrame:(CGRect)frame
{
    PTHYHUDNode *hud = [self node];
    hud.name = @"HUD";
    hud.position = position;
    hud.zPosition = 10;
    
    SKSpriteNode *catHead = [SKSpriteNode spriteNodeWithImageNamed:@"HUD_cat_1"];
    catHead.position = CGPointMake(30, -10);
    [hud addChild:catHead];
    
    hud.lives = PTHYMaxLives;
    hud.remainingLives = hud.lives;
    
    SKSpriteNode *lastLifeBar;
    
    for (int i = 0; i < hud.lives; ++i) {
        SKSpriteNode *lifeBar = [SKSpriteNode spriteNodeWithImageNamed:@"HUD_life_1"];
        lifeBar.name = [NSString stringWithFormat:@"Life %d", i+1];
        
        [hud addChild:lifeBar];
        
        if (lastLifeBar == nil) {
            lifeBar.position = CGPointMake(catHead.position.x+30, catHead.position.y);
        } else {
            lifeBar.position = CGPointMake(lastLifeBar.position.x+10, lastLifeBar.position.y);
        }
        
        lastLifeBar = lifeBar;
    }
 
    SKLabelNode *scoreLabel = [SKLabelNode labelNodeWithFontNamed:@"Futura-CondensedExtraBold"];
    scoreLabel.name = @"Score";
    scoreLabel.text = @"0";
    scoreLabel.fontSize = 24;
    scoreLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeRight;
    scoreLabel.position = CGPointMake(frame.size.width - 20, -10);
    [hud addChild:scoreLabel];
    
    return hud;
}

- (void)addPoints:(NSInteger)points
{
    self.score += points;
    
    SKLabelNode *scoreLabel = (SKLabelNode*)[self childNodeWithName:@"Score"];
    scoreLabel.text = [NSString stringWithFormat:@"%d", self.score];
}

- (BOOL)loseLife
{
    if (self.lives > 0) {
        SKNode *lifeToRemove = (SKSpriteNode*)[self childNodeWithName:
                                                [NSString stringWithFormat:@"Life %d", self.lives]];
        self.lives--;
        [lifeToRemove removeFromParent];
    }
    return self.lives == 0;
}

@end