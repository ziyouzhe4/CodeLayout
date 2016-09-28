//
//  UIWindow+Extension.m
//  Careerdream
//
//  Created by 赵祥凯 on 15/7/1.
//  Copyright (c) 2015年 zxk. All rights reserved.
//

#import "UIWindow+Extension.h"

@implementation UIWindow (Extension)

/**
 *  切换根视图
 */
- (void)swithRootViewController
{
    
}

/**
 *  切换根视图
 */
- (void)swithLogin
{
    UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"LoginReg" bundle:nil];
    UIViewController* loginRegVC = [storyboard instantiateInitialViewController];
    self.rootViewController = loginRegVC;
}

@end
