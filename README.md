CCButton
========

It's a TouchDown-enabled button for cocos2d.

You don't have to use CCMenu.
Just add CCSprite to CCButton.

How to use it
====================
- Include CCButton.m and CCButton.h file into your project
- In the needed files include this header:

        #import "CCButton.h"

There is an example in SampleLayer.m to understand how to use CCButton.
```
    CGSize windowSize = [[CCDirector sharedDirector] winSize];
    CCSprite *normalSprite = [CCSprite spriteWithFile:@"Icon.png"];
    CCSprite *selectedSprite = [CCSprite spriteWithFile:@"Icon-72.png"];
    CCButton *button =[CCButton buttonWithNormalSprite:normalSprite selectedSprite:selectedSprite target:self action:@selector(touchUpInSide:) forEvent:buttonEvent_TouchUpInside];
    [button setTarget:self action:@selector(touchDown:) forEvent:buttonEvent_TouchDown];
    button.position = ccp(windowSize.width/2,windowSize.height/2);
    [self addChild:button];
```
When you touch the button, touchDown method is called.
When you touch up the button, touchUpInside method is called. 
