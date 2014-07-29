//
//  PTHYTitleScene.m
//  Space Cat
//
//  Created by Pierre Thalamy on 27/07/14.
//  Copyright (c) 2014 Pierre Thalamy. All rights reserved.
//

#import "PTHYTitleScene.h"
#import "PTHYGameplayScene.h"
#import <AVFoundation/AVFoundation.h>

@interface PTHYTitleScene ()
@property (nonatomic) SKAction *pressStartSFX;
@property (nonatomic) AVAudioPlayer *backgroundMusic;
@end

@implementation PTHYTitleScene

-(id)initWithSize:(CGSize)size {
    if (self = [super initWithSize:size]) {
        /* Setup your scene here */
        SKSpriteNode *background = [SKSpriteNode spriteNodeWithImageNamed:@"splash_1"];
        background.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
        [self addChild:background];
    
        self.pressStartSFX = [SKAction playSoundFileNamed:@"PressStart.caf"
                                        waitForCompletion:NO];
        
        NSURL *url = [[NSBundle mainBundle] URLForResource:@"StartScreen" withExtension:@"mp3"];
        self.backgroundMusic = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
        self.backgroundMusic.numberOfLoops = -1;

        [self.backgroundMusic prepareToPlay];
    }
    return self;
}

- (void)didMoveToView:(SKView *)view
{
    [self.backgroundMusic play];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self runAction:self.pressStartSFX];
    [self.backgroundMusic stop];
    
    PTHYGameplayScene *gameplayScene = [PTHYGameplayScene sceneWithSize:self.frame.size];
    SKTransition *transition = [SKTransition fadeWithDuration:1.0];
    [self.view presentScene:gameplayScene transition:transition];
}

@end
