//
//  HelloWorldLayer.m
//  MouseProject
//
//  Created by Mr. HiQ on 20.07.12.
//  Copyright __MyCompanyName__ 2012. All rights reserved.
//


// Import the interfaces
#import "HelloWorldLayer.h"

// HelloWorldLayer implementation
@implementation HelloWorldLayer

+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	HelloWorldLayer *layer = [HelloWorldLayer node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}

- (void) popMole:(CCSprite *)mole {          
    CCMoveBy *moveUp = [CCMoveBy actionWithDuration:0.2 position:ccp(0, mole.contentSize.height)]; // 1
    CCEaseInOut *easeMoveUp = [CCEaseInOut actionWithAction:moveUp rate:3.0]; // 2
    CCAction *easeMoveDown = [easeMoveUp reverse]; // 3
    CCDelayTime *delay = [CCDelayTime actionWithDuration:0.7]; // 4
    
    [mole runAction:[CCSequence actions:easeMoveUp, delay, easeMoveDown, nil]]; // 5
}

- (void)tryPopMoles:(ccTime)dt {
    for (CCSprite *mole in moles) {            
        if (arc4random() % 7 == 0) {
            if (mole.numberOfRunningActions == 0) {
                [self popMole:mole];
            }
        }
    }     
}

-(id) init
{
	if( (self=[super init])) {
		
        [CCTexture2D setDefaultAlphaPixelFormat:kCCTexture2DPixelFormat_RGBA8888];        
        CGSize winSize = [CCDirector sharedDirector].winSize;
        
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"background.plist"];
        CCSprite *background = [CCSprite spriteWithSpriteFrameName:@"bg_dirt.png"];
        //background.anchorPoint = ccp(0.0, 0.0);
        background.scale = 2;
        background.position = ccp(winSize.width/2, winSize.height/3);
        [self addChild:background z:-2];
       
        /*
        CCSprite *background = [CCSprite spriteWithFile:@"background.pvr.ccz"];
        //background.anchorPoint = ccp(0,0);
        background.scale = 2;
        background.position = ccp(winSize.width/2, winSize.height/3);
        [self addChild:background z:-2];
        */
        
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"foregroundTP.plist"];
        
        CCSprite *lower = [CCSprite spriteWithSpriteFrameName:@"grass_lower.png"];
        lower.anchorPoint = ccp(0.5, 1);
        lower.position = ccp(winSize.width/2, winSize.height/2);
        [self addChild:lower z:1];

        CCSprite *upper = [CCSprite spriteWithSpriteFrameName:@"grass_upper.png"];
        upper.anchorPoint = ccp(0.5, 0);
        upper.position = ccp(winSize.width/2, winSize.height/2);
        [self addChild:upper z:-1];
        
        
        
        
        [self schedule:@selector(tryPopMoles:) interval:0.5];
        
        NSString *sSheet = @"sprites.png";
        NSString *sPlist = @"sprites.plist";
        
        CCSpriteBatchNode *spriteNode = [CCSpriteBatchNode batchNodeWithFile:sSheet];
        [self addChild:spriteNode z:0];
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:sPlist];      
        
        moles = [[NSMutableArray alloc] init];
        
        CCSprite *mole1 = [CCSprite spriteWithSpriteFrameName:@"mole_1.png"];
        mole1.position = ccp(winSize.width/5, winSize.height/3.2);
        [spriteNode addChild:mole1];
        [moles addObject:mole1];
        
        CCSprite *mole2 = [CCSprite spriteWithSpriteFrameName:@"mole_1.png"];
        mole2.position = ccp(winSize.width/2, winSize.height/3.2);
        [spriteNode addChild:mole2];
        [moles addObject:mole2];
        
        CCSprite *mole3 = [CCSprite spriteWithSpriteFrameName:@"mole_1.png"];
        mole3.position = ccp(winSize.width/1.25, winSize.height/3.2);
        [spriteNode addChild:mole3];
        [moles addObject:mole3];
        
                
        }
    
	return self;
}


- (void) dealloc
{
	// in case you have something to dealloc, do it in this method
	// in this particular example nothing needs to be released.
	// cocos2d will automatically release all the children (Label)
	// don't forget to call "super dealloc"
	[super dealloc];
    
    [moles release];
    moles = nil;
    
}
@end
