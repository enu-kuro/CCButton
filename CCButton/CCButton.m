//
//  CCButton.m
//  CocosTest
//
//  Created by Kurose Nobuhito on 13/03/09.
//  Copyright Kurose Nobuhito 2013. All rights reserved.
//

#import "CCButton.h"

@interface TargetAndAction : NSObject {
}
@property(assign,nonatomic) id  target;
@property(assign,nonatomic) SEL action;
@end
@implementation TargetAndAction
@end

@implementation CCButton{
    
    CCSprite *_normalSprite;
    CCSprite *_selectedSprite;
    
}

+ (id)buttonWithNormalSprite: (CCSprite*)normalSprite selectedSprite:(CCSprite*)selectedSprite target:(id)target action:(SEL)action forEvent:(int)event;
{
    return [[[self alloc] buttonWithNormalSprite:normalSprite selectedSprite:selectedSprite target:target action:action forEvent: event] autorelease];
    
}
- (id)buttonWithNormalSprite: (CCSprite*)normalSprite selectedSprite:(CCSprite*)selectedSprite target:(id)target action:(SEL)action forEvent:(int)event;
{
    if( (self=[super init]) ) {
        
        targetAndActionDic = [[NSMutableDictionary alloc] init];
        
        self.anchorPoint = ccp(0.5f, 0.5f);
        self.contentSize=normalSprite.contentSize;
        
        if ([normalSprite isEqual:selectedSprite]) {
            CCTexture2D *tx = [normalSprite texture];
            selectedSprite = [CCSprite spriteWithTexture:tx];
        }
        
        _normalSprite = normalSprite;
        _selectedSprite = selectedSprite;
        
        _normalSprite.position=ccp(_normalSprite.contentSize.width/2,_normalSprite.contentSize.height/2);
        _selectedSprite.position=ccp(_selectedSprite.contentSize.width/2,_selectedSprite.contentSize.height/2);
        
        selectedSprite.visible=NO;
        
        [self addChild:normalSprite];
        [self addChild:selectedSprite];
        [self setTarget:target action:action forEvent:event];
    }
    return self;
}

- (void)sendAction:(int)event
{
    NSString* key = [NSString stringWithFormat:@"%d", event];
    TargetAndAction* ta = [targetAndActionDic objectForKey:key];
    if (ta) {
        [ta.target performSelector:ta.action withObject:self];
    }
}

- (BOOL)ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event
{
    CGPoint location = [touch locationInView:[touch view]];
    location = [[CCDirector sharedDirector] convertToGL:location];
    
    if(CGRectContainsPoint([self boundingBox], location)){
        [self sendAction:buttonEvent_TouchDown];
        _normalSprite.visible=NO;
        _selectedSprite.visible=YES;
    }
    
    return YES;
}

- (void)ccTouchEnded:(UITouch *)touch withEvent:(UIEvent *)event
{
    CGPoint location = [touch locationInView:[touch view]];
    location = [[CCDirector sharedDirector] convertToGL:location];
    
    if(CGRectContainsPoint([self boundingBox], location)){
        [self sendAction:buttonEvent_TouchUpInside];
    }
    [self makeNormalSpriteVisible];
}

- (void)ccTouchCancelled:(UITouch *)touch withEvent:(UIEvent *)event
{
    [self makeNormalSpriteVisible];
}

- (void)setTarget:(id)target action:(SEL)action forEvent:(int)event
{
    TargetAndAction* ta = [[[TargetAndAction alloc] init] autorelease];
    ta.target = target;
    ta.action = action;
    
    NSString* key = [NSString stringWithFormat:@"%d", event];
    [targetAndActionDic setObject:ta forKey:key];
}

- (void)makeNormalSpriteVisible
{
    _selectedSprite.visible=NO;
    _normalSprite.visible=YES;
}

- (void)onEnter
{
	[[CCDirector sharedDirector].touchDispatcher addTargetedDelegate:self priority:0 swallowsTouches:YES];
	[super onEnter];
}

- (void)onExit
{
    [[[CCDirector sharedDirector] touchDispatcher] removeDelegate:self];
    [super onExit];
}

- (void)dealloc
{
    [targetAndActionDic release];
    [super dealloc];
}

@end
