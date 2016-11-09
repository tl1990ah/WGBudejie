//
//  WGCommentFrame.h
//  WGBudejie
//
//  Created by taolei on 16/11/9.
//  Copyright © 2016年 taolei. All rights reserved.
//  评论的frame模型

#import <Foundation/Foundation.h>
@class WGComment;

@interface WGCommentFrame : NSObject
@property (nonatomic, strong) WGComment *comment;
@property (nonatomic, assign) CGRect headerIconFrame;
@property (nonatomic, assign) CGRect usernameFrame;
@property (nonatomic, assign) CGRect contentFrame;
@property (nonatomic, assign) CGRect sexIconFrame;
@property (nonatomic, assign) CGRect likeCountFrame;
@property (nonatomic, assign) CGRect likeBtnFrame;
@property (nonatomic, assign) CGFloat rowHeight;

@end
