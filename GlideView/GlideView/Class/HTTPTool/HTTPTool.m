//
//  HTTPTool.m
//  GlideView
//
//  Created by majianjie on 15/12/10.
//  Copyright © 2015年 majianjie. All rights reserved.
//

#import "HTTPTool.h"
#import <AFNetworking.h>
@implementation HTTPTool

+ (void)GET:(NSString *)url params:(NSDictionary *)params success:(void (^)(id response, NSURLSessionDataTask * task))success failure:(void (^)(NSError *error, NSURLSessionDataTask *task))failure

{
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    
    [mgr GET:url parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            success(responseObject,task);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error,task);
        }                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         
    }];
    
}

+ (void)POST:(NSString *)url params:(NSDictionary *)params success:(void (^)(id responseObject, NSURLSessionDataTask *task))success failure:(void (^)(NSError *error, NSURLSessionDataTask *task))failure
{
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    [mgr POST:url parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            success(responseObject,task);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error,task);
        }
    }];
    
}

+ (void)cancelRequestWithTarget:(id)target{

    [AFHTTPSessionManager cancelPreviousPerformRequestsWithTarget:target];
    
    [[AFHTTPSessionManager manager].operationQueue cancelAllOperations];
}




@end
