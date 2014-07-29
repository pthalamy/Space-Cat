//
//  PTHYGameplayScene.m
//  Space Cat
//
//  Created by Pierre Thalamy on 27/07/14.
//  Copyright (c) 2014 Pierre Thalamy. All rights reserved.
//

#import "PTHYGameplayScene.h"
#import "PTHYMachineNode.h"
#import "PTHYSpaceCatNode.h"
#import "PTHYProjectileNode.h"
#import "PTHYSpaceDogNode.h"
#import "PTHYGroundNode.h"
#import "PTHYUtils.h"
#import "PTHYHUDNode.h"
#import "PTHYGameOverNode.h"

#import <AVFoundation/AVFoundation.h>

@interface PTHYGameplayScene ()

@property (nonatomic) NSTimeInterval lastUpdateTimeInterval;
@property (nonatomic) NSTimeInterval timeSinceEnemyAdded;
@property (nonatomic) NSTimeInterval totalGameTime;
@property (nonatomic) NSInteger minSpeed;
@property (nonatomic) NSTimeInterval spawnEnemyTimeInterval;

@property (nonatomic) SKAction *damageSFX;
@property (nonatomic) SKAction *explodeSFX;
@property (nonatomic) SKAction *laserSFX;

@property (nonatomic) AVAudioPlayer *backgroundMusic;
@property (nonatomic) AVAudioPlayer *gameOverMusic;

@property (nonatomic) BOOL gameOver;
@property (nonatomic) BOOL restart;
@property (nonatomic) BOOL gameOverDisplayed;

@end

@implementation PTHYGameplayScene

-(id)initWithSize:(CGSize)size {
    if (self = [super initWithSize:size]) {
        
        self.lastUpdateTimeInterval = 0;
        self.timeSinceEnemyAdded = 0;
        self.spawnEnemyTimeInterval = 1.25;
        self.minSpeed = PTHYSpaceDogMinSpeed;
        
        self.restart = NO;
        self.gameOver = NO;
        self.gameOverDisplayed = NO;
        
        [self setupSounds];
        
        PTHYHUDNode *hud = [PTHYHUDNode HUDAtPosition:CGPointMake(0, self.frame.size.height - 20)
                                              inFrame:self.frame];
        [self addChild:hud];
        
        /* Setup your scene here */
        SKSpriteNode *background = [SKSpriteNode spriteNodeWithImageNamed:@"background_1"];
        background.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
        [self addChild:background];
        
        PTHYMachineNode *machine = [PTHYMachineNode machineAtPosition:
                                    CGPointMake(CGRectGetMidX(self.frame), 12)];
        [self addChild:machine];
        
        PTHYSpaceCatNode *spaceCat = [PTHYSpaceCatNode spaceCatAtPosition:
                                      CGPointMake(machine.position.x, machine.position.y - 2)];
        [self addChild:spaceCat];
        
        self.physicsWorld.gravity = CGVectorMake(0, -9.8);
        self.physicsWorld.contactDelegate = self;
        
        PTHYGroundNode *ground = [PTHYGroundNode groundWithSize:CGSizeMake(self.frame.size.width, 22)];
        [self addChild:ground];
    }
    return self;
}

-(void)didMoveToView:(SKView *)view
{
    [self.backgroundMusic play];
}

- (void)setupSounds
{
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"Gameplay" withExtension:@"mp3"];
    self.backgroundMusic = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
    self.backgroundMusic.numberOfLoops = -1;
    [self.backgroundMusic prepareToPlay];
    
    NSURL *gameOverurl = [[NSBundle mainBundle] URLForResource:@"GameOver" withExtension:@"mp3"];
    self.gameOverMusic = [[AVAudioPlayer alloc] initWithContentsOfURL:gameOverurl error:nil];
    self.gameOverMusic.numberOfLoops = 0;
    [self.gameOverMusic prepareToPlay];
    
    self.damageSFX = [SKAction playSoundFileNamed:@"Damage.caf"
                                waitForCompletion:NO];
    self.explodeSFX = [SKAction playSoundFileNamed:@"Explode.caf"
                                waitForCompletion:NO];
    self.laserSFX = [SKAction playSoundFileNamed:@"Laser.caf"
                                waitForCompletion:NO];
}

#pragma mark - gameplay loop methods
- (void)update:(NSTimeInterval)currentTime
{
    if (self.lastUpdateTimeInterval) {
        self.totalGameTime += currentTime - self.lastUpdateTimeInterval;
        self.timeSinceEnemyAdded += currentTime - self.lastUpdateTimeInterval;
    }
    
    if (self.timeSinceEnemyAdded > self.spawnEnemyTimeInterval && !self.gameOver) {
        [self spawnSpaceDog];
        self.timeSinceEnemyAdded = 0;
    }
    
    self.lastUpdateTimeInterval = currentTime;
    
    if (self.totalGameTime > 480) {
        self.spawnEnemyTimeInterval = 0.5;
        self.minSpeed = -160;
    } else if (self.totalGameTime > 240) {
        self.spawnEnemyTimeInterval = 0.65;
        self.minSpeed = -150;
    } else if (self.totalGameTime > 120) {
        self.spawnEnemyTimeInterval = 0.75;
        self.minSpeed = -125;
    } else if (self.totalGameTime > 30) {
        self.spawnEnemyTimeInterval = 1;
        self.minSpeed = -100;
    }
    
    if (self.gameOver && !self.gameOverDisplayed) {
        [self performGameOver];
    }
    
}

#pragma mark - action handlers
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (!self.gameOver) {
        for (UITouch *touch in touches) {
            CGPoint tapPosition = [touch locationInNode:self];
            [self shootProjectileTowardsPosition:tapPosition];
        }
    } else if (self.restart){
        for (SKNode *node in [self children]) {
            [node removeFromParent];
        }
        PTHYGameplayScene *newScene = [PTHYGameplayScene sceneWithSize:self.view.bounds.size];
        [self.view presentScene:newScene];
    }
}

- (void)performGameOver
{
    PTHYGameOverNode *gameOver = [PTHYGameOverNode gameOverAtPosition:
                                  CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame))];
    [self addChild:gameOver];
    [gameOver performAnimation];
    
    [self.backgroundMusic stop];
    [self.gameOverMusic play];

    self.restart = YES;
    self.gameOverDisplayed = YES;
}

- (void)shootProjectileTowardsPosition:(CGPoint)position
{
    PTHYSpaceCatNode *spaceCat = (PTHYSpaceCatNode*)[self childNodeWithName:@"Space Cat"];
    [spaceCat performTap];
    
    PTHYMachineNode *machine = (PTHYMachineNode*)[self childNodeWithName:@"Machine"];
    
    PTHYProjectileNode *projectile = [PTHYProjectileNode projectileAtPosition:CGPointMake(machine.position.x, machine.position.y + machine.frame.size.height - 15)];
    [self addChild:projectile];
    [projectile moveTowardsPosition:position];
    
    [self runAction:self.laserSFX];
}

#pragma mark - enemy spawning

- (void)spawnSpaceDog {
    NSInteger randomSpaceDog = [PTHYUtils randomWithMin:0 andMax:2];
    
    PTHYSpaceDogNode *spaceDog = [PTHYSpaceDogNode spaceDogOfType:randomSpaceDog];
    float dy = [PTHYUtils randomWithMin:PTHYSpaceDogMinSpeed andMax:PTHYSpaceDogMaxSpeed];
    spaceDog.physicsBody.velocity = CGVectorMake(0, dy);
    
    float y = self.frame.size.height + spaceDog.size.height;
    float x = [PTHYUtils randomWithMin:10 + spaceDog.size.width
                                andMax:self.frame.size.width - spaceDog.frame.size.width - 10];
    
    spaceDog.position = CGPointMake(x, y);

    [self addChild:spaceDog];
}

#pragma mark - Contacts

- (void)didBeginContact:(SKPhysicsContact *)contact
{
    SKPhysicsBody *firstBody, *secondBody;
    
    if (contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask) {
        firstBody = contact.bodyA;
        secondBody = contact.bodyB;
    } else {
        firstBody = contact.bodyB;
        secondBody = contact.bodyA;
    }
    
    if (firstBody.categoryBitMask == PTHYCollisionCategoryEnemy &&
        secondBody.categoryBitMask == PTHYCollisionCategoryProjectile) {
        
        PTHYSpaceDogNode *spaceDog = (PTHYSpaceDogNode*)firstBody.node;
        PTHYProjectileNode *projectile = (PTHYProjectileNode*)secondBody.node;
        
        // Decrement space dog's health, if it hits 0, then it explodes!!!
        spaceDog.health -= PTHYProjectileHitPoints;
        
        if (spaceDog.health <= 0) {
            [self runAction:self.explodeSFX];
            [self createDebrisAtPosition:contact.contactPoint];

            [self addPoints:PTHYPointsPerKill];
            
            [spaceDog removeFromParent];
        } else {
            [spaceDog removeAllActions];
            if (spaceDog.type == PTHYSpaceDogTypeA) {
                [spaceDog runAction:[SKAction setTexture:
                                     [SKTexture textureWithImageNamed:@"spacedog_A_3"]]];
            } else {
                [spaceDog runAction:
                 [SKAction setTexture:[SKTexture textureWithImageNamed:@"spacedog_B_4"]]];
            }

            [self addPoints:PTHYPointsPerHit];
        }

        [projectile removeFromParent];
        
    } else if (firstBody.categoryBitMask == PTHYCollisionCategoryEnemy &&
               secondBody.categoryBitMask == PTHYCollisionCategoryGround) {

        PTHYSpaceDogNode *spaceDog = (PTHYSpaceDogNode*)firstBody.node;

        [self loseLife];
        
        [self runAction:self.damageSFX];
        [self createDebrisAtPosition:contact.contactPoint];
        
        [spaceDog removeFromParent];
    }
}

#pragma mark - create Debris

- (void)createDebrisAtPosition:(CGPoint)position
{
    NSInteger numberOfPieces = [PTHYUtils randomWithMin:5 andMax:20];
    
    for (int i = 0; i < numberOfPieces; i++) {
        NSInteger randomPiece = [PTHYUtils randomWithMin:1 andMax:4];
        NSString *imageName = [NSString stringWithFormat:@"debri_%d", randomPiece];
        
        SKSpriteNode *debris = [SKSpriteNode spriteNodeWithImageNamed:imageName];
        debris.position = position;
        [self addChild:debris];
        
        debris.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:debris.frame.size];
        debris.physicsBody.categoryBitMask = PTHYCollisionCategoryDebris;
        debris.physicsBody.contactTestBitMask = 0;
        debris.physicsBody.collisionBitMask = PTHYCollisionCategoryGround | PTHYCollisionCategoryDebris;
        debris.name = @"Debris";
        
        debris.physicsBody.velocity = CGVectorMake([PTHYUtils randomWithMin:-150 andMax:150],
                                                   [PTHYUtils randomWithMin:-350 andMax:350]);
        [debris runAction:[SKAction waitForDuration:2.0]
                completion:^{[debris removeFromParent];}];
    }
    
    NSString *explosionPath = [[NSBundle mainBundle] pathForResource:@"Explosion" ofType:@"sks"];
    SKEmitterNode *explosion = [NSKeyedUnarchiver unarchiveObjectWithFile:explosionPath];
    explosion.position = position;
    [self addChild:explosion];
    [explosion runAction:[SKAction waitForDuration:2.0]
              completion:^{[explosion removeFromParent];}];
}

- (void)addPoints:(NSInteger)points
{
    PTHYHUDNode *hud = (PTHYHUDNode*)[self childNodeWithName:@"HUD"];
    [hud addPoints:points];
}

- (void)loseLife
{
    PTHYHUDNode *hud = (PTHYHUDNode*)[self childNodeWithName:@"HUD"];
    self.gameOver = [hud loseLife];
}

@end
