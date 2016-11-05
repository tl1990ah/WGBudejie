//
//  WGTopicVoiceView.m
//  WGBudejie
//
//  Created by taolei on 16/10/31.
//  Copyright © 2016年 taolei. All rights reserved.
//

#import "WGTopicVoiceView.h"
#import "WGTopicContentFrame.h"
#import "WGTopic.h"
#import "WGSeeBigPictureViewController.h"

@interface WGTopicVoiceView()

/** 播放次数 */
@property (nonatomic, weak) UILabel *playCountLabel;
/** 播放时长 */
@property (nonatomic, weak) UILabel *playTimeLabel;
/** 视频/音频/图片的截图 */
@property (nonatomic, weak) UIImageView *mediaImageView;

@property (nonatomic, weak) UIButton *playBtn;
@end

@implementation WGTopicVoiceView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self){
        self.backgroundColor = [UIColor whiteColor];
        
        [self addSubView];
    }
    return self;
}

- (void)addSubView
{
    // 视频/音频/图片
    UIImageView *mediaImageView = [[UIImageView alloc] init];
    mediaImageView.userInteractionEnabled = YES;
    [mediaImageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageClick)]];
    [self addSubview:mediaImageView];
    self.mediaImageView = mediaImageView;

    UIButton *playBtn = [[UIButton alloc] init];
    [playBtn setBackgroundImage:[UIImage imageNamed:@"playButtonPlay"] forState:UIControlStateNormal];
    [self.mediaImageView addSubview:playBtn];
    self.playBtn = playBtn;
    
    UILabel *playCountLabel = [[UILabel alloc] init];
    playCountLabel.textColor = [UIColor whiteColor];
    playCountLabel.backgroundColor = [UIColor blackColor];
    playCountLabel.font = [UIFont systemFontOfSize:18];
    playCountLabel.textAlignment = NSTextAlignmentLeft;
    [self.mediaImageView addSubview:playCountLabel];
    self.playCountLabel = playCountLabel;
    
    UILabel *playTimeLabel = [[UILabel alloc] init];
    playTimeLabel.backgroundColor = [UIColor grayColor];
    playTimeLabel.textColor = [UIColor whiteColor];
    playTimeLabel.font = [UIFont systemFontOfSize:18];
    playTimeLabel.textAlignment = NSTextAlignmentLeft;
    [self.mediaImageView addSubview:playTimeLabel];
    self.playTimeLabel = playTimeLabel;

}

- (void)imageClick
{
    WGSeeBigPictureViewController *seeBigVC = [[WGSeeBigPictureViewController alloc] init];
    seeBigVC.topic = self.contentFrame.topic;
    [self.window.rootViewController presentViewController:seeBigVC animated:YES completion:nil];
}

- (void)setContentFrame:(WGTopicContentFrame *)contentFrame
{
    _contentFrame = contentFrame;
    WGTopic *topic = contentFrame.topic;
    
    [self.mediaImageView sd_setImageWithURL:[NSURL URLWithString:topic.large_image] placeholderImage:nil];
    self.mediaImageView.frame = contentFrame.mediaFrame;
    
    self.playBtn.frame = CGRectMake((self.mediaImageView.width - 70) * 0.5, (self.mediaImageView.height - 70) * 0.5, 70, 70);
    
    // %02zd : 显示这个数字需要占据2位空间，不足的空间用0替补
    NSString *voiceTime = [NSString stringWithFormat:@"%02zd:%02zd", topic.voicetime / 60, topic.voicetime % 60];
    self.playTimeLabel.text = voiceTime;
    CGSize playTimeSize = [self sizeWithText:voiceTime withFont:[UIFont systemFontOfSize:18] maxSize:CGSizeMake(200, 20)];
    self.playTimeLabel.frame = (CGRect){{WIDTH - 30 - playTimeSize.width,self.mediaImageView.height - playTimeSize.height}, playTimeSize};
    
    NSString *playCountStr = [NSString stringWithFormat:@"%@播放", topic.playcount];
    CGSize playCountSize = [self sizeWithText:playCountStr withFont:[UIFont systemFontOfSize:18] maxSize:CGSizeMake(WIDTH, 20)];
    self.playCountLabel.text = playCountStr;
    self.playCountLabel.frame = (CGRect){{WIDTH - 30 - playCountSize.width, 0}, playCountSize};
}

- (CGSize)sizeWithText:(NSString *)text withFont:(UIFont *)font maxSize:(CGSize)maxSize
{
    NSDictionary *dic = @{NSFontAttributeName:font};
    CGSize size = [text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin
                                  attributes:dic context:nil].size ;
    return size;
}

@end
