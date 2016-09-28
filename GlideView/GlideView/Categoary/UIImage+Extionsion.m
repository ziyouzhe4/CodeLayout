//
//  UIImageView+Extionsino.m
//  tusstar
//
//  Created by zxk on 15/5/19.
//  Copyright (c) 2015年 zxk. All rights reserved.
//

#import "UIImage+Extionsion.h"

@implementation UIImage (Extension)
+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size {
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
    
}

- (UIImage *)scaleToSize:(UIImage *)img size:(CGSize)size{
    // 创建一个bitmap的context
    // 并把它设置成为当前正在使用的context
    UIGraphicsBeginImageContext(size);
    // 绘制改变大小的图片
    [img drawInRect:CGRectMake(0,0, size.width, size.height)];
    
    // 从当前context中创建一个改变大小后的图片
    UIImage* scaledImage =UIGraphicsGetImageFromCurrentImageContext();
    // 使当前的context出堆栈
    UIGraphicsEndImageContext();
    //返回新的改变大小后的图片
    return scaledImage;
}

- (UIImage *)scaleImg:(UIImage *)img size:(CGSize)size
{
    UIImage * contextedImage;
    CGAffineTransform transform = CGAffineTransformIdentity;
    if (img.imageOrientation == UIImageOrientationUp) {
        contextedImage = img;
    }else{
        switch (img.imageOrientation) {
            case UIImageOrientationDown:
            case UIImageOrientationDownMirrored:
            {
                transform = CGAffineTransformTranslate(transform, img.size.width, img.size.height);
                transform = CGAffineTransformRotate(transform, M_PI);
                break;
            }
            case UIImageOrientationLeft:
            case UIImageOrientationLeftMirrored:
            {
                transform = CGAffineTransformTranslate(transform, img.size.width, 0);
                transform = CGAffineTransformRotate(transform, M_PI_2);
                break;
            }
            case UIImageOrientationRight:
            case UIImageOrientationRightMirrored:
            {
                transform = CGAffineTransformTranslate(transform, 0,img.size.height);
                transform = CGAffineTransformRotate(transform, -M_PI_2);
                break;
            }
            default:
                break;
        }
        
        switch (img.imageOrientation) {
            case UIImageOrientationUpMirrored:
            case UIImageOrientationDownMirrored:
            {
                transform = CGAffineTransformTranslate(transform, img.size.width, 0);
                transform = CGAffineTransformScale(transform, -1, 1);
                break;
            }
            case UIImageOrientationLeftMirrored:
            case UIImageOrientationRightMirrored:
            {
                transform = CGAffineTransformTranslate(transform, img.size.height, 0);
                transform = CGAffineTransformScale(transform, -1, 1);
                break;
            }
            default:
                break;
        }
        
        CGContextRef ctx = CGBitmapContextCreate(NULL, img.size.width, img.size.height, CGImageGetBitsPerComponent(img.CGImage), 0, CGImageGetColorSpace(img.CGImage), CGImageGetBitmapInfo(img.CGImage));
        
        CGContextConcatCTM(ctx, transform);
        
        switch (img.imageOrientation) {
                
            case UIImageOrientationLeft:
                
            case UIImageOrientationLeftMirrored:
                
            case UIImageOrientationRight:
                
            case UIImageOrientationRightMirrored:
                
                CGContextDrawImage(ctx, CGRectMake(0, 0, img.size.height,img.size.width), img.CGImage);
                
                break;
                
            default:
                
                CGContextDrawImage(ctx, CGRectMake(0, 0, img.size.width, img.size.height), img.CGImage);
                
                break;
                
        }
        
        
        CGImageRef cgimg = CGBitmapContextCreateImage(ctx);
        
        contextedImage = [UIImage imageWithCGImage:cgimg];
        
        CGContextRelease(ctx);
        
        CGImageRelease(cgimg);
    }
    return contextedImage;
}

@end
