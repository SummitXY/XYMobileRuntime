//
//  XYServiceManager.h
//  Pods
//
//  Created by quxiangyu on 2019/12/29.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface XYServiceManager : NSObject

+ (instancetype)sharedManager;

- (id)findServiceInstanceByName:(NSString *)name;

@end

NS_ASSUME_NONNULL_END
