//
//  PTHYSpaceCatNode.h
//  Space Cat
//
//  Created by Pierre Thalamy on 27/07/14.
//  Copyright (c) 2014 Pierre Thalamy. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface PTHYSpaceCatNode : SKSpriteNode

+ (instancetype)spaceCatAtPosition:(CGPoint)position;
- (void)performTap;

@end
