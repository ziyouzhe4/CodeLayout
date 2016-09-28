//
//  UIImageView+Extionsino.h
//  tusstar
//
//  Created by zxk on 15/5/19.
//  Copyright (c) 2015年 zxk. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Extionsion)
+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size;
- (UIImage *)scaleToSize:(UIImage *)img size:(CGSize)size;

- (UIImage *)scaleImg:(UIImage *)img size:(CGSize)size;

@end
