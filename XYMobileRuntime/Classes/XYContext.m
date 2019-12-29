//
//  XYContext.m
//  Pods
//
//  Created by quxiangyu on 2019/12/29.
//

#import "XYContext.h"
#import "XYServiceManager.h"

@implementation XYContext

+ (instancetype)sharedInstance {
    static XYContext *context = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        context = [[XYContext alloc] init];
    });
    return context;
}

- (id)findServiceInstanceByName:(NSString *)name {

    return [[XYServiceManager sharedManager] findServiceInstanceByName:name];
}

@end

XYContext *XYContextGet() {

    return [XYContext sharedInstance];
}
