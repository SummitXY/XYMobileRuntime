#ifdef __OBJC__
#import <UIKit/UIKit.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

#import "XYContext.h"
#import "XYContextMap.h"
#import "XYServiceManager.h"

FOUNDATION_EXPORT double XYMobileRuntimeVersionNumber;
FOUNDATION_EXPORT const unsigned char XYMobileRuntimeVersionString[];

