//
//  WGTopicCell.m
//  WGBudejie
//
//  Created by taolei on 16/10/25.
//  Copyright © 2016年 taolei. All rights reserved.
//

#import "WGTopicCell.h"
#import "WGTopicFrame.h"
#import "WGTopicTitleView.h"
#import "WGToolbar.h"
#import "WGTopicVideoView.h"
#import "WGTopicVoiceView.h"
#import "WGTopicPictureView.h"
#import "WGTopic.h"
#import "WGTopicContentFrame.h"
#import "WGTopicCommentView.h"
#import "WGHottestCommentFrame.h"

@interface WGTopicCell()
/** 文字和标题 */
@property (nonatomic, weak) WGTopicTitleView *titleView;
/** 工具条 */
@property (nonatomic, weak) WGToolbar *toolbar;
//@property (nonatomic, weak) WGTopicContentView *topicContentView;
/** 视频 */
@property (nonatomic, weak) WGTopicVideoView *videoView;
/** 音频 */
@property (nonatomic, weak) WGTopicVoiceView *voiceView;
/** 图片 */
@property (nonatomic, weak) WGTopicPictureView *pictureView;

@property (nonatomic, weak) WGTopicCommentView *commentView;
@end

@implementation WGTopicCell

+ (instancetype)cellWithTable:(UITableView *)tableView
{
    static NSString *Id = @"topic";
    WGTopicCell *cell = [tableView dequeueReusableCellWithIdentifier:Id];
    if(!cell){
        cell = [[WGTopicCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Id];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.contentView.userInteractionEnabled = YES;
    }
    return cell;
}

- (WGTopicVideoView *)videoView
{
    if(!_videoView){
        WGTopicVideoView *videoView = [[WGTopicVideoView alloc] init];
        [self.contentView addSubview:videoView];
        _videoView = videoView;
    }
    return _videoView;
}

- (WGTopicVoiceView *)voiceView
{
    if(!_voiceView){
        WGTopicVoiceView *voiceView = [[WGTopicVoiceView alloc] init];
        [self.contentView addSubview:voiceView];
        _voiceView = voiceView;
    }
    return _voiceView;
}

- (WGTopicPictureView *)pictureView
{
    if(!_pictureView){
        WGTopicPictureView *pictureView = [[WGTopicPictureView alloc] init];
        [self.contentView addSubview:pictureView];
        _pictureView = pictureView;
    }
    return _pictureView;
}

- (WGTopicCommentView *)commentView
{
    if(!_commentView){
        WGTopicCommentView *commentView = [[WGTopicCommentView alloc] init];
        [self.contentView addSubview:commentView];
        _commentView = commentView;
    }
    return _commentView;

}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self){ // 初始化控件
        // 1.帖子标题控件
        WGTopicTitleView *titleView = [[WGTopicTitleView alloc] init];
        [self.contentView addSubview:titleView];
        self.titleView = titleView;
        
        // 2.添加工具条
        WGToolbar *toolbar = [[WGToolbar alloc] init];
        [self.contentView addSubview:toolbar];
        self.toolbar = toolbar;
        
        // 3.cell的设置
        self.backgroundColor = [UIColor clearColor];

    }
    return self;
}

- (void)setTopicFrame:(WGTopicFrame *)topicFrame
{
    _topicFrame = topicFrame;
    WGTopic *topic = topicFrame.topic;
    // 1. 帖子标题内容的frame数据
    self.titleView.titleFrame = topicFrame.titleFrame;
    
    // 2. 中间的内容
    if(topic.type == WGPictureTopic){
        self.pictureView.hidden = NO;
        self.videoView.hidden = YES;
        self.voiceView.hidden = YES;
        self.pictureView.contentFrame = topicFrame.topicContentFrame;
        self.pictureView.frame = topicFrame.topicContentFrame.frame;
        if(topic.topComment){
            self.commentView.commentFrame = topicFrame.commentFrame;
            self.commentView.frame = topicFrame.commentFrame.frame;
            self.commentView.hidden = NO;
        }else{
            self.commentView.hidden = YES;
        }
    }else if (topic.type == WGVideoTopic){
        
        self.pictureView.hidden = YES;
        self.videoView.hidden = NO;
        self.voiceView.hidden = YES;
        self.videoView.contentFrame = topicFrame.topicContentFrame;
        self.videoView.frame = topicFrame.topicContentFrame.frame;
        if(topic.topComment){
            self.commentView.commentFrame = topicFrame.commentFrame;
            self.commentView.frame = topicFrame.commentFrame.frame;
            self.commentView.hidden = NO;
        }else{
            self.commentView.hidden = YES;
        }
        
    }else if (topic.type == WGVoiceTopic){
        
        self.pictureView.hidden = YES;
        self.videoView.hidden = YES;
        self.voiceView.hidden = NO;
        self.voiceView.contentFrame = topicFrame.topicContentFrame;
        self.voiceView.frame = topicFrame.topicContentFrame.frame;
        if(topic.topComment){
            self.commentView.commentFrame = topicFrame.commentFrame;
            self.commentView.frame = topicFrame.commentFrame.frame;
            self.commentView.hidden = NO;
        }else{
            self.commentView.hidden = YES;
        }

       
    }else if(topic.type == WGWordTopic){
        self.pictureView.hidden = YES;
        self.videoView.hidden = YES;
        self.voiceView.hidden = YES;
        if(topic.topComment){
            self.commentView.commentFrame = topicFrame.commentFrame;
            self.commentView.frame = topicFrame.commentFrame.frame;
            self.commentView.hidden = NO;
        }else{
            self.commentView.hidden = YES;
        }

    }
    
    // 3. 底部工具条的frame数据
    self.toolbar.frame = topicFrame.toolbarFrame;
    self.toolbar.topic = topic;

}

@end
