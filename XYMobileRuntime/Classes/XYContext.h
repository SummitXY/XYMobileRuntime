//
//  XYContext.h
//  Pods
//
//  Created by quxiangyu on 2019/12/29.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface XYContext : NSObject

- (id)findServiceInstanceByName:(NSString *)name;

@end

NS_ASSUME_NONNULL_END

#ifdef __cplusplus
extern "C" {
#endif
XYContext *XYContextGet(void);
#ifdef __cplusplus
}
#endif
