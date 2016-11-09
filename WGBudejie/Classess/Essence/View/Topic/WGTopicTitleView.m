//
//  WGTopicTitleView.m
//  WGBudejie
//
//  Created by taolei on 16/10/26.
//  Copyright © 2016年 taolei. All rights reserved.
//

#import "WGTopicTitleView.h"
#import "WGTitleFrame.h"
#import "WGTopic.h"

@interface WGTopicTitleView()

/** 头像 */
@property (nonatomic, weak) UIImageView *headIcon;
/** 用户名 */
@property (nonatomic, weak) UILabel *nameLabel;
/** 时间 */
@property (nonatomic, weak) UILabel *timeLabel;
/** 更多按钮 */
@property (nonatomic, weak) UIButton *moreBtn;

/** 文字内容 */
@property (nonatomic, weak) UILabel *textLabel;

@end

@implementation WGTopicTitleView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.userInteractionEnabled = YES;
        self.backgroundColor = [UIColor whiteColor];
        // 添加所有的子控件
        [self addAllSubView];
    }
    return self;
}

- (void)addAllSubView
{
    // 头像
    UIImageView *headIcon = [[UIImageView alloc] init];
    [self addSubview:headIcon];
    self.headIcon = headIcon;
    
    // 名称
    UILabel *nameLabel = [[UILabel alloc] init];
    nameLabel.font = [UIFont systemFontOfSize:15];
    nameLabel.textColor = [UIColor lightGrayColor];
    [self addSubview:nameLabel];
    self.nameLabel = nameLabel;

    // 时间
    UILabel *timeLabel = [[UILabel alloc] init];
    timeLabel.font = [UIFont systemFontOfSize:12];
    timeLabel.textColor = [UIColor lightGrayColor];
    [self addSubview:timeLabel];
    self.timeLabel = timeLabel;
    
    // 更多按钮
    UIButton *moreBtn = [[UIButton alloc] init];
    [moreBtn setImage:[UIImage imageNamed:@"cellmorebtnnormal"] forState:UIControlStateNormal];
    [moreBtn setImage:[UIImage imageNamed:@"cellmorebtnclick"] forState:UIControlStateHighlighted];
    [moreBtn addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:moreBtn];
    self.moreBtn = moreBtn;
    
    // 文字内容
    UILabel *textLabel = [[UILabel alloc] init];
    textLabel.numberOfLines = 0;
    textLabel.textColor = [UIColor blackColor];
    textLabel.font = [UIFont systemFontOfSize:18];
    [self addSubview:textLabel];
    self.textLabel = textLabel;

}

- (void)setTitleFrame:(WGTitleFrame *)titleFrame
{
    _titleFrame = titleFrame;
    WGTopic *topic = titleFrame.topic;
    
    self.frame = titleFrame.frame;
    
    self.headIcon.frame = titleFrame.headIconFrame;
    self.headIcon.layer.cornerRadius = titleFrame.headIconFrame.size.width * 0.5;
    self.headIcon.layer.masksToBounds = YES;
    [self.headIcon sd_setImageWithURL:[NSURL URLWithString:topic.profile_image] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
    
    self.nameLabel.frame = titleFrame.nameFrame;
    self.nameLabel.text = topic.name;
    
    self.timeLabel.frame = titleFrame.timeFrame;
    self.timeLabel.text = topic.created_at;
    
    self.moreBtn.frame = titleFrame.moreBtnFrame;
    
    self.textLabel.frame = titleFrame.textFrame;
    self.textLabel.text = topic.text;

}

- (void)click
{
   WGLogFunc
}

@end
