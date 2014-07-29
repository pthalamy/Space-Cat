//
//  PTHYGameOverNode.h
//  Space Cat
//
//  Created by Pierre Thalamy on 29/07/14.
//  Copyright (c) 2014 Pierre Thalamy. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface PTHYGameOverNode : SKNode

+ (instancetype)gameOverAtPosition:(CGPoint)position;

- (void)performAnimation;

@end
