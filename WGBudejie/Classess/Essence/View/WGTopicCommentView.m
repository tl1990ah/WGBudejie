//
//  WGTopicCommentView.m
//  WGBudejie
//
//  Created by taolei on 16/11/2.
//  Copyright © 2016年 taolei. All rights reserved.
//

#import "WGTopicCommentView.h"
#import "WGCommentFrame.h"
#import "WGUser.h"
#import "WGTopic.h"
#import "WGComment.h"

@interface WGTopicCommentView()

/** 标题 */
@property (nonatomic, weak) UILabel *titleLabel;
/** 评论内容 */
@property (nonatomic, weak) UILabel *commentLabel;
@end

@implementation WGTopicCommentView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self){
        self.backgroundColor = [UIColor whiteColor];
        
        [self addAllSubView];
    }
    return self;
}

- (void)addAllSubView
{
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.font = [UIFont systemFontOfSize:20];
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.backgroundColor = [UIColor lightGrayColor];
    [self addSubview:titleLabel];
    self.titleLabel = titleLabel;
    
    UILabel *commentLabel = [[UILabel alloc] init];
    commentLabel.numberOfLines = 0;
    commentLabel.font = [UIFont systemFontOfSize:17];
    commentLabel.textColor = [UIColor lightGrayColor];
    commentLabel.backgroundColor = [UIColor clearColor];
    [self addSubview:commentLabel];
    self.commentLabel = commentLabel;
}

- (void)setCommentFrame:(WGCommentFrame *)commentFrame
{
    _commentFrame = commentFrame;
    WGTopic *topic = commentFrame.topic;
    self.frame = commentFrame.frame;
    self.titleLabel.frame = commentFrame.titleFrame;
    self.titleLabel.text = @"最热评论";
    NSString *text = [NSString stringWithFormat:@"%@ : %@",topic.topComment.user.username, topic.topComment.content];
    self.commentLabel.frame = commentFrame.commentTextFrame;
    self.commentLabel.text = text ;
}

@end
