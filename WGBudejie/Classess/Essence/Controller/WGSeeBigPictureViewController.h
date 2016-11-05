//
//  WGSeeBigPictureViewController.h
//  WGBudejie
//
//  Created by taolei on 16/11/3.
//  Copyright © 2016年 taolei. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WGTopic;

@interface WGSeeBigPictureViewController : UIViewController
/** 帖子模型 */
@property (nonatomic, strong) WGTopic *topic;
@end
