//
//  PTHYSpaceDogNode.h
//  Space Cat
//
//  Created by Pierre Thalamy on 28/07/14.
//  Copyright (c) 2014 Pierre Thalamy. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

typedef NS_ENUM(NSUInteger, PTHYSpaceDogType) {
    PTHYSpaceDogTypeA = 0,
    PTHYSpaceDogTypeB = 1
};

@interface PTHYSpaceDogNode : SKSpriteNode

@property (nonatomic, assign) int health;
@property (nonatomic, assign) PTHYSpaceDogType type;

+ (instancetype)spaceDogOfType:(PTHYSpaceDogType)type;
- (void)setupPhysicsBody;

@end
