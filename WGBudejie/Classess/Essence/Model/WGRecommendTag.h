//
//  WGRecommendTag.h
//  WGBudejie
//
//  Created by admin on 16/11/5.
//  Copyright © 2016年 taolei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WGRecommendTag : NSObject
/** 名字 */
@property (nonatomic, copy) NSString *theme_name;
/** 图片 */
@property (nonatomic, copy) NSString *image_list;
/** 订阅数 */
@property (nonatomic, assign) NSUInteger sub_number;
@end
