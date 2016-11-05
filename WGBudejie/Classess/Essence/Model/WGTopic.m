//
//  WGTopic.m
//  WGBudejie
//
//  Created by taolei on 16/10/25.
//  Copyright © 2016年 taolei. All rights reserved.
//

#import "WGTopic.h"
#import "NSDate+WG.h"
#import "MJExtension.h"

@implementation WGTopic

// initialize和load的区别在于：load是只要类所在文件被引用就会被调用，而initialize是在类或者其子类的第一个方法被调用前调用。所以如果类没有被引用进项目，就不会有
// load调用；但即使类文件被引用进来，但是没有使用，那么initialize也不会被调用。
+ (void)load
{
    // 替换属性名
    [WGTopic mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
        return @{@"ID" : @"id",
                 @"topComment" : @"top_cmt[0]",
                 @"large_image" : @"image1",
                 @"small_image" : @"image0",
                 @"middle_image" : @"image2"
                 };
    }];
}

- (NSString *)created_at
{
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    NSDate *createDate = [fmt dateFromString:_created_at];
    if(createDate.isThisYear){ // 今年
        if(createDate.isToday){ // 今天
            NSDateComponents *cmps = [createDate deltaWithNow];
            if(cmps.hour >= 1){
                return [NSString stringWithFormat:@"%ld小时前", cmps.hour];
            }else if (cmps.minute >= 1){
                return [NSString stringWithFormat:@"%ld分钟前", cmps.minute];
            }else{
                return @"刚刚";
            }
        }else if (createDate.isYesterday){ // 昨天
            fmt.dateFormat = @"昨天 HH:mm";
            return [fmt stringFromDate:createDate];
        }else{  //  至少前天
            fmt.dateFormat = @"MM-dd HH:mm";
            return [fmt stringFromDate:createDate];
        }
    }else{
        fmt.dateFormat = @"yyyy-MM-dd";
        return [fmt stringFromDate:createDate];
    }
}

@end
