//
//  AFNHttpTool.m
//  ECSDKDemo_OC
//
//  Created by huangjue on 16/8/4.
//  Copyright © 2016年 ronglian. All rights reserved.
//

#import "AFNHttpTool.h"
@interface AFNHttpTool ()
@property (nonatomic, assign) NSInteger SmsVerifyCodeType;
@property (nonatomic, strong) AFHTTPSessionManager *mgr;
@end

@implementation AFNHttpTool

+(instancetype)sharedInstanced {
    static dispatch_once_t onceToken;
    static AFNHttpTool *httptool;
    dispatch_once(&onceToken, ^{
        httptool = [[self alloc] init];
    });
    return httptool;
}

+ (NSURLSessionDataTask *)post:(NSString *)url params:(NSDictionary *)params
                uploadProgress:( void (^)(NSProgress *uploadProgress))uploadProgressBlock downloadProgress:( void (^)(NSProgress *downloadProgress)) downloadProgressBlock
             completionHandler:(void (^)(NSURLResponse *response, id  responseObject,  NSError *  error))completionHandler failureHandler:(void (^)(NSError *  error))failureHandler{
    url = [NSString stringWithFormat:@"%@%@",SERVER_URL,url];

    // 2. 创建SessionConfiguration
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    // 3. 创建SessionManager
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] initWithSessionConfiguration:configuration];

#pragma mark -  设置非校验证书模式
    {
        manager.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
        manager.securityPolicy.allowInvalidCertificates = YES;
        [manager.securityPolicy setValidatesDomainName:NO];
    }
    // 4. 创建Request
    NSMutableURLRequest *request = [[AFJSONRequestSerializer serializer] requestWithMethod:@"POST" URLString:url parameters:params error:nil];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];

    // 5. 设置Response
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", nil];
    NSURLSessionDataTask *dataTask = [manager dataTaskWithRequest:request uploadProgress:^(NSProgress * _Nonnull uploadProgress) {
        if (uploadProgressBlock) {
            uploadProgressBlock(uploadProgress);
        }
    } downloadProgress:^(NSProgress * _Nonnull downloadProgress) {
        if (downloadProgressBlock) {
            downloadProgressBlock(downloadProgress);
        }
    } completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        if (error) {
            if ([responseObject objectForKey:@"errmsg"]) {
                
            }else{
                
            }
            failureHandler(error);

        }else{
            completionHandler(response,responseObject,error);
        }

    }];
    // 7. 执行SessionDataTask
    [dataTask resume];
    return dataTask;
}

+ (NSURLSessionDataTask *)get:(NSString *)url params:(NSDictionary *)params
                uploadProgress:( void (^)(NSProgress *uploadProgress))uploadProgressBlock downloadProgress:( void (^)(NSProgress *downloadProgress)) downloadProgressBlock
             completionHandler:(void (^)(NSURLResponse *response, id  responseObject,  NSError *  error))completionHandler failureHandler:(void (^)(NSError *  error))failureHandler{
    url = [NSString stringWithFormat:@"%@%@",SERVER_URL,url];

    // 2. 创建SessionConfiguration
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
//    // 3. 创建SessionManager
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] initWithSessionConfiguration:configuration];
#pragma mark -  设置非校验证书模式
    {
        manager.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
        manager.securityPolicy.allowInvalidCertificates = YES;
        [manager.securityPolicy setValidatesDomainName:NO];
    }
    
    // 4. 创建Request
    NSMutableURLRequest *request = [[AFJSONRequestSerializer serializer] requestWithMethod:@"GET" URLString:url parameters:params error:nil];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];    

   
    // 5. 设置Response

        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", nil];

    NSURLSessionDataTask *dataTask = [manager dataTaskWithRequest:request uploadProgress:^(NSProgress * _Nonnull uploadProgress) {
        if (uploadProgressBlock) {
            uploadProgressBlock(uploadProgress);
        }
    } downloadProgress:^(NSProgress * _Nonnull downloadProgress) {
        if (downloadProgressBlock) {
            downloadProgressBlock(downloadProgress);
        }
    } completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {

        if (error) {
            if ([responseObject objectForKey:@"errmsg"]) {

            }else{

            }
            failureHandler(error);
        }else{
            completionHandler(response,responseObject,error);
        }
    }];
    // 7. 执行SessionDataTask
    [dataTask resume];
    return dataTask;
}

@end
