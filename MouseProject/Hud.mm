//
//  Hud.m
//  MouseProject
//
//  Created by Mr. HiQ on 04.08.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Hud.h"
#import "HelloWorldLayer.h"
#import "GMath.h"


@implementation Hud


-(id) init
{    
    self = [super initWithFile:@"ENERGY.png" capacity:20];
    //self = [super initWithFile:@"jungle.pvr.ccz" capacity:20];
    
    if(self)
    {
        // 1 - Create health tokens
        for(int i=0; i<MAX_HEALTH_TOKENS; i++)
        {
            const float ypos = 290.0f;
            const float margin = 40.0f;
            const float spacing = 20.0f;
            
            healthTokens[i] = [CCSprite spriteWithFile:@"ENERGY.png"];
            
            //healthTokens[i] = [CCSprite spriteWithSpriteFrameName:@"hud/banana.png"];
            //CCSprite *mole1 = [CCSprite spriteWithSpriteFrameName:@"mole_1.png"];

            
            
            healthTokens[i].position = ccp(margin+i*spacing, ypos);
            healthTokens[i].visible = NO;
            [self addChild:healthTokens[i]];            
        }        
    }
    
    return self;
}

-(void) setHealth:(float) health_
{
    
    NSLog(@"health в методе SET = %f",health_);
    
    // 1 - Change current health
    currentHealth = health_;
         
    // 2 - Get number of healthToken to display
    int healthToken = round(MAX_HEALTH_TOKENS * currentHealth / HUMAN_MAX_HEALTH);
    NSLog(@"currentHealth = %f",currentHealth);
    NSLog(@"healthToken = %d",healthToken);
    NSLog(@"MAX_HEALTH_TOKENS = %d",MAX_HEALTH_TOKENS);
    NSLog(@"HUMAN_MAX_HEALTH = %f",HUMAN_MAX_HEALTH);
    
    
    
    // 3 - Set visible health tokens
    int i=0;
    for(; i<healthToken; i++)
    {
        healthTokens[i].visible = YES;
        NSLog(@"Отображать поинты Жизней - Даааа.");
    }
    
    // 4 - Set invisible health tokens
    for(; i<MAX_HEALTH_TOKENS; i++)
    {
        healthTokens[i].visible = NO;
        NSLog(@"Отображать поинты Жизней - Неееет.");
    }
}



@end
