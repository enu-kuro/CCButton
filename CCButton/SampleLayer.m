//
//  SampleLayer.m
//  CCButton
//
//  Created by Kurose Nobuhito on 13/03/11.
//  Copyright 2013年 __MyCompanyName__. All rights reserved.
//

#import "SampleLayer.h"
#import "CCButton.h"


@implementation SampleLayer
+(id) scene
{
    CCScene *scene = [CCScene node];
    CCLayer* layer = [SampleLayer node];
    [scene addChild:layer];
    return scene;
}

#pragma mark - 初期化
-(id) init{
    
	if( (self=[super init])) {
        
        [self setUpParts];
        
    }
    
	return self;
}

- (void)setUpParts
{
    CGSize windowSize = [[CCDirector sharedDirector] winSize];
    CCSprite *normalSprite = [CCSprite spriteWithFile:@"Icon.png"];
    CCSprite *selectedSprite = [CCSprite spriteWithFile:@"Icon-72.png"];
    CCButton *button =[CCButton buttonWithNormalSprite:normalSprite selectedSprite:selectedSprite target:self action:@selector(touchUpInSide:) forEvent:buttonEvent_TouchUpInside];
    [button setTarget:self action:@selector(touchDown:) forEvent:buttonEvent_TouchDown];
    button.position = ccp(windowSize.width/2,windowSize.height/2);
    [self addChild:button];
}

- (void)touchUpInSide:(id)sender
{
    CCLOG(@"%@: %@", NSStringFromSelector(_cmd), self);
}

-(void)touchDown:(id)sender
{
    CCLOG(@"%@: %@", NSStringFromSelector(_cmd), self);
}


@end
