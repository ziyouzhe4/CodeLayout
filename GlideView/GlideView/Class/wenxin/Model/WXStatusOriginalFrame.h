//
//  WXStatusOriginalFrame.h
//  GlideView
//
//  Created by majianjie on 15/12/17.
//  Copyright © 2015年 majianjie. All rights reserved.
//

#import <Foundation/Foundation.h>

@class WXStatusInfo;

@interface WXStatusOriginalFrame : NSObject


/** 昵称 */
@property (nonatomic, assign) CGRect nameFrame;
/** 正文 */
@property (nonatomic, assign) CGRect textFrame;
/** 头像 */
@property (nonatomic, assign) CGRect iconFrame;
/** 配图相册  */
@property (nonatomic, assign) CGRect photosFrame;
/** 点赞按钮  */
@property (nonatomic, assign) CGRect approvFrame;
/** 时间Label*/
@property (nonatomic,assign)CGRect timeFrame;
/** 来源 */
@property (nonatomic, assign) CGRect sourceFrame;


/** 微信数据 */
@property (nonatomic, strong) WXStatusInfo *status;
/**自己的frame*/
@property (nonatomic, assign) CGRect frame;

@end
