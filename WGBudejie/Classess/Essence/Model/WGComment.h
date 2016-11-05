//
//  WGComment.h
//  WGBudejie
//
//  Created by taolei on 16/11/3.
//  Copyright © 2016年 taolei. All rights reserved.
//

#import <Foundation/Foundation.h>
@class WGUser;

@interface WGComment : NSObject
/** 用户 */
@property (nonatomic, strong) WGUser *user;
/** id */
@property (nonatomic, copy) NSString *ID;
/** 文字内容 */
@property (nonatomic, copy) NSString *content;
/** 点赞数 */
@property (nonatomic, assign) NSUInteger likeCount;
/** 语音文件的时长 */
@property (nonatomic, copy) NSString *voicetime;
/** 语音文件的路径 */
@property (nonatomic, copy) NSString *voiceuri;
@end
