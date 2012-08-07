//
//  Hud.h
//  MouseProject
//
//  Created by Mr. HiQ on 04.08.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#pragma once

#import "Cocos2d.h"
#import "CCSpriteBatchNode.h"

#define MAX_HEALTH_TOKENS 5

@interface Hud : CCSpriteBatchNode
{
    CCSprite *healthTokens[MAX_HEALTH_TOKENS];
    float currentHealth;
   
    
}

-(id) init;
-(void) setHealth:(float) health_;






@end