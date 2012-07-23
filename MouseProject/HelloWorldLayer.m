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

// on "init" you need to initialize your instance
-(id) init
{
	// always call "super" init
	// Apple recommends to re-assign "self" with the "super" return value
	if( (self=[super init])) {
		
        [CCTexture2D setDefaultAlphaPixelFormat:kCCTexture2DPixelFormat_RGBA8888];        
        CGSize winSize = [CCDirector sharedDirector].winSize;
        CCSprite * background = [CCSprite spriteWithFile:@"background.pvr.ccz"];
        //background.anchorPoint = ccp(0,0);
        background.scale = 2;
        background.position = ccp(winSize.width/2, winSize.height/3);
        [self addChild:background];

        
        //NSString *fgSheet = @"foreground2.pvr.ccz";
        //NSString *fgPlist = @"foreground.plist";
        //[[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:fgPlist];
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"foreground2.plist"];
        
        //[[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"exampleZwoptexGenerated.plist"];
        //CCSpriteFrame *frame = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"anImage.png"];
        //CCSprite *mySprite = [CCSprite spriteWithSpriteFrame:frame];
        //[self addChild:myHandSprite];
        
        
        /*
		// Determine names of sprite sheets and plists to load
        NSString *bgSheet = @"background.pvr.ccz";
        NSString *bgPlist = @"background.plist";
        NSString *fgSheet = @"foreground.pvr.ccz";
        NSString *fgPlist = @"foreground.plist";
        //NSString *sSheet = @"sprites.pvr.ccz";
        //NSString *sPlist = @"sprites.plist";
                
        // Load background and foreground
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:bgPlist];       
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:fgPlist];
        
        // Add background
        CGSize winSize = [CCDirector sharedDirector].winSize;
        CCSprite *dirt = [CCSprite spriteWithSpriteFrameName:@"bg_dirt.png"];
        dirt.scale = 2.0;
        dirt.position = ccp(winSize.width/2, winSize.height/2);
        [self addChild:dirt z:-2]; 
        
        // Add foreground
        CCSprite *lower = [CCSprite spriteWithSpriteFrameName:@"grass_lower.png"];
        lower.anchorPoint = ccp(0.5, 1);
        lower.position = ccp(winSize.width/2, winSize.height/2);
        [self addChild:lower z:1];
        
        CCSprite *upper = [CCSprite spriteWithSpriteFrameName:@"grass_upper.png"];
        upper.anchorPoint = ccp(0.5, 0);
        upper.position = ccp(winSize.width/2, winSize.height/2);
        [self addChild:upper z:-1];
        
        // Add more here later...
        */
                
        
        
        /*
        // create and initialize a Label
		CCLabelTTF *label = [CCLabelTTF labelWithString:@"Hello World" fontName:@"Marker Felt" fontSize:64];

		// ask director the the window size
		CGSize size = [[CCDirector sharedDirector] winSize];
	
		// position the label on the center of the screen
		label.position =  ccp( size.width /2 , size.height/2 );
		
		// add the label as a child to this Layer
		[self addChild: label];
         */
         
	}
	return self;
}

// on "dealloc" you need to release all your retained objects
- (void) dealloc
{
	// in case you have something to dealloc, do it in this method
	// in this particular example nothing needs to be released.
	// cocos2d will automatically release all the children (Label)
	
	// don't forget to call "super dealloc"
	[super dealloc];
}
@end
