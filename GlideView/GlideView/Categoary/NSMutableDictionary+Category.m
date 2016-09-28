//
//  NSMutableDictionary+Category.m
//  ddtc
//
//  Created by 赵祥凯 on 15/11/5.
//  Copyright © 2015年 Careerdream. All rights reserved.
//

#import "NSMutableDictionary+Category.h"

@implementation NSMutableDictionary (Category)

- (void)setObjectSafe:(id)anObject forKey:(id<NSCopying>)aKey
{
    if (anObject != nil) {
        [self setObject:anObject forKey:aKey];
    }
}

@end
