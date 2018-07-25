//
//  AFNHttpTool.h
//  ECSDKDemo_OC
//
//  Created by huangjue on 16/8/4.
//  Copyright © 2016年 ronglian. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

#define KCNSSTRING_ISEMPTY(str) (str == nil || [str isEqual:[NSNull null]] || str.length <= 0)

#define URLHead @"http://imapp.yuntongxun.com:8999/2016-08-15/Application/"

@interface AFNHttpTool : NSObject
+(instancetype)sharedInstanced;


/**
 查询消息已读状态

 @param type       0 未读 1已读
 @param msgId      消息id
 @param pageSize   每页数量
 @param pageNo     页数
 @param completion block返回值
 */




+ (NSURLSessionDataTask *)post:(NSString *)url params:(NSDictionary *)params
                uploadProgress:( void (^)(NSProgress *uploadProgress))uploadProgressBlock downloadProgress:( void (^)(NSProgress *downloadProgress)) downloadProgressBlock
             completionHandler:(void (^)(NSURLResponse *response, id  responseObject,  NSError *  error))completionHandler failureHandler:(void (^)(NSError *  error))failureHandler;

+ (NSURLSessionDataTask *)get:(NSString *)url params:(NSDictionary *)params
               uploadProgress:( void (^)(NSProgress *uploadProgress))uploadProgressBlock downloadProgress:( void (^)(NSProgress *downloadProgress)) downloadProgressBlock
            completionHandler:(void (^)(NSURLResponse *response, id  responseObject,  NSError *  error))completionHandler failureHandler:(void (^)(NSError *  error))failureHandler;

@end
