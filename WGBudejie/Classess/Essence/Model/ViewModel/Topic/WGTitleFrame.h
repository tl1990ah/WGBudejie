//
//  WGTitleFrame.h
//  WGBudejie
//
//  Created by taolei on 16/10/26.
//  Copyright © 2016年 taolei. All rights reserved.
//

#import <Foundation/Foundation.h>
@class WGTopic;

@interface WGTitleFrame : NSObject
@property (nonatomic, strong) WGTopic *topic;

/** 昵称 */
@property (nonatomic, assign) CGRect nameFrame;
/** 正文 */
@property (nonatomic, assign) CGRect textFrame;
/** 头像 */
@property (nonatomic, assign) CGRect headIconFrame;
/** 时间 */
@property (nonatomic, assign) CGRect timeFrame;
/** 更多按钮 */
@property (nonatomic, assign) CGRect moreBtnFrame;


/** 自己的frame */
@property (nonatomic, assign) CGRect frame;

@end
