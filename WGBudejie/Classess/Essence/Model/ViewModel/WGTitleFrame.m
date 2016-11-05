//
//  WGTitleFrame.m
//  WGBudejie
//
//  Created by taolei on 16/10/26.
//  Copyright © 2016年 taolei. All rights reserved.
//

#import "WGTitleFrame.h"
#import "WGTopic.h"

@implementation WGTitleFrame

- (void)setTopic:(WGTopic *)topic
{
    _topic = topic;
    
    // 头像
    CGFloat iconX = 15;
    CGFloat iconY = 15;
    CGFloat iconW = 35;
    CGFloat iconH = 35;
    self.headIconFrame = CGRectMake(iconX, iconY, iconW, iconH);
    
    // 昵称
    CGFloat nameX = CGRectGetMaxX(self.headIconFrame) + 10;
    CGFloat nameY = iconY;
    CGSize nameMaxSize = CGSizeMake(200, 40);
    CGSize nameSize = [self sizeWithText:topic.name withFont:[UIFont systemFontOfSize:15] maxSize:nameMaxSize];
    self.nameFrame = (CGRect){{nameX, nameY}, nameSize};
    
    // 时间
    CGFloat timeX = nameX;
    CGFloat timeY = CGRectGetMaxY(self.nameFrame) + 5;
    CGSize timeMaxSize = CGSizeMake(250, 20);
    CGSize timeSize = [self sizeWithText:topic.created_at withFont:[UIFont systemFontOfSize:12] maxSize:timeMaxSize];
    self.timeFrame = (CGRect){{timeX, timeY}, timeSize};
    
    // 按钮
    CGFloat buttonX = WIDTH - 24 - 20;
    CGFloat buttonY = nameY + nameSize.height * 0.5;
    CGFloat buttonW = 24;
    CGFloat buttonH = 20;
    self.moreBtnFrame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
    
    // 正文
    CGFloat textX = 15;
    CGFloat textY = CGRectGetMaxY(self.headIconFrame) + 10;
    CGSize textMaxSize = CGSizeMake(WIDTH - 30, 200);
    CGSize textSize = [self sizeWithText:topic.text withFont:[UIFont systemFontOfSize:18] maxSize:textMaxSize];
    self.textFrame = (CGRect){{textX, textY}, textSize};
    
    //  自己的frame
    CGFloat x = 0;
    CGFloat y = 0;
    CGFloat w = WIDTH;
    CGFloat h = CGRectGetMaxY(self.textFrame) + 5;
    self.frame = CGRectMake(x, y, w, h);
}

- (CGSize)sizeWithText:(NSString *)text withFont:(UIFont *)font maxSize:(CGSize)maxSize
{
    NSDictionary *dic = @{NSFontAttributeName:font};
    CGSize size = [text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin
                                  attributes:dic context:nil].size ;
    return size;
}

@end
