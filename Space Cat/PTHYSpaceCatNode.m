//
//  PTHYSpaceCatNode.m
//  Space Cat
//
//  Created by Pierre Thalamy on 27/07/14.
//  Copyright (c) 2014 Pierre Thalamy. All rights reserved.
//

#import "PTHYSpaceCatNode.h"

@interface PTHYSpaceCatNode ()
@property (nonatomic) SKAction *tapAction;
@end

@implementation PTHYSpaceCatNode

+ (instancetype)spaceCatAtPosition:(CGPoint)position
{
    PTHYSpaceCatNode *spaceCat = [self spriteNodeWithImageNamed:@"spacecat_1"];
    spaceCat.position = position;
    spaceCat.anchorPoint = CGPointMake(0.5, 0);
    spaceCat.name = @"Space Cat";
    
    return spaceCat;
}

- (SKAction *)tapAction
{
    if (!_tapAction) {
        NSArray *textures = @[[SKTexture textureWithImageNamed:@"spacecat_2"],
                              [SKTexture textureWithImageNamed:@"spacecat_1"]];
        _tapAction = [SKAction animateWithTextures:textures timePerFrame:0.25];
    }
    return _tapAction;
}

- (void)performTap
{
    [self runAction:self.tapAction];
}

@end