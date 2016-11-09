//
//  WGTopicContentFrame.m
//  WGBudejie
//
//  Created by taolei on 16/10/27.
//  Copyright © 2016年 taolei. All rights reserved.
//

#import "WGTopicContentFrame.h"
#import "WGTopic.h"

@implementation WGTopicContentFrame

- (void)setTopic:(WGTopic *)topic
{
    _topic = topic;
    
    // 音频\视频\图片
    CGFloat mediaX = 15;
    CGFloat mediaY = 0;
    CGFloat mediaW = WIDTH - 30;
    
    //double scale = mediaW / topic.width;
    //WGLog(@"scale----%f", scale);
    CGFloat mediaH = topic.height;
    WGLog(@"WGTopicContentFrame---%f", mediaH);
    if(mediaH >= HEIGHT){
        mediaH = 200;
        topic.bigPicture = YES;
    }else{
        topic.bigPicture = NO;
    }
    self.mediaFrame = CGRectMake(mediaX, mediaY, mediaW, mediaH);
    //WGLog(@"mediaFrame----%@", NSStringFromCGRect(self.mediaFrame));
    
    //  自己的frame
    CGFloat x = 0;
    CGFloat y = 0;
    CGFloat w = WIDTH;
    CGFloat h = 0;
    h = CGRectGetMaxY(self.mediaFrame) + 10;
    
    self.frame = CGRectMake(x, y, w, h);
   // WGLog(@"frame---%@", NSStringFromCGRect(self.frame));
}

- (CGSize)sizeWithText:(NSString *)text withFont:(UIFont *)font maxSize:(CGSize)maxSize
{
    NSDictionary *dic = @{NSFontAttributeName:font};
    CGSize size = [text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin
                                  attributes:dic context:nil].size ;
    return size;
}

@end
