//
//  NSDate+WG.m
//  WGBudejie
//
//  Created by taolei on 16/10/29.
//  Copyright © 2016年 taolei. All rights reserved.
//

#import "NSDate+WG.h"

@implementation NSDate (WG)

/**
 *   是否为今天
 */
- (BOOL)isToday
{
    // 获取日历
    NSCalendar *calendar = [NSCalendar currentCalendar];
    int unit = NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear;
    
    // 获取当前时间的年月日
    NSDateComponents *nowCmps = [calendar components:unit fromDate:[NSDate date]];
    
    // 获取self的年月日
    NSDateComponents *selfCmps = [calendar components:unit fromDate:self];
    
    return (nowCmps.year == selfCmps.year) && (nowCmps.month == selfCmps.month) && (nowCmps.day == selfCmps.day);
}

- (BOOL)isYesterday
{
    // 当前的年月日
    NSDate *nowDate = [[NSDate date] dateWithYMD];
    
    // 自己的年月日
    NSDate *selfDate = [self dateWithYMD];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
   
    NSDateComponents *cmps = [calendar components:NSCalendarUnitDay fromDate:selfDate toDate:nowDate options:0];
    return cmps.day == 1;
}

- (BOOL)isThisYear
{
    // 获取日历
    NSCalendar *calendar = [NSCalendar currentCalendar];
    int unit = NSCalendarUnitYear;
    
    // 获取当前时间的年月日
    NSDateComponents *nowCmps = [calendar components:unit fromDate:[NSDate date]];
    
    // 获取self的年月日
    NSDateComponents *selfCmps = [calendar components:unit fromDate:self];
    
    return (nowCmps.year == selfCmps.year);
}

- (NSDate *)dateWithYMD
{
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyy-MM-dd";
    NSString *dateStr = [fmt stringFromDate:self];
    return [fmt dateFromString:dateStr];
}

- (NSDateComponents *)deltaWithNow
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    int unit = NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    return [calendar components:unit fromDate:self toDate:[NSDate date] options:0];
}

@end
