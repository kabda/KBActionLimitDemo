//
//  UIControl+kb_limit.h
//  KBActionLimitDemo
//
//  Created by 樊远东 on 1/27/16.
//  Copyright © 2016 樊远东. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIControl (kb_limit)

/**
 *  @brief 全局设置延迟响应时间;
 *
 *  @param limit 延迟时间(单位:s), 默认1s, 传入非整数秒时, 将向上取整;
 */
+ (void)setGlobalLimitTime:(NSTimeInterval)limitTime;

/**
 *  @brief 独立设置延迟响应时间, 优先级高于全局延迟响应时间;
 *
 *  @param limit 延迟时间(单位:s), 默认使用全局设置, 传入非整数秒时, 将向上取整;
 */
- (void)setLimitTime:(NSTimeInterval)limitTime;

@end
