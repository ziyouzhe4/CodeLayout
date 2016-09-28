//
//  WXStatusApprovingFrame.h
//  GlideView
//
//  Created by majianjie on 15/12/17.
//  Copyright © 2015年 majianjie. All rights reserved.
//

#import <Foundation/Foundation.h>

@class WXStatusInfo;

@interface WXStatusApprovingFrame : NSObject

/** 赞的frame */
@property (nonatomic, assign) CGRect approvLabelFrame;



/** 微信数据 */
@property (nonatomic, strong) WXStatusInfo *status;

/** 自己的frame */
@property (nonatomic, assign) CGRect frame;


@end
