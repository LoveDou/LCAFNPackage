//
//  LCHTTPSessionManager.m
//  LCAFNPackage
//
//  Created by luochao on 2016/3/5.
//  Copyright © 2016年 altamob. All rights reserved.
//

#import "LCHTTPSessionManager.h"
#import "NSJSONSerialization+LCJSONUtil.h"
#import <YYCache.h>

@implementation LCHTTPSessionManager


+ (instancetype)lc_manager
{
    static LCHTTPSessionManager *_sessionManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
        [config setRequestCachePolicy:NSURLRequestReloadIgnoringCacheData];
        _sessionManager = [[self alloc] initWithBaseURL:[NSURL URLWithString:LCBaseURl]
                                   sessionConfiguration:config];
    });
    return _sessionManager;
}


- (id)init
{
    self = [super init];
    if (self) {
        self.requestSerializer.timeoutInterval = 10.0f;
    }
    return self;
}

- (NSURLSessionDataTask *)GET:(NSString *)URLString
                       header:(NSDictionary *)header
                   parameters:(id)parameters
                      success:(success)success
                      failure:(failure)failure
{
    return [self GET:URLString
              header:header
          parameters:parameters
         cachePolicy:LCReturnCacheDataFirstThenLoad
             success:success
             failure:failure];
}

- (NSURLSessionDataTask *)GET:(NSString *)URLString
                       header:(NSDictionary *)header
                   parameters:(id)parameters
                  cachePolicy:(LCCachePolicy)cachePolicy
                      success:(success)success
                      failure:(failure)failure
{
    NSString *cacheKey = [NSString stringWithFormat:@"%@%@",URLString,[NSJSONSerialization dicToJson:parameters]];
    YYCache *yycache = [[YYCache alloc] initWithName:@"com.LC.AFNPackage"];
    id cache = [yycache objectForKey:cacheKey];
    if (LCReturnCacheDataFirstThenLoad == cachePolicy) {
        if (cache) {
            success(nil , cache);
        }
    }
    else if (LCReturnCacheDataElseLoad == cachePolicy)
    {
        if (cache) {
            success(nil , cache);
            return nil;
        }
    }
    
    if ([header isKindOfClass:[NSDictionary class]]) {//设置header
        for (NSString *key in header.allKeys) {
            NSString *value = header[key];
            [self.requestSerializer setValue:value forHTTPHeaderField:key];
        }
    }
    [self.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    self.responseSerializer = [AFJSONResponseSerializer serializer];
    return [super GET:URLString parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        responseObject = [NSJSONSerialization jsonFromData:responseObject];
        if ([responseObject isKindOfClass:[NSArray class]] &&
            ((NSArray*)responseObject).count == 0) {
            responseObject = [NSDictionary dictionary];
        }
        if (![responseObject isKindOfClass:[NSNull class]] &&
            responseObject != nil &&
            [responseObject isKindOfClass:[NSDictionary class]]) {
            [yycache objectForKey:cacheKey];
        }
        if (![responseObject isKindOfClass:[NSNull class]] &&
            responseObject != nil &&
            [responseObject isKindOfClass:[NSDictionary class]]) {
            [yycache setObject:responseObject forKey:cacheKey];
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                id cache = [yycache objectForKey:cacheKey];
                NSLog(@"cache----->>%@",cache);
            });
        }
        success(task, responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(task , error);
    }];
}


- (NSURLSessionDataTask *)POST:(NSString *)URLString
                        header:(NSDictionary *)header
                    parameters:(id)parameter
                      ssuccess:(success)success
                       failure:(failure)failure
{
    if ([header isKindOfClass:[NSDictionary class]]) {//设置header
        for (NSString *key in header.allKeys) {
            NSString *value = header[key];
            [self.requestSerializer setValue:value forHTTPHeaderField:key];
        }
    }
    self.responseSerializer = [AFJSONResponseSerializer serializer];
    return [super POST:URLString
            parameters:parameter
              progress:^(NSProgress * _Nonnull uploadProgress) {
        
               }
               success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                   success(task , responseObject);
               }
               failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                   failure(task , error);
               }];
}

@end
