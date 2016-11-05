//
//  WGCommentFrame.m
//  WGBudejie
//
//  Created by taolei on 16/11/2.
//  Copyright © 2016年 taolei. All rights reserved.
//

#import "WGCommentFrame.h"
#import "WGTopic.h"
#import "WGComment.h"
#import "WGUser.h"

@implementation WGCommentFrame

- (void)setTopic:(WGTopic *)topic
{
    _topic = topic;
    
    CGFloat titleX = 15;
    CGFloat titleY = 0;
    CGSize maxTitleSize = CGSizeMake(120, 20);
    CGSize titleSize = [self sizeWithText:@"最热评论" withFont:[UIFont systemFontOfSize:20] maxSize:maxTitleSize];
    self.titleFrame = (CGRect){{titleX, titleY}, titleSize};
    
    CGFloat contentX = 15;
    CGFloat contentY = CGRectGetMaxY(self.titleFrame);
    CGSize maxContentSize = CGSizeMake(WIDTH - 30, 100);
    NSString *text = [NSString stringWithFormat:@"%@:%@",topic.topComment.user.username, topic.topComment.content];
    CGSize contentSize = [self sizeWithText:text withFont:[UIFont systemFontOfSize:17] maxSize:maxContentSize];
    self.commentTextFrame = (CGRect){{contentX, contentY}, contentSize};
    
    CGFloat x = 0;
    CGFloat y = 0;
    CGFloat w = WIDTH;
    CGFloat h = CGRectGetMaxY(self.commentTextFrame)+ 10;
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
