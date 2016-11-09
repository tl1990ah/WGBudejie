//
//  WGTopicPictureView.m
//  WGBudejie
//
//  Created by taolei on 16/10/31.
//  Copyright © 2016年 taolei. All rights reserved.
//

#import "WGTopicPictureView.h"
#import "WGTopicContentFrame.h"
#import "WGTopic.h"
#import "DALabeledCircularProgressView.h"
#import "WGSeeBigPictureViewController.h"

@interface WGTopicPictureView ()
/** gif图标 */
@property (nonatomic, weak) UIImageView *gifImageView;

/** 查看大图的背景图 */
@property (nonatomic, weak) UIImageView *showBigPicture;

@property (nonatomic, weak) UIButton *showBigPictureBtn;

/** 视频/音频/图片的截图 */
@property (nonatomic, weak) UIImageView *mediaImageView;

/** 占位图片 */
@property (nonatomic, weak) UIImageView *placeholderImageView;

/** 圆环进度条 */
@property (nonatomic, weak) DALabeledCircularProgressView *progressView;
@property (nonatomic, strong) UILabel *progressLabel;
@end

@implementation WGTopicPictureView

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
    UIImageView *placeholderImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"post_placeholderImage"]];
    [self addSubview:placeholderImageView];
    self.placeholderImageView = placeholderImageView;

     // 视频/音频/图片
    UIImageView *mediaImageView = [[UIImageView alloc] init];
    mediaImageView.userInteractionEnabled = YES;
    [mediaImageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageClick)]];
    [self addSubview:mediaImageView];
    self.mediaImageView = mediaImageView;
    
    DALabeledCircularProgressView *progressView = [[DALabeledCircularProgressView alloc] init];
    progressView.roundedCorners = 5;
    progressView.progressLabel.textColor = [UIColor blueColor];
    [self addSubview:progressView];
    self.progressView = progressView;
    
    self.progressLabel = [[UILabel alloc] initWithFrame:self.progressView.bounds];
    self.progressLabel.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    self.progressLabel.textAlignment = NSTextAlignmentCenter;
    [self.progressView addSubview:self.progressLabel];
    
    UIImageView *gifImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"common-gif"]];
    gifImageView.frame = CGRectMake(0, 0, 31, 31);
    [self.mediaImageView addSubview:gifImageView];
    self.gifImageView = gifImageView;

    UIImageView *showBigPicture = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"see-big-picture-background"]];
    [self.mediaImageView addSubview:showBigPicture];
    showBigPicture.userInteractionEnabled = YES;
    self.showBigPicture = showBigPicture;

    UIButton *showBigPictureBtn = [[UIButton alloc] init];
    [showBigPictureBtn setImage:[UIImage imageNamed:@"see-big-picture"] forState:UIControlStateNormal];
    [showBigPictureBtn setTitle:@"点击查看全图" forState:UIControlStateNormal];
    [showBigPictureBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [showBigPictureBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
    //[showBigPictureBtn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    [showBigPicture addSubview:showBigPictureBtn];
    self.showBigPictureBtn = showBigPictureBtn;
}

- (void)setContentFrame:(WGTopicContentFrame *)contentFrame
{
    _contentFrame = contentFrame;
    WGTopic *topic = contentFrame.topic;
    self.mediaImageView.frame = contentFrame.mediaFrame;
   
    self.placeholderImageView.frame = CGRectMake(0, 0, self.mediaImageView.width, 45);
    
    self.progressView.size = CGSizeMake(100, 100);
    self.progressView.center = CGPointMake(self.mediaImageView.width * 0.5, self.mediaImageView.height * 0.5);
    
    [self.mediaImageView sd_setImageWithURL:[NSURL URLWithString:topic.large_image] placeholderImage:nil options:SDWebImageRetryFailed progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        
        CGFloat progress = 1.0 * receivedSize / expectedSize;
        self.progressView.progress = progress;
        self.progressView.hidden = NO;
        WGLog(@"%f",progress* 100);
        self.progressLabel.text = [NSString stringWithFormat:@"%0.f%%", progress * 100];
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
        self.progressView.hidden = YES;
    }];
     
     if(topic.isBigPicture){
        self.mediaImageView.contentMode = UIViewContentModeTop;
        self.mediaImageView.contentMode = UIViewContentModeTop;
        self.mediaImageView.layer.masksToBounds = YES;
        self.showBigPicture.hidden = NO;
    }else{
        self.mediaImageView.contentMode = UIViewContentModeScaleAspectFit;
        self.showBigPicture.hidden = YES;
    }
    
    if([topic.is_gif isEqualToString:@"1"]){
        
        self.gifImageView.hidden = NO;
    }else{
        self.gifImageView.hidden = YES;
    }
    self.showBigPicture.frame = CGRectMake(0, self.mediaImageView.height - 43, self.mediaImageView.width, 43);
    self.showBigPictureBtn.frame = CGRectMake((WIDTH - 200) * 0.5, 10, 200, 20);
}

- (void)imageClick
{
    WGSeeBigPictureViewController *seeBigVC = [[WGSeeBigPictureViewController alloc] init];
    seeBigVC.topic = self.contentFrame.topic;
    [self.window.rootViewController presentViewController:seeBigVC animated:YES completion:nil];
}

@end
