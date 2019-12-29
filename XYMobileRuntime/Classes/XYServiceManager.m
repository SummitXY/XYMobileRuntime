//
//  XYServiceManager.m
//  Pods
//
//  Created by quxiangyu on 2019/12/29.
//

#import "XYServiceManager.h"
#import <pthread.h>
#import "XYContextMap.h"

static pthread_mutex_t _lock;
static pthread_mutexattr_t _attr;

@interface XYServiceManager ()

@property (nonatomic, strong) NSDictionary *serviceMap;
@property (nonatomic, strong) NSMutableDictionary *serviceName2ClassNameMap;
@property (nonatomic, strong) NSMutableDictionary *serviceClassName2InstanceMap;

@end

@implementation XYServiceManager

+ (instancetype)sharedManager {
    static XYServiceManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[XYServiceManager alloc] init];
        [manager setup];
    });
    return manager;
}

- (void)setup {

    pthread_mutexattr_init(&_attr);
    pthread_mutexattr_settype(&_attr, PTHREAD_MUTEX_RECURSIVE);
    pthread_mutex_init(&_lock, &_attr);
    pthread_mutexattr_destroy(&_attr);

    self.serviceMap = [XYContextMap serviceMap];
    self.serviceName2ClassNameMap = [NSMutableDictionary dictionary];

    [self setupServices:@"lazy" create:NO];
}

- (void)setupServices:(NSString *)tag create:(BOOL)create {

    for (NSDictionary *dic in [self.serviceMap objectForKey:tag]) {
        if ([dic isKindOfClass:[NSDictionary class]]) {

            NSString *name = [dic objectForKey:@"name"];
            NSString *className = [dic objectForKey:@"className"];

            if (name && className) {
                [self.serviceName2ClassNameMap setValue:className forKey:name];

                if (create) {
                    [self serviceInstanceForClassName:className];
                }
            }
        }
    }
}

- (id)findServiceInstanceByName:(NSString *)name {

    pthread_mutex_lock(&_lock);
    NSString *className = [self.serviceName2ClassNameMap objectForKey:name];
    pthread_mutex_unlock(&_lock);
    return [self serviceInstanceForClassName:name];
}

- (id)serviceInstanceForClassName:(NSString *)className {

    pthread_mutex_lock(&_lock);
    id ins = [self.serviceClassName2InstanceMap objectForKey:className];
    pthread_mutex_unlock(&_lock);

    if (ins) {
        return ins;
    }

    Class serviceClass = NSClassFromString(className);
    if (serviceClass) {
        SEL serviceSelector = NSSelectorFromString(@"sharedInstance");
        if ([serviceClass respondsToSelector:serviceSelector]) {
            id serviceInstance = [serviceClass performSelector:serviceSelector];
            if (serviceInstance) {
                pthread_mutex_lock(&_lock);
                [self.serviceClassName2InstanceMap setValue:serviceInstance forKey:className];
                pthread_mutex_unlock(&_lock);
                return serviceInstance;
            }
        } else {
            id serviceInstance = [serviceClass new];
            return serviceInstance;
        }
    }

    return nil;
}

@end
