//
//  NSJSONSerialization+LCJSONUtil.h
//  LCAFNPackage
//
//  Created by luochao on 2017/3/7.
//  Copyright © 2017年 altamob. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSJSONSerialization (LCJSONUtil)

+ (NSString*)dicToJson:(NSDictionary*)params;
+ (id)jsonFromData:(id)responseject;

@end
