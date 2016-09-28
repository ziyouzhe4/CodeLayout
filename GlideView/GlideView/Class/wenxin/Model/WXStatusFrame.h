//
//  WXStatusFrame.h
//  GlideView
//
//  Created by majianjie on 15/12/17.
//  Copyright © 2015年 majianjie. All rights reserved.
//

#import <Foundation/Foundation.h>

@class WXStatusInfo,WXStatusDetailFrame;

@interface WXStatusFrame : NSObject

@property (nonatomic,strong) WXStatusInfo *status;
@property (nonatomic,strong) WXStatusDetailFrame *detailFrame;

/** cell的高度 */
@property (nonatomic, assign) CGFloat cellHeight;




@end
