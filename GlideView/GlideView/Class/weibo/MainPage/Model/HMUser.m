//
//  HMUser.m
//  微博
//
//  Created by apple on 14-7-8.
//  Copyright (c) 2015年 ma. All rights reserved.
//

#import "HMUser.h"

@implementation HMUser

- (BOOL)isVip
{
    // 是会员
    return self.mbtype > 2;
}

@end
