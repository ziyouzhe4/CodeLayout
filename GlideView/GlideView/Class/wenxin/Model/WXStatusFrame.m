//
//  WXStatusFrame.m
//  GlideView
//
//  Created by majianjie on 15/12/17.
//  Copyright © 2015年 majianjie. All rights reserved.
//

#import "WXStatusFrame.h"
#import "WXStatusDetailFrame.h"

@implementation WXStatusFrame

- (void)setStatus:(WXStatusInfo *)status
{
    _status = status;
    
    // 1.计算微博具体内容（微博整体）
    [self setupDetailFrame];
    
    // 3.计算cell的高度
    self.cellHeight = CGRectGetMaxY(self.detailFrame.frame);
}

/**
 *  计算微信具体内容（微信整体）
 */
- (void)setupDetailFrame
{
    WXStatusDetailFrame *detailFrame = [[WXStatusDetailFrame alloc] init];
    detailFrame.status = self.status;
    self.detailFrame = detailFrame;
}


@end
