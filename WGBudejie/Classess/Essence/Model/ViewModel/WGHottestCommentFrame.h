//
//  WGCommentFrame.h
//  WGBudejie
//
//  Created by taolei on 16/11/2.
//  Copyright © 2016年 taolei. All rights reserved.
//

#import <Foundation/Foundation.h>

@class WGTopic;
@interface WGHottestCommentFrame : NSObject

@property (nonatomic, assign) CGRect titleFrame;

@property (nonatomic, assign) CGRect commentTextFrame;

@property (nonatomic, assign) CGRect frame;

@property (nonatomic, strong) WGTopic *topic;

@end
