//
//  NSJSONSerialization+LCJSONUtil.m
//  LCAFNPackage
//
//  Created by luochao on 2017/3/7.
//  Copyright © 2017年 altamob. All rights reserved.
//

#import "NSJSONSerialization+LCJSONUtil.h"

@implementation NSJSONSerialization (LCJSONUtil)


+ (NSString*)dicToJson:(NSDictionary*)params
{
    if (params == nil ||
        [params isKindOfClass:[NSNull class]]) {
        return @"";
    }
    
    if ([params isKindOfClass:[NSDictionary class]]) {
        NSError *parseError = nil;
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:params
                                                           options:NSJSONWritingPrettyPrinted
                                                             error:&parseError];
        return [[NSString alloc] initWithData:jsonData
                                     encoding:NSUTF8StringEncoding];
    }
    
    return [NSString stringWithFormat:@"%@",params];
}

+ (id)jsonFromData:(id)responseject
{
    if ([responseject isKindOfClass:[NSData class]]) {
        return [NSJSONSerialization JSONObjectWithData:responseject options:NSJSONReadingMutableContainers error:nil];
    }
    return responseject;
}


@end
