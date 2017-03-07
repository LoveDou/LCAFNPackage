//
//  LCHTTPSessionManager.h
//  LCAFNPackage
//
//  Created by luochao on 2017/3/7.
//  Copyright © 2017年 altamob. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>

#define LCBaseURl @"https://app-api.ubaby.cn/"

typedef void(^success)(NSURLSessionDataTask *task , id responseObj);
typedef void(^failure)(NSURLSessionDataTask *task , NSError *error);

typedef NS_ENUM(NSUInteger , LCCachePolicy)
{
    LCReturnCacheDataFirstThenLoad = 0,//先返回缓存数据，然后再请求网络
    LCReturnCacheDataElseLoad ,//先查找缓存数据，如果没有缓存数据才会请求网络
    LCIgnoringCache ,//直接请求网络
};

@interface LCHTTPSessionManager : AFHTTPSessionManager

+ (instancetype)lc_manager;


/**
 GET请求
 此方法采取默认缓存策略：LCReturnCacheDataFirstThenLoad
如果调用此方法将默认为上述缓存策略
 @param URLString URLString
 @param header http header
 @param parameters parameters
 @param success success回调
 @param failure 失败回调
 @return NSURLSessionDataTask
 */
- (NSURLSessionDataTask *)GET:(NSString *)URLString
                       header:(NSDictionary *)header
                   parameters:(id)parameters
                      success:(success)success
                      failure:(failure)failure;


- (NSURLSessionDataTask *)GET:(NSString *)URLString
                       header:(NSDictionary *)header
                   parameters:(id)parameters
                  cachePolicy:(LCCachePolicy)cachePolicy
                      success:(success)success
                      failure:(failure)failure;


- (NSURLSessionDataTask *)POST:(NSString *)URLString
                        header:(NSDictionary *)header
                    parameters:(id)parameter
                      ssuccess:(success)success
                       failure:(failure)failure;

@end
