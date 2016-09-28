//
//  HMStatusRetweetedFrame.h
//  微博
//
//  Created by apple on 14-7-14.
//  Copyright (c) 2015年 ma. All rights reserved.
//

#import <Foundation/Foundation.h>
@class HMStatus;
@interface HMStatusRetweetedFrame : NSObject
/** 昵称 */
@property (nonatomic, assign) CGRect nameFrame;
/** 正文 */
@property (nonatomic, assign) CGRect textFrame;
/** 配图相册  */
@property (nonatomic, assign) CGRect photosFrame;

/** 自己的frame */
@property (nonatomic, assign) CGRect frame;

/** 转发微博的数据 */
@property (nonatomic, strong) HMStatus *retweetedStatus;
@end
