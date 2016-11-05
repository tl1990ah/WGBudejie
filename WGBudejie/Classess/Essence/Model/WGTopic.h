//
//  WGTopic.h
//  WGBudejie
//
//  Created by taolei on 16/10/25.
//  Copyright © 2016年 taolei. All rights reserved.
//  帖子模型

#import <Foundation/Foundation.h>
@class WGComment;
typedef NS_ENUM (NSUInteger, WGTopicType){
    /** 视频 */
    WGVideoTopic = 41,
    /** 音频 */
    WGVoiceTopic = 31,
    /** 图片 */
    WGPictureTopic = 10,
    /** 段子 */
    WGWordTopic = 29,
    
    /** 全部 */
    WGTopicTypeAll = 1,
};

@interface WGTopic : NSObject

/** id */
@property (nonatomic, copy) NSString *ID; // id
/** 用户名 */
@property (nonatomic, copy) NSString *name;
/** 用户头像 */
@property (nonatomic, copy) NSString *profile_image;
/** 帖子通过时间 */
@property (nonatomic, copy) NSString *created_at ;
/** 正文 */
@property (nonatomic, copy) NSString *text;
/** 顶的数量 */
@property (nonatomic, assign) NSUInteger ding;
/** 踩的数量 */
@property (nonatomic, assign) NSUInteger cai;
/** 转发数量 */
@property (nonatomic, assign) NSUInteger repost;
/** 评论数量 */
@property (nonatomic, assign) NSUInteger comment;
/** 音频的长度 */
@property (nonatomic, assign) NSUInteger voicetime;
/** 视频的长度 */
@property (nonatomic, assign) NSUInteger videotime;
/** 帖子类型 */
@property (nonatomic, assign) NSUInteger type;
/** 视频或图片类型帖子的高度 */
@property (nonatomic, assign) CGFloat height;
/** 视频或图片类型帖子的宽度 */
@property (nonatomic, assign) CGFloat width;

/** 大图 */
@property (nonatomic, copy) NSString *large_image;
/** 小图 */
@property (nonatomic, copy) NSString *small_image;
/** 中图 */
@property (nonatomic, copy) NSString *middle_image;

/** 播放数量 */
@property (nonatomic, copy) NSString *playcount;

/** 最热评论 */
@property (nonatomic, strong) WGComment *topComment;

/** 是否是gif图片 */   // 1. gif图片  0. 非gif图片
@property (nonatomic, copy) NSString *is_gif;

/***** 额外增加的属性   ****/

/** 是否是大图 */
@property (nonatomic, assign, getter=isBigPicture) BOOL bigPicture;
@end
