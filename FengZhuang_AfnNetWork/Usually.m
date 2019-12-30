//
//  Usually.m
//  XiTang
//
//  Created by 唐蒙波 on 2019/11/21.
//  Copyright © 2019 Meng. All rights reserved.
//

#import "Usually.h"
#import <sys/utsname.h>

//当前设置的宽、高
#define Kuan_Width [UIScreen mainScreen].bounds.size.width
#define Gao_HEIGHT [UIScreen mainScreen].bounds.size.height

#define BL_Kuan [UIScreen mainScreen].bounds.size.width/375
#define BL_Gao  [UIScreen mainScreen].bounds.size.height/667

//设置颜色值
#define UIColor(r,g,b) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(1.0)]
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]




@implementation Usually

+ (BOOL)strNilOrEmpty:(NSString *)string
{
    if ([string isKindOfClass:[NSString class]])
    {
        if (string.length > 0)
        {
            return NO;
        }
        else
        {
            return YES;
        }
    }
    else
    {
        return YES;
    }
}

+ (NSString*)getDateStringByFormateString:(NSString*)formateString date:(NSDate*)date{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:formateString];
    NSString *strDate = [formatter stringFromDate:date];
    return strDate;
}

+(NSString *)getTimestamp:(NSDate *)date
{
    NSString *timeString = @"";
    if([date isKindOfClass:[NSDate class]])
    {
      timeString = [NSString stringWithFormat:@"%ld",(long)[date timeIntervalSince1970]];
    }
    return timeString;
}

//图片缩放到指定大小尺寸
+(UIImage *)scaleToSize:(UIImage *)img size:(CGSize)size
{
    CGSize imgsize =size;
    
    UIGraphicsBeginImageContext(imgsize);
    [img drawInRect:CGRectMake(0, 0, imgsize.width, imgsize.height)];
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return scaledImage;
}
+ (BOOL) isValidString:(id)input
{
    if (!input) {
        return NO;
    }
    if(input==nil)
    {
        return NO;
    }
    if([input isKindOfClass:[NSNull class]])
    {
        return NO;
    }
    if ((NSNull *)input == [NSNull null]) {
        return NO;
    }
    if (![input isKindOfClass:[NSString class]]) {
        return NO;
    }
    if ([input isEqualToString:@""]) {
        return NO;
    }
    return YES;
}

+ (BOOL) isValidDictionary:(id)input
{
    if (!input) {
        return NO;
    }
    if ((NSNull *)input == [NSNull null]) {
        return NO;
    }
    if (![input isKindOfClass:[NSDictionary class]]) {
        return NO;
    }
    if ([input count] <= 0) {
        return NO;
    }
    return YES;
}

+ (BOOL) isValidArray:(id)input
{
    if (!input) {
        return NO;
    }
    if ((NSNull *)input == [NSNull null]) {
        return NO;
    }
    if (![input isKindOfClass:[NSArray class]]) {
        return NO;
    }
    if ([input count] <= 0) {
        return NO;
    }
    return YES;
}

+(NSString *)getUpdateStatusStr
{
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    NSString * status = [defaults objectForKey:@"AnchorOrUser"];
    return status;
}

+(NSString *)getNowUserID {
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    NSDictionary * userInfo = [defaults objectForKey:USERINFO];
    return [userInfo objectForKey:@"userId"];
}


+(NSString *)getCurrentUserName {
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    NSDictionary * userInfo = [defaults objectForKey:USERINFO];
    return [userInfo objectForKey:@"nickName"];
}
+(NSString *)getCurrentUserSex
{
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    NSDictionary * userInfo = [defaults objectForKey:USERINFO];
    return [userInfo objectForKey:@"sex"];

}
+(NSString *)getCurrentUserAnchorType
{
    NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
    NSDictionary * info = [userDefaults objectForKey:USERINFO];
    NSNumber * numberType = [info objectForKey:@"accountType"];
    NSString * typeStr = [NSString stringWithFormat:@"%d",numberType.intValue];
    return typeStr;
}
+(NSString *)getCurrentAvatarpath {
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    NSDictionary * userInfo = [defaults objectForKey:USERINFO];
    return [userInfo objectForKey:@"avatarUrl"];
}
+(NSString *)getVIPStatus{
    
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    NSDictionary * userInfo = [defaults objectForKey:USERINFO];
    return [userInfo objectForKey:@"isVip"];

}
+(NSString *)getRoleStatus
{
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    NSDictionary * userInfo = [defaults objectForKey:USERINFO];
    return [userInfo objectForKey:@"role"];

}

//较验用户名
+ (BOOL)validateUserName:(NSString*)number {
    BOOL res = YES;
    if(![Usually isValidString:number])
        return NO;
    
    NSCharacterSet* tmpSet = [NSCharacterSet characterSetWithCharactersInString:@"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"];
    int i = 0;
    while (i < number.length) {
        NSString * string = [number substringWithRange:NSMakeRange(i, 1)];
        NSRange range = [string rangeOfCharacterFromSet:tmpSet];
        if (range.length == 0) {
            res = NO;
            break;
        }
        i++;
    }
    return res;
}

+(CGSize)setSize:(NSString *)message withCGSize:(CGSize)cgsize  withFontSize:(float)fontSize
{

    
    CGSize  size = [message boundingRectWithSize:cgsize  options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:fontSize]} context:nil].size;
    return size;
}



//+(UIImage *)generateImageForGalleryWithImage:(UIImage *)image
//{
//    UIImageView *tmpImageView = [[UIImageView alloc] initWithImage:image];
//    tmpImageView.frame                  = CGRectMake(0.0f, 0.0f, image.size.width, image.size.width);
//    tmpImageView.layer.borderColor      = [UIColor whiteColor].CGColor;
//    tmpImageView.layer.borderWidth      = 0.0;
//    tmpImageView.layer.shouldRasterize  = YES;
//
//    UIImage *tmpImage   = [UIImage imageFromView:tmpImageView];
//
//    return [tmpImage transparentBorderImage:1.0f];
//}

+(NSString *)getobjectForKey:(id)object
{
    NSString *temp = @"";
    if(object  && ![object isEqual:[NSNull class]] &&![object isEqual:[NSNull null]])
    {
        temp = object;
    }
    return temp;
}
+(NSString *)getStringForLong:(id)object
{
    NSNumber * number = object;
    
    return [NSString stringWithFormat:@"%d",number.intValue];
}
+(NSString *)getReadableDateFromTimestamp:(NSString *)stamp
{
    NSString *_timestamp;
    
    NSTimeInterval createdAt = [stamp doubleValue];
    
    // Calculate distance time string
    time_t now;
    time(&now);
    
    int distance = (int)difftime(now, createdAt);  // createdAt
    if (distance < 0) distance = 0;
    
    if (distance < 30) {
        _timestamp = @"刚刚";
    }
    else if (distance < 60) {
        _timestamp = [NSString stringWithFormat:@"%d%@", distance, (distance == 1) ? @"秒前" : @"秒前"];
    }
    else if (distance < 60 * 60) {
        distance = distance / 60;
        _timestamp = [NSString stringWithFormat:@"%d%@", distance, (distance == 1) ? @"分钟前" : @"分钟前"];
    }
    else if (distance < 60 * 60 * 24) {
        distance = distance / 60 / 60;
        _timestamp = [NSString stringWithFormat:@"%d%@", distance, (distance == 1) ? @"小时前" : @"小时前"];
    }
    else if (distance < 60 * 60 * 24 * 7) {
        distance = ((distance / 60 / 60 / 24) + ((distance % (60 * 60 * 24))>0?1:0));
        if (distance == 1) {
            _timestamp = @"昨天";
        } else if (distance == 2) {
            _timestamp = @"前天";
        } else {
            _timestamp = [NSString stringWithFormat:@"%d%@", distance, (distance == 1) ? @"天前" : @"天前"];
        }
    }
    else if (distance < 60 * 60 * 24 * 7 * 4) {
        distance = distance / 60 / 60 / 24 / 7;
        _timestamp = [NSString stringWithFormat:@"%d%@", distance, (distance == 1) ? @"周前" : @"周前"];
    }
    else {
        static NSDateFormatter *dateFormatter = nil;
        if (dateFormatter == nil) {
            [NSDateFormatter setDefaultFormatterBehavior:NSDateFormatterBehaviorDefault];
            dateFormatter = [[NSDateFormatter alloc] init];
            [dateFormatter setDateFormat:@"yy-MM-dd"];
        }
        NSDate *date = [NSDate dateWithTimeIntervalSince1970:createdAt];
        _timestamp = [dateFormatter stringFromDate:date];
    }
    
    return _timestamp;
}
+(NSString *)getMessageReadableDateFromTimestamp:(NSString *)stamp
{
    NSString *_timestamp;
    
    NSTimeInterval createdAt = [stamp doubleValue];
    
    // Calculate distance time string
    time_t now;
    time(&now);
    
    int distance = (int)difftime(now, createdAt);  // createdAt
    if (distance < 0) distance = 0;
    
    if (distance < 60 * 60 * 24) {
        
        static NSDateFormatter *dateFormatter = nil;
        if (dateFormatter == nil) {
            [NSDateFormatter setDefaultFormatterBehavior:NSDateFormatterBehaviorDefault];
            dateFormatter = [[NSDateFormatter alloc] init];
            [dateFormatter setDateFormat:@"HH:mm"];
        }
        NSDate *date = [NSDate dateWithTimeIntervalSince1970:createdAt];
        _timestamp = [dateFormatter stringFromDate:date];

    }
   
    else if (distance < 60 * 60 * 24 * 7) {
        distance = ((distance / 60 / 60 / 24) + ((distance % (60 * 60 * 24))>0?1:0));
        if (distance == 1) {
            
            static NSDateFormatter *dateFormatter = nil;
            if (dateFormatter == nil) {
                [NSDateFormatter setDefaultFormatterBehavior:NSDateFormatterBehaviorDefault];
                dateFormatter = [[NSDateFormatter alloc] init];
                [dateFormatter setDateFormat:@"HH:mm"];
            }
            NSDate *date = [NSDate dateWithTimeIntervalSince1970:createdAt];
            _timestamp = [NSString stringWithFormat:@"昨天 %@",[dateFormatter stringFromDate:date] ];

            
        } else if (distance == 2) {
            
            static NSDateFormatter *dateFormatter = nil;
            if (dateFormatter == nil) {
                [NSDateFormatter setDefaultFormatterBehavior:NSDateFormatterBehaviorDefault];
                dateFormatter = [[NSDateFormatter alloc] init];
                [dateFormatter setDateFormat:@"HH:mm"];
            }
            NSDate *date = [NSDate dateWithTimeIntervalSince1970:createdAt];
            _timestamp = [NSString stringWithFormat:@"前天 %@",[dateFormatter stringFromDate:date] ];

        } else {
            static NSDateFormatter *dateFormatter = nil;
            if (dateFormatter == nil) {
                [NSDateFormatter setDefaultFormatterBehavior:NSDateFormatterBehaviorDefault];
                dateFormatter = [[NSDateFormatter alloc] init];
                [dateFormatter setDateFormat:@"yy-MM-dd HH:mm"];
            }
            NSDate *date = [NSDate dateWithTimeIntervalSince1970:createdAt];
            _timestamp = [dateFormatter stringFromDate:date];

        }
    }
    else {
        static NSDateFormatter *dateFormatter = nil;
        if (dateFormatter == nil) {
            [NSDateFormatter setDefaultFormatterBehavior:NSDateFormatterBehaviorDefault];
            dateFormatter = [[NSDateFormatter alloc] init];
            [dateFormatter setDateFormat:@"yy-MM-dd HH:mm"];
        }
        NSDate *date = [NSDate dateWithTimeIntervalSince1970:createdAt];
        _timestamp = [dateFormatter stringFromDate:date];
    }
    
    return _timestamp;
}
+(NSString*)uuid
{
    NSString *chars=@"abcdefghijklmnopgrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
    assert(chars.length==62);
    int len=chars.length;
    NSMutableString* result=[[NSMutableString alloc] init];
    for(int i=0;i<24;i++){
        int p=arc4random_uniform(len);
        NSRange range=NSMakeRange(p, 1);
        [result appendString:[chars substringWithRange:range]];
    }
    return result;
}

#pragma mark - time

+(UIButton * )showToastView:(NSString *)message view:(UIView *)view;
{
    CGSize oneLineSize = [Usually setSize:message withCGSize:CGSizeMake(Kuan_Width, Gao_HEIGHT) withFontSize:12];

    UIButton * tipButton = [[UIButton alloc] initWithFrame:CGRectMake((Kuan_Width-oneLineSize.width-20)/2,(Gao_HEIGHT-40*BL_Kuan)/2, oneLineSize.width+20, 40)];
    tipButton.enabled = NO;
    tipButton.alpha = 0.8;
    tipButton.layer.cornerRadius = 20;
    tipButton.backgroundColor = [UIColor blackColor];
    [tipButton setTitle:message forState:UIControlStateNormal];
    [tipButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    tipButton.titleLabel.font = [UIFont systemFontOfSize:12];
    tipButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    [view addSubview:tipButton];
    
    [UIView animateWithDuration:3 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
        
        tipButton.alpha = 0;
        
    } completion:^(BOOL finished) {
        
        [tipButton removeFromSuperview];
    }];
    
    return tipButton;
}

//发布时间与当前时间的间隔
+ (NSString *)intervalSinceNow: (NSDate *) theDate
{
    
    NSTimeInterval late=[theDate timeIntervalSince1970]*1;
    
    
    NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval now=[dat timeIntervalSince1970]*1;
    NSString *timeString=@"NO";
    
    NSTimeInterval cha=now-late;
    if (cha/60>2)
    {
    
        timeString=@"YES";
        
    }
    return timeString;
}

+ (NSString*)getDeviceType
{
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString *device = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
    return device;
}

//获取图片格式
+(NSString *)contentTypeForImageData:(NSData *)data {
    
    uint8_t c;
    
    [data getBytes:&c length:1];
    
    switch (c) {
            
        case 0xFF:
            
            return @"jpeg";
            
        case 0x89:
            
            return @"png";
            
        case 0x47:
            
            return @"gif";
            
        case 0x49:
            
        case 0x4D:
            
            return @"tiff";
            
        case 0x52:
            
            if ([data length] < 12) {
                
                return nil;
                
            }
            
            NSString *testString = [[NSString alloc] initWithData:[data subdataWithRange:NSMakeRange(0, 12)] encoding:NSASCIIStringEncoding];
            
            if(testString!=nil && ![testString isKindOfClass:[NSNull class]])
            {
            if ([testString hasPrefix:@"RIFF"] && [testString hasSuffix:@"WEBP"]) {
                
                return @"webp";
                
            }
            }
            
            return nil;
            
    }
    
    return nil;
    
}
+(void)shakeAnimationForView:(UIView *) view
{
    // 获取到当前的View
    
    CALayer *viewLayer = view.layer;
    
    // 获取当前View的位置
    
    CGPoint position = viewLayer.position;
    
    // 移动的两个终点位置
    
    CGPoint x = CGPointMake(position.x + 15, position.y);
    
    CGPoint y = CGPointMake(position.x - 15, position.y);
    
    // 设置动画
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"position"];
    
    // 设置运动形式
    
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault]];
    
    // 设置开始位置
    
    [animation setFromValue:[NSValue valueWithCGPoint:x]];
    
    // 设置结束位置
    
    [animation setToValue:[NSValue valueWithCGPoint:y]];
    
    // 设置自动反转
    
    [animation setAutoreverses:YES];
    
    // 设置时间
    
    [animation setDuration:.06];
    
    // 设置次数
    
    [animation setRepeatCount:5];
    
    // 添加上动画
    
    [viewLayer addAnimation:animation forKey:nil];
    
    
    
}
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString
{
    if (jsonString == nil) {
        return nil;
    }
    
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    if(err)
    {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return dic;
}

+(NSString *)getBenZhouYiShiJian:(NSString *)whichDay
{
    NSDate *now = [NSDate date];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *comp = [calendar components:NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit|NSWeekdayCalendarUnit|NSDayCalendarUnit
                                         fromDate:now];
    // 得到星期几
    // 1(星期天) 2(星期二) 3(星期三) 4(星期四) 5(星期五) 6(星期六) 7(星期天)
    NSInteger weekDay = [comp weekday];
    // 得到几号
    NSInteger day = [comp day];
    
    NSLog(@"weekDay:%ld   day:%ld",weekDay,day);
    
    // 计算当前日期和这周的星期一和星期天差的天数
    long firstDiff,lastDiff;
    if (weekDay == 1) {
        firstDiff = 1;
        lastDiff = 0;
    }else{
        firstDiff = [calendar firstWeekday] - weekDay;
        lastDiff = 9 - weekDay;
    }
    
    NSLog(@"firstDiff:%ld   lastDiff:%ld",firstDiff,lastDiff);
    
    // 在当前日期(去掉了时分秒)基础上加上差的天数
    NSDateComponents *firstDayComp = [calendar components:NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit fromDate:now];
    [firstDayComp setDay:day + firstDiff];
    NSDate *firstDayOfWeek= [calendar dateFromComponents:firstDayComp];
    
    NSDateComponents *lastDayComp = [calendar components:NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit fromDate:now];
    [lastDayComp setDay:day + lastDiff];
    NSDate *lastDayOfWeek= [calendar dateFromComponents:lastDayComp];
    
    NSDateFormatter *formater = [[NSDateFormatter alloc] init];
    [formater setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSLog(@"星期一开始 %@",[formater stringFromDate:firstDayOfWeek]);
    NSLog(@"当前 %@",[formater stringFromDate:now]);
    NSLog(@"星期天结束 %@",[formater stringFromDate:lastDayOfWeek]);
    
    
    if ([@"zhouYi" isEqualToString:whichDay]) {
        
        return [formater stringFromDate:firstDayOfWeek];
        
    }
    else if([@"jinTian" isEqualToString:whichDay])
    {
        return [formater stringFromDate:now];
    }
    else
    {
        [formater setDateFormat:@"yyyy-MM-dd "];
        [formater stringFromDate:now];
        
        NSString * nowStr = [formater stringFromDate:now];
        
        return [nowStr stringByAppendingString:@"00:00:00"];
    }
    
}
+(NSString *)convertToJsonData:(NSDictionary *)dict

{
    NSError *error;
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:&error];
    
    NSString *jsonString;
    
    if (!jsonData) {
        
        NSLog(@"%@",error);
        
    }else{
        
        jsonString = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
        
    }
    
    NSMutableString *mutStr = [NSMutableString stringWithString:jsonString];
    
    NSRange range = {0,jsonString.length};
    
    //去掉字符串中的空格
    
    [mutStr replaceOccurrencesOfString:@" " withString:@"" options:NSLiteralSearch range:range];
    
    NSRange range2 = {0,mutStr.length};
    
    //去掉字符串中的换行符
    
    [mutStr replaceOccurrencesOfString:@"\n" withString:@"" options:NSLiteralSearch range:range2];
    
    return mutStr;
    
}
//判断字符串是否为空或全是空格
+ (BOOL) isEmpty:(NSString *) str {
    
    if(!str) {
        
        return true;
        
    }else {
        NSCharacterSet *set = [NSCharacterSet whitespaceAndNewlineCharacterSet];
        
        NSString *trimedString = [str stringByTrimmingCharactersInSet:set];
        
        
        if([trimedString length] == 0) {
            
            return true;
            
            
        }else {
            
            
            return false;
            
            
        }
        
    }
    
    
}

+(NSString *)shiJianDistanceAlsoDaYu3Days:(NSString *)timestamp distance:(int)timeDistance;
{
    
    NSTimeInterval createdAt = [timestamp doubleValue];
    
    // Calculate distance time string
    time_t now;
    time(&now);
    
    int distance = (int)difftime(now, createdAt);  // createdAt
   if (distance >= 60 * 60 * 24 * timeDistance)
   {
       return @"大于3天";
   }
    else
    {
        return @"小于3天";
    }
}
+(NSString *)shiJianDistanceAlsoDaYu5Minutes:(NSString *)timestamp distance:(int)timeDistance;
{
    
    NSTimeInterval createdAt = [timestamp doubleValue];
    
    // Calculate distance time string
    time_t now;
    time(&now);
    
    int distance = (int)difftime(now, createdAt);  // createdAt
    if (distance >= 60 * timeDistance)
    {
        return @"大于5分钟";
    }
    else
    {
        return @"小于5分钟";
    }
}
//获取ip和地理位置信息以及国家名
+(NSDictionary *)getWANIP

{
 
        //通过淘宝的服务来定位WAN的IP，否则获取路由IP没什么用
        NSUserDefaults * getIpParameterDefaults = [NSUserDefaults standardUserDefaults];
        NSString * ipPathStr = [getIpParameterDefaults objectForKey:@"getIpParameterDefaultsKey"];
        
        NSURL *ipURL =  [NSURL URLWithString:ipPathStr];
        NSData *data = [NSData dataWithContentsOfURL:ipURL];
        NSDictionary *ipDic;
        if(data)
        {
            ipDic  = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        }
        
        NSDictionary * dic = [ipDic objectForKey:@"data"];
        
        return dic;
    
    
}
+(NSDictionary *)deviceWANIPAdress{
    

        NSError *error;
        
        NSUserDefaults * getIpParameterDefaults = [NSUserDefaults standardUserDefaults];
        NSString * ipPathStr = [getIpParameterDefaults objectForKey:@"getIpParameterDefaultsKey"];
        
        NSURL *ipURL = [NSURL URLWithString:ipPathStr]; //  http://pv.sohu.com/cityjson?ie=utf-8
        
        NSMutableString *ip = [NSMutableString stringWithContentsOfURL:ipURL encoding:NSUTF8StringEncoding error:&error];
        
        //判断返回字符串是否为所需数据
        
        if ([ip hasPrefix:@"var returnCitySN = "]) {
            
            //对字符串进行处理，然后进行json解析
            //删除字符串多余字符串
            
            NSRange range = NSMakeRange(0, 19);
            
            [ip deleteCharactersInRange:range];
            
            NSString * nowIp =[ip substringToIndex:ip.length-1];
            
            //将字符串转换成二进制进行Json解析
            
            NSData * data = [nowIp dataUsingEncoding:NSUTF8StringEncoding];
            
            NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            
            return dict;
            
        }
    
        return nil;
    
}


+(void)showMessageLoadView:(NSString *)message vc:(UIViewController *)vc
{
    UIView * loadingBottomView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Kuan_Width, Gao_HEIGHT)];
    loadingBottomView.backgroundColor = [UIColor clearColor];
    loadingBottomView.tag = -1332569;
    [vc.view addSubview:loadingBottomView];
    
    UIView * loadingBottomAlphaView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Kuan_Width, Gao_HEIGHT)];
    loadingBottomAlphaView.backgroundColor = [UIColor blackColor];
    loadingBottomAlphaView.alpha = 0.5;
    [loadingBottomView addSubview:loadingBottomAlphaView];
    
    UIView * loadingView = [[UIView alloc] initWithFrame:CGRectMake((Kuan_Width-200)/2, (Gao_HEIGHT-60-80)/2, 200, 70)];
    loadingView.backgroundColor = [UIColor blackColor];
    loadingView.layer.cornerRadius = 10;
    loadingView.alpha = 0.8;
    [loadingBottomView addSubview:loadingView];
    
    UIActivityIndicatorView * activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    [activityView startAnimating];
    activityView.frame = CGRectMake(20, 25, 20, 20);
    [loadingView addSubview:activityView];
    
    UILabel * tipLable = [[UILabel alloc] initWithFrame:CGRectMake(60, 0, 300, 70)];
    tipLable.text = [NSString stringWithFormat:@"%@",message];
    tipLable.textColor = [UIColor whiteColor];
    tipLable.font = [UIFont systemFontOfSize:15];
    [loadingView addSubview:tipLable];
}

//创建时间与当前时间的间隔
+(int)getTimeDistanceSinceNow:(NSString *)timeStr
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"YYYYMMddHHmmss"];
    NSDate * sinceDate = [dateFormatter dateFromString:timeStr];
    
    NSTimeInterval late=[sinceDate timeIntervalSince1970]*1;
    
    
    NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval now=[dat timeIntervalSince1970]*1;
    
    NSTimeInterval cha=now-late;
    
    return (int)cha;
}

+(int)getAgeByBirthdayStr:(NSString *)birth
{
    int age = 0;
    
    if(birth!=nil&&birth.length>0)
    {
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
        [dateFormatter setDateFormat:@"yyyyMMdd"];
        //生日
        NSDate *birthDay = [dateFormatter dateFromString:birth];
        //当前时间
        NSString *currentDateStr = [dateFormatter stringFromDate:[NSDate date]];
        NSDate *currentDate = [dateFormatter dateFromString:currentDateStr];
        
        NSTimeInterval time=[currentDate timeIntervalSinceDate:birthDay];
        age = ((int)time)/(3600*24*365);
    }
    return age;
}
//获取当前用户关注的用户的id列表
+(NSMutableArray *)getGuanZhuIdList
{
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    NSMutableArray * guanZhuList = [defaults objectForKey:@"userGuanZhuList"];
    if (guanZhuList==nil) {
        
        guanZhuList = [NSMutableArray array];
    }
    return guanZhuList;
}
+(NSDictionary *)getAuthentication
{
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    return [defaults objectForKey:@"DefaultsAuthentication"];
    
}
//获取根据文字自适应高度的lable
+(UILabel *)getLableByContenMessage:(NSString *)contenStr textFont:(float)textFont lineSpacing:(float )lineSpacing lableFrame:(CGRect)lableFrame
{
    UILabel * describleLable = [[UILabel alloc] initWithFrame:CGRectMake(lableFrame.origin.x, lableFrame.origin.y, lableFrame.size.width, 0)];
    describleLable.backgroundColor = [UIColor clearColor];
    describleLable.font = [UIFont systemFontOfSize:textFont];
    describleLable.numberOfLines = 0;
    
    //lable中要显示的文字
    NSString * describle =contenStr;
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:describle];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    //调整行间距
    [paragraphStyle setLineSpacing:lineSpacing];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [describle length])];
    if ([contenStr containsString:@"香芋倡导绿色、文明的社交环境，涉及政治、色情、低俗、暴力及未成年人等违法不良信息将被封号。共建文明社区，从你我做起。"])
    {
        describleLable.textColor = UIColorFromRGB(0xFFCF00);
        
        [attributedString addAttribute:NSForegroundColorAttributeName
                                 value:[UIColor redColor]
                                 range:NSMakeRange(0, 7)];
        
    }
    describleLable.attributedText = attributedString;
    //设置自适应
    [describleLable sizeToFit];
    
    
    return describleLable;
}
+(void)uploadGuanZhuIdList:(NSMutableArray *)guanZhuList
{
    
    if ([guanZhuList isKindOfClass:[NSArray class]]&&guanZhuList!=nil) {
        
        NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
        [defaults setObject:[Usually removeNullFromArray:guanZhuList] forKey:@"userGuanZhuList"];
        [defaults synchronize];
        
    }
    
}
// 删除NSArray中的NSNull
+ (NSMutableArray *)removeNullFromArray:(NSArray *)arr
{
    NSMutableArray *marr = [NSMutableArray array];
    for (int i = 0; i < arr.count; i++) {
        NSValue *value = arr[i];
        // 删除NSDictionary中的NSNull，再添加进数组
        if ([value isKindOfClass:NSDictionary.class]) {
            [marr addObject:[Usually removeNullFromDictionary:(NSDictionary *)value]];
        }
        // 删除NSArray中的NSNull，再添加进数组
        else if ([value isKindOfClass:NSArray.class]) {
            [marr addObject:[self removeNullFromArray:(NSArray *)value]];
        }
        // 剩余的非NSNull类型的数据添加进数组
        else if (![value isKindOfClass:NSNull.class]) {
            [marr addObject:value];
        }
    }
    return marr;
    
}
// 删除Dictionary中的NSNull
+ (NSMutableDictionary *)removeNullFromDictionary:(NSDictionary *)dic
{
    NSMutableDictionary *mdic = [NSMutableDictionary dictionary];
    for (NSString *strKey in dic.allKeys) {
        NSValue *value = dic[strKey];
        // 删除NSDictionary中的NSNull，再保存进字典
        if ([value isKindOfClass:NSDictionary.class]) {
            mdic[strKey] = [self removeNullFromDictionary:(NSDictionary *)value];
        }
        // 删除NSArray中的NSNull，再保存进字典
        else if ([value isKindOfClass:NSArray.class]) {
            mdic[strKey] = [Usually removeNullFromArray:(NSArray *)value];
        }
        // 剩余的非NSNull类型的数据保存进字典
        else if (![value isKindOfClass:NSNull.class]) {
            mdic[strKey] = dic[strKey];
        }
    }
    return mdic;
}
+(NSString *)getCurrentSex
{
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    NSDictionary * userInfo = [defaults objectForKey:USERINFO];
    NSNumber * sexNumber = [userInfo objectForKey:@"sex"];
    return [NSString stringWithFormat:@"%d",sexNumber.intValue];
    
}
+(NSString *)getRenQiAR
{
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    NSDictionary * userInfo = [defaults objectForKey:USERINFO];
    NSNumber * arNumber = [userInfo objectForKey:@"ar"];
    return [NSString stringWithFormat:@"%d",arNumber.intValue];
    
}
+(NSString *)getSignature
{
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    NSDictionary * userInfo = [defaults objectForKey:USERINFO];
    return [userInfo objectForKey:@"signature"];
    
}
+(NSString *)getBirthday
{
    
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    NSDictionary * userInfo = [defaults objectForKey:USERINFO];
    return [userInfo objectForKey:@"birthday"];
    
}
+(NSString *)getCityName
{
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    NSDictionary * userInfo = [defaults objectForKey:USERINFO];
    return [userInfo objectForKey:@"cityName"];
    
}
/**
 *  返回截取到的图片
 *
 *  @return UIImage *
 */
+ (UIImage *)imageWithScreenshot
{
    NSData *imageData = [Usually dataWithScreenshotInPNGFormat];
    return [UIImage imageWithData:imageData];
}
//截取当前屏幕内容 将以下代码粘贴复制 直接调用imageWithScreenshot方法
/**
 *  截取当前屏幕
 *
 *  @return NSData *
 */
+ (NSData *)dataWithScreenshotInPNGFormat
{
    CGSize imageSize = CGSizeZero;
    UIInterfaceOrientation orientation = [UIApplication sharedApplication].statusBarOrientation;
    if (UIInterfaceOrientationIsPortrait(orientation))
        imageSize = [UIScreen mainScreen].bounds.size;
    else
        imageSize = CGSizeMake([UIScreen mainScreen].bounds.size.height, [UIScreen mainScreen].bounds.size.width);
    
    UIGraphicsBeginImageContextWithOptions(imageSize, NO, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    for (UIWindow *window in [[UIApplication sharedApplication] windows])
    {
        CGContextSaveGState(context);
        CGContextTranslateCTM(context, window.center.x, window.center.y);
        CGContextConcatCTM(context, window.transform);
        CGContextTranslateCTM(context, -window.bounds.size.width * window.layer.anchorPoint.x, -window.bounds.size.height * window.layer.anchorPoint.y);
        if (orientation == UIInterfaceOrientationLandscapeLeft)
        {
            CGContextRotateCTM(context, M_PI_2);
            CGContextTranslateCTM(context, 0, -imageSize.width);
        }
        else if (orientation == UIInterfaceOrientationLandscapeRight)
        {
            CGContextRotateCTM(context, -M_PI_2);
            CGContextTranslateCTM(context, -imageSize.height, 0);
        } else if (orientation == UIInterfaceOrientationPortraitUpsideDown) {
            CGContextRotateCTM(context, M_PI);
            CGContextTranslateCTM(context, -imageSize.width, -imageSize.height);
        }
        if ([window respondsToSelector:@selector(drawViewHierarchyInRect:afterScreenUpdates:)])
        {
            [window drawViewHierarchyInRect:window.bounds afterScreenUpdates:YES];
        }
        else
        {
            [window.layer renderInContext:context];
        }
        CGContextRestoreGState(context);
    }
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return UIImagePNGRepresentation(image);
}
//图片合成
+ (UIImage *)composeImg :(UIImage *)bottomImage topImage:(UIImage *)topImage hcImageWidth:(float)hcImageWidth  hcImageHeight:(float)hcImageHeight hcFrame:(CGRect)hcFrame{
    
    //以1.png的图大小为画布创建上下文
    UIGraphicsBeginImageContext(CGSizeMake(hcImageWidth*4, hcImageHeight*4)); //*4是为了保持清晰度
    [bottomImage drawInRect:CGRectMake(0, 0, hcImageWidth*4, hcImageHeight*4)];//先把1.png 画到上下文中
    [topImage drawInRect:hcFrame];//再把小图放在上下文中
    UIImage *resultImg = UIGraphicsGetImageFromCurrentImageContext();//从当前上下文中获得最终图片
    UIGraphicsEndImageContext();//关闭上下文
    return resultImg;
}
//生成二维码
+(UIImage * )erweima :(NSString *)dingDanHao
{
    
    //二维码滤镜
    CIFilter *filter=[CIFilter filterWithName:@"CIQRCodeGenerator"];
    
    //恢复滤镜的默认属性
    
    [filter setDefaults];
    
    //将字符串转换成NSData
    
    NSData *data=[dingDanHao dataUsingEncoding:NSUTF8StringEncoding];
    
    //通过KVO设置滤镜inputmessage数据
    
    [filter setValue:data forKey:@"inputMessage"];
    
    //获得滤镜输出的图像
    
    CIImage *outputImage=[filter outputImage];
    
    //将CIImage转换成UIImage,并放大显示
    
    return [Usually createNonInterpolatedUIImageFormCIImage:outputImage withSize:100.0];
    
}
//改变二维码大小

+(UIImage *)createNonInterpolatedUIImageFormCIImage:(CIImage *)image withSize:(CGFloat) size {
    
    CGRect extent = CGRectIntegral(image.extent);
    
    CGFloat scale = MIN(size/CGRectGetWidth(extent), size/CGRectGetHeight(extent));
    
    // 创建bitmap;
    
    size_t width = CGRectGetWidth(extent) * scale;
    
    size_t height = CGRectGetHeight(extent) * scale;
    
    CGColorSpaceRef cs = CGColorSpaceCreateDeviceGray();
    
    CGContextRef bitmapRef = CGBitmapContextCreate(nil, width, height, 8, 0, cs, (CGBitmapInfo)kCGImageAlphaNone);
    
    CIContext *context = [CIContext contextWithOptions:nil];
    
    CGImageRef bitmapImage = [context createCGImage:image fromRect:extent];
    
    CGContextSetInterpolationQuality(bitmapRef, kCGInterpolationNone);
    
    CGContextScaleCTM(bitmapRef, scale, scale);
    
    CGContextDrawImage(bitmapRef, extent, bitmapImage);
    
    // 保存bitmap到图片
    
    CGImageRef scaledImage = CGBitmapContextCreateImage(bitmapRef);
    
    CGContextRelease(bitmapRef);
    
    CGImageRelease(bitmapImage);
    
    return [UIImage imageWithCGImage:scaledImage];
    
}
+ (UIImage *)image:(UIImage *)image rotation:(UIImageOrientation)orientation
{
    long double rotate = 0.0;
    CGRect rect;
    float translateX = 0;
    float translateY = 0;
    float scaleX = 1.0;
    float scaleY = 1.0;
    
    switch (orientation) {
        case UIImageOrientationLeft:
            rotate = M_PI_2;
            rect = CGRectMake(0, 0, image.size.height, image.size.width);
            translateX = 0;
            translateY = -rect.size.width;
            scaleY = rect.size.width/rect.size.height;
            scaleX = rect.size.height/rect.size.width;
            break;
        case UIImageOrientationRight:
            rotate = 3 * M_PI_2;
            rect = CGRectMake(0, 0, image.size.height, image.size.width);
            translateX = -rect.size.height;
            translateY = 0;
            scaleY = rect.size.width/rect.size.height;
            scaleX = rect.size.height/rect.size.width;
            break;
        case UIImageOrientationDown:
            rotate = M_PI;
            rect = CGRectMake(0, 0, image.size.width, image.size.height);
            translateX = -rect.size.width;
            translateY = -rect.size.height;
            break;
        default:
            rotate = 0.0;
            rect = CGRectMake(0, 0, image.size.width, image.size.height);
            translateX = 0;
            translateY = 0;
            break;
    }
    
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    //做CTM变换
    CGContextTranslateCTM(context, 0.0, rect.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    CGContextRotateCTM(context, rotate);
    CGContextTranslateCTM(context, translateX, translateY);
    
    CGContextScaleCTM(context, scaleX, scaleY);
    //绘制图片
    CGContextDrawImage(context, CGRectMake(0, 0, rect.size.width, rect.size.height), image.CGImage);
    
    UIImage *newPic = UIGraphicsGetImageFromCurrentImageContext();
    
    return newPic;
}
+(int)getEnvironment
{
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    if ([@"1" isEqualToString:[defaults objectForKey:@"environmentKey"]]) {
        
        return 1;
    }
    else
    {
        return 0;
    }
    
}

+ (UIViewController *)getCurrentVC {
    
    UIViewController *rootVC = [UIApplication sharedApplication].keyWindow.rootViewController;
    UIViewController *currentShowVC = [self recursiveFindCurrentShowViewControllerFromViewController:rootVC];
    
    return currentShowVC;
}
+ (UIViewController *)recursiveFindCurrentShowViewControllerFromViewController:(UIViewController *)fromVC
{
    
    if ([fromVC isKindOfClass:[UINavigationController class]]) {
        
        return [self recursiveFindCurrentShowViewControllerFromViewController:[((UINavigationController *)fromVC) visibleViewController]];
        
    } else if ([fromVC isKindOfClass:[UITabBarController class]]) {
        
        return [self recursiveFindCurrentShowViewControllerFromViewController:[((UITabBarController *)fromVC) selectedViewController]];
        
    } else {
        
        if (fromVC.presentedViewController) {
            
            return [self recursiveFindCurrentShowViewControllerFromViewController:fromVC.presentedViewController];
            
        } else {
            
            return fromVC;
            
        }
        
    }
    
}
+ (NSString *)getCurrentDeviceModel{
    
    struct utsname systemInfo;
    uname(&systemInfo);
    
    NSString *deviceModel = [NSString stringWithCString:systemInfo.machine encoding:NSASCIIStringEncoding];
    if ([deviceModel isEqualToString:@"iPhone3,1"])    return @"iPhone 4";
    if ([deviceModel isEqualToString:@"iPhone3,2"])    return @"iPhone 4";
    if ([deviceModel isEqualToString:@"iPhone3,3"])    return @"iPhone 4";
    if ([deviceModel isEqualToString:@"iPhone4,1"])    return @"iPhone 4S";
    if ([deviceModel isEqualToString:@"iPhone5,1"])    return @"iPhone 5";
    if ([deviceModel isEqualToString:@"iPhone5,2"])    return @"iPhone 5 (GSM+CDMA)";
    if ([deviceModel isEqualToString:@"iPhone5,3"])    return @"iPhone 5c (GSM)";
    if ([deviceModel isEqualToString:@"iPhone5,4"])    return @"iPhone 5c (GSM+CDMA)";
    if ([deviceModel isEqualToString:@"iPhone6,1"])    return @"iPhone 5s (GSM)";
    if ([deviceModel isEqualToString:@"iPhone6,2"])    return @"iPhone 5s (GSM+CDMA)";
    if ([deviceModel isEqualToString:@"iPhone7,1"])    return @"iPhone 6 Plus";
    if ([deviceModel isEqualToString:@"iPhone7,2"])    return @"iPhone 6";
    if ([deviceModel isEqualToString:@"iPhone8,1"])    return @"iPhone 6s";
    if ([deviceModel isEqualToString:@"iPhone8,2"])    return @"iPhone 6s Plus";
    if ([deviceModel isEqualToString:@"iPhone8,4"])    return @"iPhone SE";
    // 日行两款手机型号均为日本独占，可能使用索尼FeliCa支付方案而不是苹果支付
    if ([deviceModel isEqualToString:@"iPhone9,1"])    return @"iPhone 7";
    if ([deviceModel isEqualToString:@"iPhone9,2"])    return @"iPhone 7 Plus";
    if ([deviceModel isEqualToString:@"iPhone9,3"])    return @"iPhone 7";
    if ([deviceModel isEqualToString:@"iPhone9,4"])    return @"iPhone 7 Plus";
    if ([deviceModel isEqualToString:@"iPhone10,1"])   return @"iPhone_8";
    if ([deviceModel isEqualToString:@"iPhone10,4"])   return @"iPhone_8";
    if ([deviceModel isEqualToString:@"iPhone10,2"])   return @"iPhone_8_Plus";
    if ([deviceModel isEqualToString:@"iPhone10,5"])   return @"iPhone_8_Plus";
    if ([deviceModel isEqualToString:@"iPhone10,3"])   return @"iPhone X";
    if ([deviceModel isEqualToString:@"iPhone10,6"])   return @"iPhone X";
    if ([deviceModel isEqualToString:@"iPhone11,8"])   return @"iPhone XR";
    if ([deviceModel isEqualToString:@"iPhone11,2"])   return @"iPhone XS";
    if ([deviceModel isEqualToString:@"iPhone11,6"])   return @"iPhone XS Max";
    if ([deviceModel isEqualToString:@"iPhone11,4"])   return @"iPhone XS Max";
    if ([deviceModel isEqualToString:@"iPod1,1"])      return @"iPod Touch 1G";
    if ([deviceModel isEqualToString:@"iPod2,1"])      return @"iPod Touch 2G";
    if ([deviceModel isEqualToString:@"iPod3,1"])      return @"iPod Touch 3G";
    if ([deviceModel isEqualToString:@"iPod4,1"])      return @"iPod Touch 4G";
    if ([deviceModel isEqualToString:@"iPod5,1"])      return @"iPod Touch (5 Gen)";
    if ([deviceModel isEqualToString:@"iPad1,1"])      return @"iPad";
    if ([deviceModel isEqualToString:@"iPad1,2"])      return @"iPad 3G";
    if ([deviceModel isEqualToString:@"iPad2,1"])      return @"iPad 2 (WiFi)";
    if ([deviceModel isEqualToString:@"iPad2,2"])      return @"iPad 2";
    if ([deviceModel isEqualToString:@"iPad2,3"])      return @"iPad 2 (CDMA)";
    if ([deviceModel isEqualToString:@"iPad2,4"])      return @"iPad 2";
    if ([deviceModel isEqualToString:@"iPad2,5"])      return @"iPad Mini (WiFi)";
    if ([deviceModel isEqualToString:@"iPad2,6"])      return @"iPad Mini";
    if ([deviceModel isEqualToString:@"iPad2,7"])      return @"iPad Mini (GSM+CDMA)";
    if ([deviceModel isEqualToString:@"iPad3,1"])      return @"iPad 3 (WiFi)";
    if ([deviceModel isEqualToString:@"iPad3,2"])      return @"iPad 3 (GSM+CDMA)";
    if ([deviceModel isEqualToString:@"iPad3,3"])      return @"iPad 3";
    if ([deviceModel isEqualToString:@"iPad3,4"])      return @"iPad 4 (WiFi)";
    if ([deviceModel isEqualToString:@"iPad3,5"])      return @"iPad 4";
    if ([deviceModel isEqualToString:@"iPad3,6"])      return @"iPad 4 (GSM+CDMA)";
    if ([deviceModel isEqualToString:@"iPad4,1"])      return @"iPad Air (WiFi)";
    if ([deviceModel isEqualToString:@"iPad4,2"])      return @"iPad Air (Cellular)";
    if ([deviceModel isEqualToString:@"iPad4,4"])      return @"iPad Mini 2 (WiFi)";
    if ([deviceModel isEqualToString:@"iPad4,5"])      return @"iPad Mini 2 (Cellular)";
    if ([deviceModel isEqualToString:@"iPad4,6"])      return @"iPad Mini 2";
    if ([deviceModel isEqualToString:@"iPad4,7"])      return @"iPad Mini 3";
    if ([deviceModel isEqualToString:@"iPad4,8"])      return @"iPad Mini 3";
    if ([deviceModel isEqualToString:@"iPad4,9"])      return @"iPad Mini 3";
    if ([deviceModel isEqualToString:@"iPad5,1"])      return @"iPad Mini 4 (WiFi)";
    if ([deviceModel isEqualToString:@"iPad5,2"])      return @"iPad Mini 4 (LTE)";
    if ([deviceModel isEqualToString:@"iPad5,3"])      return @"iPad Air 2";
    if ([deviceModel isEqualToString:@"iPad5,4"])      return @"iPad Air 2";
    if ([deviceModel isEqualToString:@"iPad6,3"])      return @"iPad Pro 9.7";
    if ([deviceModel isEqualToString:@"iPad6,4"])      return @"iPad Pro 9.7";
    if ([deviceModel isEqualToString:@"iPad6,7"])      return @"iPad Pro 12.9";
    if ([deviceModel isEqualToString:@"iPad6,8"])      return @"iPad Pro 12.9";
    if ([deviceModel isEqualToString:@"AppleTV2,1"])      return @"Apple TV 2";
    if ([deviceModel isEqualToString:@"AppleTV3,1"])      return @"Apple TV 3";
    if ([deviceModel isEqualToString:@"AppleTV3,2"])      return @"Apple TV 3";
    if ([deviceModel isEqualToString:@"AppleTV5,3"])      return @"Apple TV 4";
    if ([deviceModel isEqualToString:@"i386"])         return @"Simulator";
    if ([deviceModel isEqualToString:@"x86_64"])       return @"Simulator";
    return deviceModel;
}


//
//+(BOOL)shuangXiangYanZheng:(NSDictionary *)info jsonStr:(NSString *)jsonStr
//{
//    /*
//     NSString *string = @"123";
//     NSString *sign = [RSA signSHA1WithRSA:string];
//     NSLog(@"签名----%@",sign);
//     NSLog(@"验签-----%d",[RSA verifySHA1WithRSA:string signature:sign]);
//     */
//    //sign节点对应的json字符串
//    if(![Usually isValidString:[info objectForKey:@"sign"]])
//    {
//        return NO;
//    }
//    NSString * signStr = [NSString stringWithFormat:@",\"sign\":\"%@\"",[info objectForKey:@"sign"]];
//    NSMutableString * jsonMutableStr = [[NSMutableString alloc] initWithString:jsonStr];
//    //通过匹配signStr删除掉原json中的sign节点
//    NSString * jsonDeleteSignStr = (NSString *)[jsonMutableStr stringByReplacingOccurrencesOfString:signStr withString:@""];
//    
//    NSString *deleteStr = jsonDeleteSignStr;
//    //去除deleteStr中的emoji
//    deleteStr = [self filterEmoji:jsonDeleteSignStr];
//    
//    //对删除掉sign节点和emoji的json字符串进行md5加密并加盐
//    NSString * qianMingStr = [[[deleteStr dataUsingEncoding:NSUTF8StringEncoding] md5Hash] stringByAppendingString:JiaYanStr];
//    //通过公钥字符串对sign进行解密并和 qianMingStr进行匹配
//    BOOL  alsoSuccess = [RSA verifySHA1WithRSA:qianMingStr signature:[info objectForKey:@"sign"]];
//    if(alsoSuccess)
//    {
//        return YES;
//    }
//    else
//    {
//        return NO;
//    }
//}
//去除字符串中的emoji
+ (NSString *)filterEmoji:(NSString *)str {
    
    //@"[^\\u0020-\\u007E\\u00A0-\\u00BE\\u2E80-\\uA4CF\\uF900-\\uFAFF\\uFE30-\\uFE4F\\uFF00-\\uFFEF\\u2000-\\u201f\r\n]"
    NSRegularExpression* expression = [NSRegularExpression regularExpressionWithPattern:@"[\\ud83c\\udc00-\\ud83c\\udfff]|[\\ud83d\\udc00-\\ud83d\\udfff]|[\\u2600-\\u27ff]" options:NSRegularExpressionCaseInsensitive error:nil];
    
    NSString* result = [expression stringByReplacingMatchesInString:str options:0 range:NSMakeRange(0, str.length) withTemplate:@""];
    
    return result;
}

+(void)setTextFieldPlaceholder:(NSString *)textStr placeHoldColor:(UIColor *)color textField:(UITextField *)textField
{
    NSMutableAttributedString * placeholderString = [[NSMutableAttributedString alloc] initWithString:textStr attributes:@{NSForegroundColorAttributeName :color}];
    textField.attributedPlaceholder = placeholderString;
}
+(NSString *)getCheckJBParameter
{
    return @"钻石";//[Usually getobjectForKey:[[NSUserDefaults standardUserDefaults] objectForKey:@"iosCheckJBParameter"]];
}
+(NSString *)getCheckFZParameter
{
    return [Usually getobjectForKey:[[NSUserDefaults standardUserDefaults] objectForKey:@"iosCheckFZParameter"]];
}
+(NSString *)getCheckCZParameter
{
    return [Usually getobjectForKey:[[NSUserDefaults standardUserDefaults] objectForKey:@"iosCheckCZParameter"]];
}
+(NSString *)getCheckYEParameter
{
    return [Usually getobjectForKey:[[NSUserDefaults standardUserDefaults] objectForKey:@"iosCheckYEParameter"]];
}

//动态点赞评论 好友 关注等消息存储

+(void)setRYMessage:(NSDictionary *)info defaultsKey:(NSString *)defaultsKey
{
    NSString * key = [NSString stringWithFormat:@"%@&%@",defaultsKey,[Usually getNowUserID]];
                              
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    
    NSArray * array = [defaults objectForKey:key];
    
    NSMutableArray * mutableArray;
    
    if ([Usually isValidArray:array]) {
       
       mutableArray  = [[NSMutableArray alloc] initWithArray:array];
    }
    else
    {
        mutableArray = [NSMutableArray array];
    }
    if([Usually isValidDictionary:info])
    {
         [mutableArray addObject:info];
    }
   
    NSSet * set = [NSSet setWithArray:mutableArray];
    array = [set allObjects];
    
    [defaults setObject:array forKey:key];
    [defaults synchronize];
  
}
+(void)removeRyMessageList:(NSString *)defaultsKey
{
    NSString * key = [NSString stringWithFormat:@"%@&%@",defaultsKey,[Usually getNowUserID]];

    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    [defaults removeObjectForKey:key];
    [defaults synchronize];
}
+(NSArray *)getRYMessageList:(NSString *)defaultsKey
{
    NSString * key = [NSString stringWithFormat:@"%@&%@",defaultsKey,[Usually getNowUserID]];
                              
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    
    NSMutableArray * array = [defaults objectForKey:key];
    if (![Usually isValidArray:array]) {
          
           array = [NSMutableArray array];
       }
    
    return array;

}



@end
