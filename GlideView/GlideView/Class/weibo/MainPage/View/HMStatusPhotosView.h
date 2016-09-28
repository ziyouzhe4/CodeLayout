//
//  HMPhotosView.h
//  GlideView
//
//  Created by majianjie on 15/12/10.
//  Copyright © 2015年 majianjie. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HMStatusPhotosView : UIView

@property (nonatomic,strong) NSArray *pic_urls;


//根据图片个数,计算最终尺寸
+ (CGSize)sizeWithPhotosCount:(NSInteger)photosCount;

@end
