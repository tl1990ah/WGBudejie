//
//  WGTopicContentFrame.h
//  WGBudejie
//
//  Created by taolei on 16/10/27.
//  Copyright © 2016年 taolei. All rights reserved.
//

#import <Foundation/Foundation.h>
@class WGTopic;

@interface WGTopicContentFrame : NSObject

/** 帖子模型 */
@property (nonatomic, strong) WGTopic *topic;

/** 视频或音频或图片的frame */
@property (nonatomic, assign) CGRect mediaFrame;

/** 自己的frame */
@property (nonatomic, assign) CGRect frame;

@end
