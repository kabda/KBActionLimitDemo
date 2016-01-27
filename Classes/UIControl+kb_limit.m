//
//  UIControl+kb_limit.m
//  KBActionLimitDemo
//
//  Created by 樊远东 on 1/27/16.
//  Copyright © 2016 樊远东. All rights reserved.
//

#import "UIControl+kb_limit.h"
#import <objc/runtime.h>

#ifndef __OPTIMIZE__
#define KBLog(...) NSLog(__VA_ARGS__)
#else
#define KBLog(...) {}
#endif

static NSTimeInterval const kDefaultLimitTime = 1.0;

@interface UIControlSettings : NSObject
@property (nonatomic, assign) NSTimeInterval globalLimitTime;
@end

@implementation UIControlSettings

+ (instancetype)defaultSettings {
    static dispatch_once_t pred = 0;
    static UIControlSettings *_sharedObject = nil;
    dispatch_once(&pred, ^{
        _sharedObject = [[UIControlSettings alloc] init];
    });
    return _sharedObject;
}

- (instancetype)init {
    if (self = [super init]) {
        _globalLimitTime = kDefaultLimitTime;
    }
    return self;
}

- (void)setGlobalLimitTime:(NSTimeInterval)globalLimitTime {
    _globalLimitTime = ceil(globalLimitTime);
}

@end



/**
 *  @brief UIControl+limit
 */
static const void *kLimitTimeKey = &kLimitTimeKey;
static const void *kLastTimeKey = &kLastTimeKey;

@implementation UIControl (kb_limit)

+ (void)load {
    [super load];
    
    Method fromMethod = class_getInstanceMethod([self class], @selector(touchesBegan:withEvent:));
    Method toMethod = class_getInstanceMethod([self class], @selector(kb_touchesBegan:withEvent:));
    if (!class_addMethod([self class], @selector(touchesBegan:withEvent:), method_getImplementation(toMethod), method_getTypeEncoding(toMethod))) {
        method_exchangeImplementations(fromMethod, toMethod);
        KBLog(@"method exchanged");
    }
}

- (void)kb_touchesBegan:(NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event {
    if (![self shouldRespondEvent]) {
        KBLog(@"should not respond");
        return;
    }
    KBLog(@"responded");
    [self setLastTouchTime:[[NSDate date] timeIntervalSince1970]];
    [self kb_touchesBegan:touches withEvent:event];
}

#pragma mark - Private Methods
- (BOOL)shouldRespondEvent {
    NSTimeInterval last = [self lastTouchTime];
    if (last == 0.0) {
        return YES;
    }
    NSTimeInterval now = ceil([[NSDate date] timeIntervalSince1970]);
    NSTimeInterval limit = [self limitTime];
    NSTimeInterval delay = (limit == 0.0) ? [UIControlSettings defaultSettings].globalLimitTime : limit;
    return (ABS(now - last) > delay);
}

#pragma mark - Getter/Setter
- (void)setLimitTime:(NSTimeInterval)limitTime {
    objc_setAssociatedObject(self, kLimitTimeKey, @(ceil(limitTime)), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSTimeInterval)limitTime {
    NSObject *obj = objc_getAssociatedObject(self, kLimitTimeKey);
    if ([obj isKindOfClass:[NSNumber class]]) {
        return ((NSNumber *)obj).doubleValue;
    }
    return 0.0;
}

- (void)setLastTouchTime:(NSTimeInterval)lastTouchTime {
    objc_setAssociatedObject(self, kLastTimeKey, @(ceil(lastTouchTime)), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSTimeInterval)lastTouchTime {
    NSObject *obj = objc_getAssociatedObject(self, kLastTimeKey);
    if ([obj isKindOfClass:[NSNumber class]]) {
        return ((NSNumber *)obj).doubleValue;
    }
    return 0.0;
}


#pragma mark - Class Method
+ (void)setGlobalLimitTime:(NSTimeInterval)limitTime {
    [UIControlSettings defaultSettings].globalLimitTime = limitTime;
}

@end
