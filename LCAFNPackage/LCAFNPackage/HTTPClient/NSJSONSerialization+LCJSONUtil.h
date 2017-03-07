//
//  NSJSONSerialization+LCJSONUtil.h
//  LCAFNPackage
//
//  Created by luochao on 2016/3/5.
//  Copyright © 2016年 altamob. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSJSONSerialization (LCJSONUtil)

+ (NSString*)dicToJson:(NSDictionary*)params;
+ (id)jsonFromData:(id)responseject;

@end
