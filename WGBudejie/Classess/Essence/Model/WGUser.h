//
//  WGUser.h
//  WGBudejie
//
//  Created by taolei on 16/11/3.
//  Copyright © 2016年 taolei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WGUser : NSObject

/** 性别 */
@property (nonatomic, copy) NSString *sex;
/** 用户名 */
@property (nonatomic, copy) NSString *username;
/** 头像 */
@property (nonatomic, copy) NSString *profile_image;
@end
