//
//  NSDate+Extension.h
//  Careerdream
//
//  Created by 赵祥凯 on 15/7/16.
//  Copyright (c) 2015年 zxk. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (Extension)
/**
 *  判断某个时间是否为今年
 */
- (BOOL)isThisYear;
/**
 *  判断某个时间是否为昨天
 */
- (BOOL)isYesterday;
/**
 *  判断某个时间是否为今天
 */
- (BOOL)isToday;


@end
