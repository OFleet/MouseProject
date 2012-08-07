//
//  HelloWorldLayer.m
//  MouseProject
//
//  Created by Mr. HiQ on 20.07.12.
//  Copyright __MyCompanyName__ 2012. All rights reserved.
//


// Import the interfaces
#import "HelloWorldLayer.h"
#import "SimpleAudioEngine.h"
#import "Hud.h"



// HelloWorldLayer implementation
@implementation HelloWorldLayer


@synthesize healthGeneral;



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


-(bool) isDead
{
    return healthGeneral <= 0.0f;
}


- (CCAnimation *)animationFromPlist:(NSString *)animPlist delay:(float)delay {
    NSLog(@"В методе animationFromPlist.");
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:animPlist ofType:@"plist"]; // 1
    NSArray *animImages = [NSArray arrayWithContentsOfFile:plistPath]; // 2
    NSMutableArray *animFrames = [NSMutableArray array]; // 3
        
    for(NSString *animImage in animImages) { // 4
        NSLog(@"В цикле.");
        [animFrames addObject:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:animImage]]; // 5
    }
    return [CCAnimation animationWithFrames:animFrames delay:delay]; // 6
    NSLog(@"Конец метода animationFromPlist.");
}

-(void) registerWithTouchDispatcher
{
	[[CCTouchDispatcher sharedDispatcher] addTargetedDelegate:self priority:kCCMenuTouchPriority swallowsTouches:NO];
}

-(BOOL) ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event
{ 
    CGPoint touchLocation = [self convertTouchToNodeSpace:touch];
    for (CCSprite *mole in moles) {
        if (mole.userData == FALSE) continue;
        if (CGRectContainsPoint(mole.boundingBox, touchLocation)) {
            
            [[SimpleAudioEngine sharedEngine] playEffect:@"ow.caf"];
            mole.userData = FALSE;            
            score+= 10;
            healthGeneral-=10;
            
            [mole stopAllActions];
            CCAnimate *hit = [CCAnimate actionWithAnimation:hitAnim restoreOriginalFrame:NO];
            CCMoveBy *moveDown = [CCMoveBy actionWithDuration:0.8 position:ccp(0, -mole.contentSize.height)];
            CCEaseInOut *easeMoveDown = [CCEaseInOut actionWithAction:moveDown rate:3.0];
            [mole runAction:[CCSequence actions:hit, easeMoveDown, nil]];
        }
    }    
    return TRUE;
}

- (void)setTappable:(id)sender {
    [[SimpleAudioEngine sharedEngine] playEffect:@"laugh.caf"];
    CCSprite *mole = (CCSprite *)sender;    
    [mole setUserData:YES];
    
}


- (void)unsetTappable:(id)sender {
    CCSprite *mole = (CCSprite *)sender;
    [mole setUserData:FALSE];
}



- (void) popMole:(CCSprite *)mole {
    NSLog(@"В методе popMole.");
    
    
    if (totalSpawns > 15) return;
    totalSpawns++;
    
    [mole setDisplayFrame:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"mole_1.png"]];
    
    
    CCMoveBy *moveUp = [CCMoveBy actionWithDuration:0.2 position:ccp(0, mole.contentSize.height)]; // 1
    CCCallFunc *setTappable = [CCCallFuncN actionWithTarget:self selector:@selector(setTappable:)];
    CCEaseInOut *easeMoveUp = [CCEaseInOut actionWithAction:moveUp rate:3.0]; // 2
    //CCDelayTime *delay = [CCDelayTime actionWithDuration:0.7]; // 4
    
    CCAnimate *laugh = [CCAnimate actionWithAnimation:laughAnim restoreOriginalFrame:YES];
    
    CCCallFunc *unsetTappable = [CCCallFuncN actionWithTarget:self selector:@selector(unsetTappable:)];  
    CCAction *easeMoveDown = [easeMoveUp reverse]; // 3
    
    [mole runAction:[CCSequence actions:easeMoveUp, setTappable, laugh, unsetTappable, easeMoveDown, nil]]; // 5
    
    NSLog(@"Конец метода popMole.");
}


- (float)convertFontSize:(float)fontSize {
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        return fontSize * 2;
    } else {
        return fontSize;
    }
}


- (void)tryPopMoles:(ccTime)dt {
    
    if (gameOver) return;
    
    [label setString:[NSString stringWithFormat:@"Score: %d", score]];
     
    
    
    if (healthGeneral <= 0) {
        
        CGSize winSize = [CCDirector sharedDirector].winSize;
        CCLabelTTF *goLabel = [CCLabelTTF labelWithString:@"Game Over!" fontName:@"Verdana" fontSize:[self convertFontSize:48.0]];
        
        goLabel.position = ccp(winSize.width/2, winSize.height/2);
        goLabel.scale = 0.1;
        [self addChild:goLabel z:10];                
        [goLabel runAction:[CCScaleTo actionWithDuration:0.5 scale:1.0]];
        
        gameOver = true;
        return;
        
    }
    
    if (totalSpawns >= 15) {
        
        CGSize winSize = [CCDirector sharedDirector].winSize;
        CCLabelTTF *goLabel = [CCLabelTTF labelWithString:@"Level Complete!" fontName:@"Verdana" fontSize:[self convertFontSize:48.0]];
       
        goLabel.position = ccp(winSize.width/2, winSize.height/2);
        goLabel.scale = 0.1;
        [self addChild:goLabel z:10];                
        [goLabel runAction:[CCScaleTo actionWithDuration:0.5 scale:1.0]];
        
        gameOver = true;
        return;
        
    }
    
    
    for (CCSprite *mole in moles) {            
        if (arc4random() % 5 == 0) {
            if (mole.numberOfRunningActions == 0) {
                [self popMole:mole];
            }
        }
    }     
}





-(id) init
{
	if( (self=[super init])) {
		
        [[SimpleAudioEngine sharedEngine] preloadEffect:@"laugh.caf"];
        [[SimpleAudioEngine sharedEngine] preloadEffect:@"ow.caf"];
        [[SimpleAudioEngine sharedEngine] playBackgroundMusic:@"whack.caf" loop:YES];
        
        [CCTexture2D setDefaultAlphaPixelFormat:kCCTexture2DPixelFormat_RGBA8888];        
        CGSize winSize = [CCDirector sharedDirector].winSize;
        
        
        // set health
        healthGeneral = HUMAN_MAX_HEALTH;
        NSLog(@"init healthGeneral = %f",healthGeneral);
        NSLog(@"init HUMAN_MAX_HEALTH = %f",HUMAN_MAX_HEALTH);
        
        
        // add hud
        hud = [[[Hud alloc] init] autorelease];
        [self addChild:hud z:10000];
        
        
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
        NSLog(@"Вызов метода tryPopMoles.");
        
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
        
        
        
        laughAnim = [self animationFromPlist:@"laughAnim" delay:0.1];   
        NSLog(@"Вызов метода animationFromPlist laughAnim."); 
        hitAnim = [self animationFromPlist:@"hitAnim" delay:0.02];
        NSLog(@"Вызов метода animationFromPlist hitAnim.");
        [[CCAnimationCache sharedAnimationCache] addAnimation:laughAnim name:@"laughAnim"];
        [[CCAnimationCache sharedAnimationCache] addAnimation:hitAnim name:@"hitAnim"];
        
        self.isTouchEnabled = YES;
        
        float margin = 10;
        label = [CCLabelTTF labelWithString:@"Score: 0" fontName:@"Verdana" fontSize:[self convertFontSize:14.0]];
        label.anchorPoint = ccp(1, 0);
        label.position = ccp(winSize.width - margin, margin);
        [self addChild:label z:10];
        
        
        [self schedule: @selector(update:) interval:0.5];
    
    
    }
    
	return self;
}


-(void) update: (ccTime) dt
{
        
    // show human's health in tokens on layer
    [hud setHealth:healthGeneral];
    
    
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
