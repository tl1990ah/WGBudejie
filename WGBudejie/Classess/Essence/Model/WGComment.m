//
//  WGComment.m
//  WGBudejie
//
//  Created by taolei on 16/11/3.
//  Copyright © 2016年 taolei. All rights reserved.
//

#import "WGComment.h"
#import "MJExtension.h"

@implementation WGComment

+ (void)load
{
    [WGComment mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
        return @{@"ID" : @"id"};
    }];
}

@end
