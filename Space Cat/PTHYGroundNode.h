//
//  PTHYGroundNode.h
//  Space Cat
//
//  Created by Pierre Thalamy on 28/07/14.
//  Copyright (c) 2014 Pierre Thalamy. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface PTHYGroundNode : SKSpriteNode

+ (instancetype)groundWithSize:(CGSize)size;
- (void)setupPhysicsBody;

@end
