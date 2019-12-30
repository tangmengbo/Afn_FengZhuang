//
//  HTTPModel.m
//  FindingMe
//
//  Created by pfjhetg on 2016/12/13.
//  Copyright © 2016年 3VOnline Inc. All rights reserved.
//

#import "HTTPModel.h"
#import "AppDelegate.h"
#import "Usually.h"
#import "NSData+Additions.h"
#import <AdSupport/AdSupport.h>



#define WEAKSELF __weak typeof(self) weakSelf = self;


// 最后一句不要斜线
#define singleton_implementation(className) \
static className *_instace; \
\
+ (id)allocWithZone:(struct _NSZone *)zone \
{ \
static dispatch_once_t onceToken; \
dispatch_once(&onceToken, ^{ \
_instace = [super allocWithZone:zone]; \
}); \
\
return _instace; \
} \
\
+ (instancetype)shared##className \
{ \
if (_instace == nil) { \
_instace = [[className alloc] init]; \
} \
\
return _instace; \
}



@implementation HTTPModel
singleton_implementation(HTTPModel)

# pragma - mark 封装请求

+(NSString *)getRandom
{
    NSDateFormatter *dateFormater = [[NSDateFormatter alloc] init];
    [dateFormater setDateFormat:@"yyyyMMddHHmmss"];
    NSString * dateStr =  [dateFormater stringFromDate:[NSDate date]] ;//获取年月日字符串

    int num = (arc4random() % 100);
    NSString * numStr = [NSString stringWithFormat:@"%.2d", num]; //获取六位的随机数
    return [dateStr stringByAppendingString:numStr];
}
+ (NSString *)generateRequestParameter:(NSDictionary *)parameterDict
{
    NSString *parameterString = [[NSString alloc] init];
    if ([parameterDict isKindOfClass:[NSDictionary class]]) {
        
        
        NSMutableDictionary * dic = [[NSMutableDictionary alloc] initWithDictionary:parameterDict];
        
        NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
        
        NSDictionary * info = [defaults objectForKey:USERINFO];
        
        if ([info isKindOfClass:[NSDictionary class]]) {
            
            [dic setObject:[info objectForKey:@"userId"] forKey:@"userId"];
            NSMutableArray *valuesArray  = [NSMutableArray array];
            for (id value in [dic allValues]) {
                
                if ([value isKindOfClass:[NSNumber class]]) {
                    NSNumber * valueNumber = value;
                    [valuesArray addObject:[NSString stringWithFormat:@"%d",valueNumber.intValue]];
                }
                else
                {
                    [valuesArray addObject:value];
                }
            }
            NSString *values = [valuesArray componentsJoinedByString:@""];
            parameterString = [[[parameterString stringByAppendingString:values] stringByAppendingString:[Usually getobjectForKey:[info objectForKey:@"token"]]] stringByAppendingString:APPKEY];
        }
        else
        {
            NSMutableArray *valuesArray  = [NSMutableArray array];
            for (id value in [dic allValues]) {
                
                if ([value isKindOfClass:[NSNumber class]]) {
                    
                    NSNumber * valueNumber = value;
                    [valuesArray addObject:[NSString stringWithFormat:@"%d",valueNumber.intValue]];
                }
                else
                {
                    [valuesArray addObject:value];
                }
            }
            
            NSString *values = [valuesArray componentsJoinedByString:@""];
            parameterString = [[[parameterString stringByAppendingString:values] stringByAppendingString:@""] stringByAppendingString:APPKEY];
        }
        
        if (parameterString) {
            
            return [[parameterString dataUsingEncoding:NSUTF8StringEncoding] md5Hash];;
            
        }
        
    }
    
    return parameterString;
}
+ (void)POST:(NSString *)URLString
  parameters:(id)parameters
    progress:(void (^)(NSProgress *))progress
     success:(void (^)(NSURLSessionDataTask *, id))success
     failure:(void (^)(NSURLSessionDataTask *, NSError *))failure{
    WEAKSELF
    
    AFAppDotNetAPIClient * apiClient =   [AFAppDotNetAPIClient sharedClient];
    
    apiClient.requestSerializer = [AFJSONRequestSerializer serializer];
    
    [apiClient.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [apiClient.requestSerializer setValue:[self getRandom] forHTTPHeaderField:@"random"];
    [apiClient.requestSerializer setValue:@"lang" forHTTPHeaderField:@"zh_CN"];
    [apiClient.requestSerializer setValue:APPNAME forHTTPHeaderField:@"appName"];
    [apiClient.requestSerializer setValue:[self generateRequestParameter:parameters] forHTTPHeaderField:@"signature"];
    NSString * sysVersion = [[UIDevice currentDevice] systemVersion];//手机系统版本

    [apiClient.requestSerializer setValue:sysVersion forHTTPHeaderField:@"sysVersion"];
    NSString * deviceId = [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];//设备deviceID

    [apiClient.requestSerializer setValue:deviceId forHTTPHeaderField:@"deviceId"];
    NSString * deviceInfo = [Usually getCurrentDeviceModel];//手机型号
    [apiClient.requestSerializer setValue:deviceInfo forHTTPHeaderField:@"deviceInfo"];
    
    [apiClient.requestSerializer setValue:@"IOS" forHTTPHeaderField:@"sysType"];
    
    NSString * UA = [NSString stringWithFormat:@"%@_ios/%@",APPNAME,  [[NSBundle mainBundle] infoDictionary][@"CFBundleShortVersionString"]];

    [apiClient.requestSerializer setValue:UA forHTTPHeaderField:@"User-Agent"];
    NSString * version = [[NSBundle mainBundle] infoDictionary][@"CFBundleShortVersionString"];
    [apiClient.requestSerializer setValue:version forHTTPHeaderField:@"version"];
    [apiClient.requestSerializer setValue:@"appstore" forHTTPHeaderField:@"channel"];
    
    
    [apiClient POST:URLString parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        if (progress) {
            progress(uploadProgress);
        }
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            success(task, responseObject);
            if ([responseObject valueForKey:@"result"]) {
                if ([[[responseObject valueForKey:@"result"] valueForKey:@"retCode"] integerValue] == -2) {
                }
            }
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSHTTPURLResponse *re =(NSHTTPURLResponse *)  task.response;
        if (maxCont == 1) {
            if (failure) {
                failure(task, error);
               // [Common showMessageView:NET_ERROR_MSG];
            }
        } else if (error.code == -1001 || re.statusCode == 504) {
            dispatch_after(100*NSEC_PER_MSEC, dispatch_get_main_queue(), ^{
                [weakSelf REPLYPOST:URLString  errerCount:1 parameters:parameters progress:progress success:success failure:failure];
            });
        } else {
            if (failure) {
                failure(task, error);
                // [Common showMessageView:NET_ERROR_MSG];
               // [Common showMessageView:NET_ERROR_MSG view:self.view];
            }
        }
    }];
}


+ (void)REPLYPOST:(NSString *)URLString
       errerCount:(int)errerCount
       parameters:(id)parameters
         progress:(void (^)(NSProgress *))progress
          success:(void (^)(NSURLSessionDataTask *, id))success
          failure:(void (^)(NSURLSessionDataTask *, NSError *))failure{
    WEAKSELF
    [[AFAppDotNetAPIClient sharedClient] POST:URLString parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        if (progress) {
            progress(uploadProgress);
        }
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            success(task, responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSHTTPURLResponse *re =(NSHTTPURLResponse *)  task.response;
        if (error.code == -1001 || re.statusCode == 504) {
            int er = errerCount +1;
            if (er>=maxCont) {
                if (failure) {
                    failure(task, error);
                    // [Common showMessageView:NET_ERROR_MSG];
                }
            } else {
                dispatch_after(100*NSEC_PER_MSEC, dispatch_get_main_queue(), ^{
                    [weakSelf REPLYPOST:URLString errerCount:er parameters:parameters progress:progress success:success failure:failure];
                });
            }
        } else {
            if (failure) {
                failure(task, error);
                 //[Common showMessageView:NET_ERROR_MSG];
            }
        }
    }];
}


+ (void)GET:(NSString *)URLString
 parameters:(id)parameters
   progress:(void (^)(NSProgress *))progress
    success:(void (^)(NSURLSessionDataTask *, id))success
    failure:(void (^)(NSURLSessionDataTask *, NSError *))failure{
    WEAKSELF
    [[AFAppDotNetAPIClient sharedClient] GET:URLString parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        if (progress) {
            progress(uploadProgress);
        }
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            success(task, responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSHTTPURLResponse *re =(NSHTTPURLResponse *)  task.response;
        if (maxCont == 1) {
            if (failure) {
                failure(task, error);
                // [Common showMessageView:NET_ERROR_MSG];
            }
        } else if (error.code == -1001 || re.statusCode == 504) {
            dispatch_after(100*NSEC_PER_MSEC, dispatch_get_main_queue(), ^{
                [weakSelf REPLYGET:URLString  errerCount:1 parameters:parameters progress:progress success:success failure:failure];
            });
        } else {
            if (failure) {
                failure(task, error);
                // [Common showMessageView:NET_ERROR_MSG];
            }
        }
    }];
}


+ (void)REPLYGET:(NSString *)URLString  errerCount:(int)errerCount parameters:(id)parameters progress:(void (^)(NSProgress *))progress success:(void (^)(NSURLSessionDataTask *, id))success failure:(void (^)(NSURLSessionDataTask *, NSError *))failure{
    __weak typeof(self) _weekSelf = self;
    [[AFAppDotNetAPIClient sharedClient] GET:URLString parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        if (progress) {
            progress(uploadProgress);
        }
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            success(task, responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSHTTPURLResponse *re =(NSHTTPURLResponse *)  task.response;
        if (error.code == -1001 || re.statusCode == 504) {
            int er = errerCount + 1;
            if (er >= maxCont) {
                if (failure) {
                    failure(task, error);
                    // [Common showMessageView:NET_ERROR_MSG];
                }
            } else {
                dispatch_after(100*NSEC_PER_MSEC, dispatch_get_main_queue(), ^{
                    [_weekSelf REPLYGET:URLString  errerCount:er parameters:parameters progress:progress success:success failure:failure];
                });
            }
        } else {
            if (failure) {
                failure(task, error);
                // [Common showMessageView:NET_ERROR_MSG];
            }
        }
    }];
}


+ (void)SINGERGET:(NSString *)URLString parameters:(id)parameters progress:(void (^)(NSProgress *))progress success:(void (^)(NSURLSessionDataTask *, id))success failure:(void (^)(NSURLSessionDataTask *, NSError *))failure{
    [[AFAppDotNetAPIClient sharedClient] GET:URLString parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        if (progress) {
            progress(uploadProgress);
        }
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            success(task, responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(task, error);
            // [Common showMessageView:NET_ERROR_MSG];
        }
    }];
}


+ (void)clearAllRequt{
    [AFAppDotNetAPIClient clearAllRequest];
}


# pragma - mark http请求接口

+(void)xt_sendVerifyCode:(NSString *_Nullable)mobile
                    type:(NSString *_Nullable)type
                callback:(nullable void (^)(NSInteger status, id _Nullable responseObject, NSString* _Nullable msg))callback
{
    NSString *url = @"http://test-xt-api.cyoulive.cn/api/sendVerifyCode";//[NSString stringWithFormat:@"%@%@/%@", @"http://test-xt-api.cyoulive.cn/",@"api",@"login"];
      
      NSMutableDictionary * parameter = [[NSMutableDictionary alloc] init];
      [parameter setObject:[Usually getobjectForKey:mobile] forKey:@"mobile"];
      [parameter setObject:[Usually getobjectForKey:type] forKey:@"type"];
      
      [HTTPModel POST:url parameters:parameter progress:^(NSProgress * progress) {
          
      } success:^(NSURLSessionDataTask *task, id responseObject) {
          if ([responseObject valueForKey:@"result"]) {
              callback([[[responseObject valueForKey:@"result"] valueForKey:@"retCode"] integerValue], responseObject, [responseObject objectForKey:@"retMsg"]);
          }
      } failure:^(NSURLSessionDataTask *task, NSError *error) {
          callback(-1, nil, NET_ERROR_MSG);
      }];
}


+(void)xt_login:(NSNumber *)loginType
         mobile:(NSString *)mobile
         openId:(NSString *)openId
        smsCode:(NSString *)smsCode
       password:(NSString *)password
       callback:(nullable void (^)(NSInteger status, id _Nullable responseObject, NSString* _Nullable msg))callback
{
    NSString *url = @"http://test-xt-api.cyoulive.cn/api/login";//[NSString stringWithFormat:@"%@%@/%@", @"http://test-xt-api.cyoulive.cn/",@"api",@"login"];
    
    NSMutableDictionary * parameter = [[NSMutableDictionary alloc] init];
    [parameter setObject:[Usually getobjectForKey:loginType] forKey:@"loginType"];
    [parameter setObject:[Usually getobjectForKey:mobile] forKey:@"mobile"];
    [parameter setObject:[Usually getobjectForKey:openId] forKey:@"openId"];
    [parameter setObject:[Usually getobjectForKey:smsCode] forKey:@"smsCode"];
    [parameter setObject:[Usually getobjectForKey:password] forKey:@"password"];
    
    [HTTPModel POST:url parameters:parameter progress:^(NSProgress * progress) {
        
    } success:^(NSURLSessionDataTask *task, id responseObject) {
        if ([responseObject valueForKey:@"data"]) {
            callback([[responseObject valueForKey:@"retCode"] integerValue], responseObject, [responseObject objectForKey:@"retMsg"]);
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        callback(-1, nil, NET_ERROR_MSG);
    }];
}




@end
















