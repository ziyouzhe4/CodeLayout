//
//  WXStatusDetailFrame.h
//  GlideView
//
//  Created by majianjie on 15/12/17.
//  Copyright © 2015年 majianjie. All rights reserved.
//

#import <Foundation/Foundation.h>

@class WXStatusOriginalFrame,WXStatusApprovingFrame,WXStatusCommentFrame,WXStatusInfo;

@interface WXStatusDetailFrame : NSObject

@property (nonatomic,strong) WXStatusOriginalFrame *originalFrame;
@property (nonatomic,strong) WXStatusApprovingFrame *approvingFrame;
@property (nonatomic,strong) WXStatusCommentFrame *commentFrame;

@property (nonatomic,assign) CGRect bottomLineFrame;

/** 微信数据 */
@property (nonatomic, strong) WXStatusInfo *status;

/**
 *  自己的frame
 */
@property (nonatomic, assign) CGRect frame;


@end
