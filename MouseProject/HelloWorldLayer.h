//
//  HelloWorldLayer.h
//  MouseProject
//
//  Created by Mr. HiQ on 20.07.12.
//  Copyright __MyCompanyName__ 2012. All rights reserved.
//


// When you import this file, you import all the cocos2d classes
#import "cocos2d.h"

#define HUMAN_MAX_HEALTH 50.0f


@class Hud;
@class HelloWorldLayer;

// HelloWorldLayer
@interface HelloWorldLayer : CCLayer {
   
    
        
    NSMutableArray *moles;
    CCAnimation *laughAnim;
    CCAnimation *hitAnim;
    
    CCLabelTTF *label;
    int score;
    int totalSpawns;
    BOOL gameOver;
    
    
    
    Hud *hud;
    float healthGeneral;
    HelloWorldLayer *helloWorldLayer; 

}



@property (assign) float healthGeneral;
@property (readonly) bool isDead;




// returns a CCScene that contains the HelloWorldLayer as the only child
+(CCScene *) scene;

@end
