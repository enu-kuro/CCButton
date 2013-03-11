//
//  CCButton.h
//  CocosTest
//
//  Created by Kurose Nobuhito on 13/03/09.
//  Copyright Copyright Kurose Nobuhito 2013. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

enum {
    buttonEvent_TouchDown,
    buttonEvent_TouchUpInside 
};

@interface CCButton : CCNode <CCTargetedTouchDelegate> {
    NSMutableDictionary*    targetAndActionDic;
}

+ (id)buttonWithNormalSprite: (CCSprite*)normalSprite selectedSprite:(CCSprite*)selectedSprite target:(id)target action:(SEL)action forEvent:(int)event;

- (void)setTarget:(id)target action:(SEL)action forEvent:(int)event;

@end
