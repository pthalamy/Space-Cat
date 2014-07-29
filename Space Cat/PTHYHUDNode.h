//
//  PTHYHUDNode.h
//  Space Cat
//
//  Created by Pierre Thalamy on 29/07/14.
//  Copyright (c) 2014 Pierre Thalamy. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface PTHYHUDNode : SKNode

@property (nonatomic) NSInteger lives;
@property (nonatomic) NSInteger remainingLives;
@property (nonatomic) NSInteger score;

+ (instancetype)HUDAtPosition:(CGPoint)position inFrame:(CGRect)frame;

- (void)addPoints:(NSInteger)points;
- (BOOL)loseLife;

@end
