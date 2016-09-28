//
//  WXStatusPhotosView.h
//  GlideView
//
//  Created by majianjie on 15/12/17.
//  Copyright © 2015年 majianjie. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WXStatusPhotosView : UIView


+ (CGSize)sizeWithPhotosCount:(NSInteger)photosCount;

@property (nonatomic,strong) NSArray *pic_urls;


@end
