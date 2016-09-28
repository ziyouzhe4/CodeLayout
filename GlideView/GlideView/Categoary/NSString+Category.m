//
//  NSString+Category.m
//  ddtc
//
//  Created by 赵祥凯 on 15/11/6.
//  Copyright © 2015年 Careerdream. All rights reserved.
//

#import "NSString+Category.h"

@implementation NSString (Category)

- (CGSize)sizewithFont:(UIFont *)font maxW:(CGFloat)maxW
{
    NSMutableDictionary * attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = font;
    
    CGSize maxSize = CGSizeMake(maxW, MAXFLOAT);
    return [self boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
}

- (CGSize)sizeWithFont:(UIFont *)font
{
    return [self sizewithFont:font maxW:MAXFLOAT];
}

- (NSString *)trimming
{
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
}

- (NSString *)returnTimeStr
{
    
    // _created_at = Thu Oct 16 17:06:25 +0800 2015
    NSDateFormatter * fmt = [[NSDateFormatter alloc]init];
    
    NSString * time = self;
    
    time = [time stringByReplacingOccurrencesOfString:@"T" withString:@" "];
    
    //真机调试,转换这种时间,设置locale
    //    fmt.locale = [[NSLocale alloc]initWithLocaleIdentifier:@"en_US"];
    
    // E:星期几
    // M:月份
    // d:几号(这个月的第几天)
    // H:24小时制的小时
    // m:分钟
    // s:秒
    // y:年
    fmt.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    NSDate * createDate = [fmt dateFromString:time];
    
    //当前时间
    NSDate * now = [NSDate date];
    
    //日历对象
    NSCalendar * calendar = [NSCalendar currentCalendar];
    //NSCalendarUnit想获得哪些差值
    NSCalendarUnit unit = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    //计算两个日期之间差值
    NSDateComponents * cmps = [calendar components:unit fromDate:createDate toDate:now options:0];
    
    fmt.dateFormat = @"HH:mm";
    NSLog(@"%@",[fmt stringFromDate:createDate]);
    
    if ([createDate isThisYear]) {//今年
        if ([createDate isYesterday]) {//昨天
            fmt.dateFormat = @"昨天 HH:mm";
            return [fmt stringFromDate:createDate];
        }else if ([createDate isToday]){//今天
            if (cmps.hour >= 1) {
                return [NSString stringWithFormat:@"%ld小时前",cmps.hour];
            }else if (cmps.minute >= 1){
                return [NSString stringWithFormat:@"%ld分钟前",cmps.minute];
            }else{
                return @"刚刚";
            }
        }else{//今年的其他日子
            fmt.dateFormat = @"MM-dd HH:mm";
            return [fmt stringFromDate:createDate];
        }
    }else{//其他年份
        fmt.dateFormat = @"yyyy-MM-dd HH:mm";
        return [fmt stringFromDate:createDate];
    }
    
    return time;
}

- (BOOL)isEmail
{
    NSString * emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate * emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",emailRegex];
    BOOL y = [emailTest evaluateWithObject:self];
    return y;
}

- (BOOL)isEmpty
{
    if (self != nil && ![self isEqualToString:@""]) {
        return NO;
    }
    return YES;
}

/**
 *  检查输入的内容
 */
- (BOOL)textCheckWithErrorInfo:(NSString *)errorInfo
{
    NSString * tempStr = self.trimming;
    if ([tempStr isEmpty]) {
        if (errorInfo) {
//            [MBProgressHUD show:errorInfo];
        }
        return NO;
    }
    return YES;
}

@end
