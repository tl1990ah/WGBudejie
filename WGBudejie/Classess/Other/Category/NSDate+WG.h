//
//  NSDate+WG.h
//  WGBudejie
//
//  Created by taolei on 16/10/29.
//  Copyright © 2016年 taolei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (WG)

/**
 *   是否为今天
 */
- (BOOL)isToday;

/**
 *   是否为今天
 */
- (BOOL)isYesterday;

/**
 *  是否为今年
 */
- (BOOL)isThisYear;

/**
 *  返回一个只有年月日的时间
 */
- (NSDate *)dateWithYMD;

/**
 *  获得与当前时间的差距  时，分，秒
 */
- (NSDateComponents *)deltaWithNow;

@end
