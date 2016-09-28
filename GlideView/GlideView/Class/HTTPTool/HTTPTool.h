//
//  HTTPTool.h
//  GlideView
//
//  Created by majianjie on 15/12/10.
//  Copyright © 2015年 majianjie. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking.h>


@interface HTTPTool : NSObject


+ (void)GET:(NSString *)url params:(NSDictionary *)params success:(void (^)(id responseObject,NSURLSessionDataTask *task)) success failure:(void (^)(NSError *error,NSURLSessionDataTask *task))failure;

+ (void)POST:(NSString *)url params:(NSDictionary *)params success:(void (^)(id responseObject,NSURLSessionDataTask *task)) success failure:(void (^)(NSError *error,NSURLSessionDataTask *task))failure;

+ (void)cancelRequestWithTarget:(id)target;




@end
