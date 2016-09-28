//
//  UIImage+Extension.m
//  微博
//
//  Created by apple on 14-7-3.
//  Copyright (c) 2015年 ma. All rights reserved.
//

#import "UIImage+Extension.h"
#define iOS7 ([[UIDevice currentDevice].systemVersion doubleValue] >= 7.0)

@implementation UIImage (Extension)
+ (UIImage *)imageWithName:(NSString *)name
{
    UIImage *image = nil;
    if (iOS7) { // 处理iOS7的情况
        NSString *newName = [name stringByAppendingString:@"_os7"];
        image = [UIImage imageNamed:newName];
    }
    
    if (image == nil) {
        image = [UIImage imageNamed:name];
    }
    return image;
}

+ (UIImage *)resizedImage:(NSString *)name
{
    UIImage *image = [UIImage imageWithName:name];
    return [image stretchableImageWithLeftCapWidth:image.size.width * 0.5 topCapHeight:image.size.height * 0.5];
}
@end
