//
//  HMStatusDetailView.h
//  微博
//
//  Created by apple on 14-7-14.
//  Copyright (c) 2015年 ma. All rights reserved.
//  微博的具体内容 = 原创微博 + 转发微博

#import <UIKit/UIKit.h>
@class HMStatusDetailFrame;

@interface HMStatusDetailView : UIImageView
@property (nonatomic, strong) HMStatusDetailFrame *detailFrame;
@end
