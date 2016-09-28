//
//  HMComposeToolbar.h
//  majianjie
//
//  Created by apple on 14-7-7.
//  Copyright (c) 2015年 majianjie. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    HMComposeToolbarButtonTypeCamera, // 照相机
    HMComposeToolbarButtonTypePicture, // 相册
    HMComposeToolbarButtonTypeMention, // 提到@
    HMComposeToolbarButtonTypeTrend, // 话题
    HMComposeToolbarButtonTypeEmotion // 表情
} HMComposeToolbarButtonType;

@class HMComposeToolbar;

@protocol HMComposeToolbarDelegate <NSObject>

@optional
- (void)composeTool:(HMComposeToolbar *)toolbar didClickedButton:(HMComposeToolbarButtonType)buttonType;

@end

@interface HMComposeToolbar : UIView
@property (nonatomic, weak) id<HMComposeToolbarDelegate> delegate;
@end
