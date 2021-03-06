

#import <Foundation/Foundation.h>
#import <AFNetworking/AFHTTPSessionManager.h>

typedef enum IMGTYPE
{
    IMGTYPE_PNG = 0,
    IMGTYPE_JPG = 1
} IMGTYPE;


typedef void(^RequsetSuccess)(id responseObject);
typedef void(^RequsetFailure)(NSError *error);

#define NetWorkingManager [NetWorkManager netWorkManager]

@interface NetWorkManager : NSObject

+ (NetWorkManager *)netWorkManager;


//这个函数就是将字典封装成转义的JSON字符串
- (NSString *)toJSONString:(NSDictionary *)dict;

- (void)getRequestUrl:(NSString *)urlStr
         withPramater:(NSDictionary *)pramater
               sucess:(RequsetSuccess)sucessCallBack
              failure:(RequsetFailure)failureCallBack;

@end
