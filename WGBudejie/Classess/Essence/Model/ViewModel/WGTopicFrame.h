//
//  WGTopicFrame.h
//  WGBudejie
//
//  Created by taolei on 16/10/26.
//  Copyright © 2016年 taolei. All rights reserved.
//

#import <Foundation/Foundation.h>

@class WGTopic, WGTitleFrame, WGTopicContentFrame, WGCommentFrame;
@interface WGTopicFrame : NSObject

/** 帖子数据 */
@property (nonatomic, strong) WGTopic *topic;

/** 标题的frame */
@property (nonatomic, strong) WGTitleFrame *titleFrame;

/** 文字的frame */
@property (nonatomic, strong) WGTopicContentFrame *topicContentFrame;

/** 最热评论的frame */
@property (nonatomic, strong) WGCommentFrame *commentFrame;

/** cell的高度 */
@property (nonatomic, assign) CGFloat cellHeight;

/** 底部工具条的frame */
@property (nonatomic, assign) CGRect toolbarFrame;

@end
