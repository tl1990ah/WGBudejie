//
//  WGCommentFrame.m
//  WGBudejie
//
//  Created by taolei on 16/11/9.
//  Copyright © 2016年 taolei. All rights reserved.
//

#import "WGCommentFrame.h"
#import "WGComment.h"
#import "WGUser.h"

@implementation WGCommentFrame

- (void)setComment:(WGComment *)comment
{
    _comment = comment;
    
    // 头像
    CGFloat iconX = 15;
    CGFloat iconY = 15;
    CGFloat iconW = 30;
    CGFloat iconH = 30;
    self.headerIconFrame = CGRectMake(iconX, iconY, iconW, iconH);
    
    // 性别图标
    CGFloat sexIconX = CGRectGetMaxX(self.headerIconFrame) + 15;
    CGFloat sexIconY = 20;
    CGFloat sexIconW = 13;
    CGFloat sexIconH = 13;
    self.sexIconFrame = CGRectMake(sexIconX, sexIconY, sexIconW, sexIconH);
    
    // 用户名
    CGFloat usernameX = CGRectGetMaxX(self.sexIconFrame) + 5;
    CGFloat usernameY = 18;
    CGSize nameMaxSize = CGSizeMake(200, 20);
    CGSize nameSize = [self sizeWithText:comment.user.username withFont:[UIFont systemFontOfSize:14] maxSize:nameMaxSize];
    self.usernameFrame = (CGRect){{usernameX, usernameY}, nameSize};
    
    // 内容
    CGFloat contentX = CGRectGetMaxX(self.headerIconFrame) + 15;
    CGFloat contentY = CGRectGetMaxY(self.usernameFrame) + 10;
    CGSize contentMaxSize = CGSizeMake(280, 100);
    CGSize contentSize = [self sizeWithText:comment.content withFont:[UIFont systemFontOfSize:15] maxSize:contentMaxSize];
    self.contentFrame = (CGRect){{contentX, contentY}, contentSize};
    
    // 点赞按钮
    CGFloat likeBtnX = WIDTH - 20 - 20;
    CGFloat likeBtnY = usernameY;
    CGFloat likeBtnW = 20;
    CGFloat likeBtnH = 20;
    self.likeBtnFrame = CGRectMake(likeBtnX, likeBtnY, likeBtnW, likeBtnH);
    
    // 点赞数量
    CGFloat likeCountY = usernameY;
    CGSize likeCountMaxSize = CGSizeMake(100, 20);
    CGSize likeCountSize = [self sizeWithText:[NSString stringWithFormat:@"%zd", comment.likeCount] withFont:[UIFont systemFontOfSize:14] maxSize:likeCountMaxSize];
    
    CGFloat likeCountX = likeBtnX - 5 - likeCountSize.width;
    self.likeCountFrame = (CGRect){{likeCountX, likeCountY}, likeCountSize};
    
    // 行高
    self.rowHeight = CGRectGetMaxY(self.contentFrame) + 10;
}

- (CGSize)sizeWithText:(NSString *)text withFont:(UIFont *)font maxSize:(CGSize)maxSize
{
    NSDictionary *dic = @{NSFontAttributeName:font};
    CGSize size = [text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin
                                  attributes:dic context:nil].size ;
    return size;
}

@end
