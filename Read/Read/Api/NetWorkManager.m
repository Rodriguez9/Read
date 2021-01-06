//
//  HWNetWorkManager.m
//  嗨文
//
//  Created by 响当当 on 2019/1/8.
//  Copyright © 2019年 dongzheng. All rights reserved.
//

#import "NetWorkManager.h"
#import <AFNetworking/AFHTTPSessionManager.h>
#import "Globe.h"
#import <YYModel.h>
#import "CategoryModel.h"

typedef enum REQUESTSTATUS
{
    REQUESTSTATUS_SUCESS = 200, //请求成功
    REQUESTSTATUS_FAILL = 404, //未找到
    REQUESTSTATUS_FAILLD = 400, //请求失败
    REQUESTSTATUS_SERVER_ERROR = 500, //服务器异常
    
} REQUESTSTATUS;

typedef enum HWNetWorkRequestType
{
    
    RequestType_Get = 0,
    RequestType_Post = 1,
    RequestType_ImgFormData = 2,
    RequestType_JsonPost = 3
    
} HWNetWorkRequestType;

static NetWorkManager *manager = nil;
//默认网络请求时间
static const NSUInteger kDefaultTimeoutInterval = 15;

@interface NetWorkManager()
@property (nonatomic,strong) AFHTTPSessionManager *httpManager;
@property (nonatomic,strong) AFURLSessionManager *jsonManager;
@property (nonatomic,assign) BOOL isTokenExpire;    //判断token是否过期
@property (nonatomic,assign) BOOL isLocked;    //用于锁定过期token网络多次请求
@property (nonatomic,assign) BOOL isAlertShowing;    //正在提示
@property (nonatomic,assign) HWNetWorkRequestType requestType;
@property (nonatomic,copy) NSString *currentRequestUrl;
@property (nonatomic,strong) NSDictionary *currentPrarmers;

@end

@implementation NetWorkManager
+ (NetWorkManager *)netWorkManager
{
    @synchronized (manager) {
        if (!manager) {
            manager = [[NetWorkManager alloc]init];
            
            manager.isTokenExpire = false;
            manager.isAlertShowing = false;
#pragma  开始配置普通请求
            manager.httpManager = [AFHTTPSessionManager manager];
            manager.httpManager.requestSerializer.timeoutInterval = kDefaultTimeoutInterval; //默认网络请求时间
            manager.httpManager.responseSerializer = [AFJSONResponseSerializer serializer];

#pragma   结束配置普通请求
        }
    }
    return manager;
}

//这个函数就是将字典封装成转义的JSON字符串
- (NSString *)toJSONString:(NSDictionary *)dict
{
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:&error];
    NSString *str = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
    return str;
}

//
- (void)getRequestUrl:(NSString *)urlStr
         withPramater:(NSDictionary *)pramater
               sucess:(RequsetSuccess)sucessCallBack
              failure:(RequsetFailure)failureCallBack
{
    [self sendNetWorkWithRequestType:RequestType_Get url:urlStr withPramater:pramater sucess:sucessCallBack failure:failureCallBack];
}


#pragma -mark 发送网络请求
- (void)sendNetWorkWithRequestType:(HWNetWorkRequestType)requestType
                               url:(NSString *)urlStr
                      withPramater:(NSDictionary *)pramater
                            sucess:(RequsetSuccess)sucessCallBack
                           failure:(RequsetFailure)failureCallBack
{
    WeakSelf(self);
    
    _requestType = requestType;
    _currentPrarmers = pramater;
    _currentRequestUrl = urlStr;
    if (requestType == RequestType_Get)
    {
        [self.httpManager GET:urlStr parameters:pramater headers:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
              NSNumber *code;
                if(responseObject[@"ok"])
                {
                    code = @200;
                }
                NSData *JSONdata = [NSData data];
                JSONdata = [[self toJSONString:responseObject] dataUsingEncoding:NSUTF8StringEncoding];
                NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:JSONdata options:NSJSONReadingMutableContainers error:nil];
                
                switch ([code intValue]) {
                    case REQUESTSTATUS_SUCESS:
                        //dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                            sucessCallBack(dict);
                        //});
                        break;
                }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            [weakSelf failRequestWithError:error fail:failureCallBack];
        }];
    }
}


#pragma -mark 失败请求回调
- (void)failRequestWithError:(NSError *)error fail:(RequsetFailure)failureCallBack
{
    failureCallBack(error);
}

@end

