//
//  XYContextMap.m
//  Pods
//
//  Created by quxiangyu on 2019/12/29.
//

#import "XYContextMap.h"

@implementation XYContextMap

+ (NSDictionary *)serviceMap {

    return @{
        @"lazy":@[
                @{
                    @"name":@"TestName",
                    @"className":@"TestClassName",
                    @"protocol":@""
                }]
    };
}

@end
