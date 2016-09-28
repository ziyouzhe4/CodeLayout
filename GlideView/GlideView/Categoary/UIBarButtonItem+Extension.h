//
//  UIBarButtonItem+Extension.h
//  Careerdream
//
//  Created by 赵祥凯 on 15/7/10.
//  Copyright (c) 2015年 zxk. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (Extension)
+ (UIBarButtonItem *)itemWithTarget:(id)target action:(SEL)action image:(NSString *)image highImage:(NSString *)highImage;
@end
