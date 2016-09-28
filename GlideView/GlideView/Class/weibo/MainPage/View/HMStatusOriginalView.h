//
//  HMStatusOriginalView.h
//  微博
//
//  Created by apple on 14-7-14.
//  Copyright (c) 2015年 ma. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HMStatusPhotosView.h"

@class HMStatusOriginalFrame;

@interface HMStatusOriginalView : UIView
@property (nonatomic, strong) HMStatusOriginalFrame *originalFrame;
/**配图相册*/
@property (nonatomic,strong) HMStatusPhotosView *photosView;

@end
