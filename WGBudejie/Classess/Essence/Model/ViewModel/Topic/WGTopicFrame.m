//
//  WGTopicFrame.m
//  WGBudejie
//
//  Created by taolei on 16/10/26.
//  Copyright © 2016年 taolei. All rights reserved.
//

#import "WGTopicFrame.h"
#import "WGTopic.h"
#import "WGTitleFrame.h"
#import "WGTopicContentFrame.h"
#import "WGHottestCommentFrame.h"

@implementation WGTopicFrame

- (void)setTopic:(WGTopic *)topic
{
    _topic = topic;
    
    // 1. 计算标题的frame
    WGTitleFrame *titleFrame = [[WGTitleFrame alloc] init];
    titleFrame.topic = topic;
    self.titleFrame = titleFrame;
    
    // 2. 工具条和最热评论的frame
    CGFloat toolbarY = 0;
    if(topic.type == WGWordTopic){
        WGHottestCommentFrame *commentFrame = [[WGHottestCommentFrame alloc] init];
        commentFrame.topic = topic;
        CGRect commentF = commentFrame.frame;
        commentF.origin.y = CGRectGetMaxY(self.titleFrame.frame);
        commentFrame.frame = commentF;
        self.commentFrame = commentFrame;
        if(topic.topComment){
            toolbarY = CGRectGetMaxY(self.commentFrame.frame);
        }else{
            toolbarY = CGRectGetMaxY(self.titleFrame.frame);
        }
        
    }else{
        // 2. 文字的frame
        WGTopicContentFrame *contentFrame = [[WGTopicContentFrame alloc] init];
        contentFrame.topic = topic;
        CGRect f = contentFrame.frame;
        f.origin.y = CGRectGetMaxY(titleFrame.frame);
        contentFrame.frame = f;
        self.topicContentFrame = contentFrame;

        WGHottestCommentFrame *commentFrame = [[WGHottestCommentFrame alloc] init];
        commentFrame.topic = topic;
        CGRect commentF = commentFrame.frame;
        commentF.origin.y = CGRectGetMaxY(self.topicContentFrame.frame);
        commentFrame.frame = commentF;
        self.commentFrame = commentFrame;
        if(topic.topComment){
            toolbarY = CGRectGetMaxY(self.commentFrame.frame);
        }else{
            toolbarY = CGRectGetMaxY(self.topicContentFrame.frame);
        }
        
    }
    CGFloat toolbarX = 0;
    CGFloat toolbarW = WIDTH;
    CGFloat toolbarH = 35;
    self.toolbarFrame = CGRectMake(toolbarX, toolbarY, toolbarW, toolbarH);
    
    // 4. cell的高度
    self.cellHeight = CGRectGetMaxY(self.toolbarFrame) + 10;
}

@end
