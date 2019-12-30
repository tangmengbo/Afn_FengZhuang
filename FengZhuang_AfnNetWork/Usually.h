//
//  Usually.h
//  XiTang
//
//  Created by 唐蒙波 on 2019/11/21.
//  Copyright © 2019 Meng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#define APPNAME @"kuaimao"
#define USERINFO @"USERINFO"
//appkey 签名用
#define APPKEY @"mImPJVmkkAjM1lYOvdInFw=="

NS_ASSUME_NONNULL_BEGIN

@interface Usually : NSObject

+ (BOOL)strNilOrEmpty:(NSString *)string;

+ (NSString*)getDateStringByFormateString:(NSString*)formateString date:(NSDate*)date;

+(NSString *)getTimestamp:(NSDate *)date;

//图片缩放到指定大小尺寸
+(UIImage *)scaleToSize:(UIImage *)img size:(CGSize)size;

+ (BOOL) isValidString:(id)input;

+ (BOOL) isValidDictionary:(id)input;

+ (BOOL) isValidArray:(id)input;

+(NSString *)getUpdateStatusStr;

+(NSString *)getNowUserID ;

+(NSString *)getCurrentUserName ;
+(NSString *)getCurrentUserSex;
+(NSString *)getCurrentUserAnchorType;
+(NSString *)getCurrentAvatarpath ;
+(NSString *)getVIPStatus;
+(NSString *)getRoleStatus;

//较验用户名
+ (BOOL)validateUserName:(NSString*)number ;

+(CGSize)setSize:(NSString *)message withCGSize:(CGSize)cgsize  withFontSize:(float)fontSize
;

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

+(NSString *)getobjectForKey:(id)object;

+(NSString *)getStringForLong:(id)object;

+(NSString *)getReadableDateFromTimestamp:(NSString *)stamp;

+(NSString *)getMessageReadableDateFromTimestamp:(NSString *)stamp;//消息列表时间展示
+(NSString*)uuid;

#pragma mark - time

+(UIButton * )showToastView:(NSString *)message view:(UIView *)view;

//发布时间与当前时间的间隔
+ (NSString *)intervalSinceNow: (NSDate *) theDate;
+ (NSString*)getDeviceType;
+(NSString *)netWorkState;
//获取图片格式
+(NSString *)contentTypeForImageData:(NSData *)data;
+(void)shakeAnimationForView:(UIView *) view;
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString;

+(NSString *)getBenZhouYiShiJian:(NSString *)whichDay;
+(NSString *)convertToJsonData:(NSDictionary *)dict;
//判断字符串是否为空或全是空格
+ (BOOL) isEmpty:(NSString *) str ;
//获取视频的第一帧
+ (UIImage*) getVideoPreViewImage:(NSURL *)path;
+(NSString *)shiJianDistanceAlsoDaYu3Days:(NSString *)timestamp distance:(int)timeDistance;
+(NSString *)shiJianDistanceAlsoDaYu5Minutes:(NSString *)timestamp distance:(int)timeDistance;
//获取ip和地理位置信息以及国家名
+(NSDictionary *)getWANIP;
+(NSDictionary *)deviceWANIPAdress;
+(void)showGifLoadingView:(UIViewController *)vc;
+(void)removeGifLoadingView:(UIViewController *)vc;

+(void)showMessageLoadView:(NSString *)message vc:(UIViewController *)vc;
+(void)removeMessageLoadingView:(UIViewController *)vc;
//创建时间与当前时间的间隔
+(int)getTimeDistanceSinceNow:(NSString *)timeStr;

+(int)getAgeByBirthdayStr:(NSString *)birth;
//获取当前用户关注的用户的id列表
+(NSMutableArray *)getGuanZhuIdList;
+(NSDictionary *)getAuthentication;
//获取根据文字自适应高度的lable
+(UILabel *)getLableByContenMessage:(NSString *)contenStr textFont:(float)textFont lineSpacing:(float )lineSpacing lableFrame:(CGRect)lableFrame;
+(void)uploadGuanZhuIdList:(NSMutableArray *)guanZhuList;
// 删除NSArray中的NSNull
+ (NSMutableArray *)removeNullFromArray:(NSArray *)arr;
+ (NSMutableDictionary *)removeNullFromDictionary:(NSDictionary *)dic;
+(NSString *)getCurrentSex;
+(NSString *)getRenQiAR;
+(NSString *)getSignature;
+(NSString *)getBirthday;
+(NSString *)getCityName;
/**
 *  返回截取到的图片
 *
 *  @return UIImage *
 */
+ (UIImage *)imageWithScreenshot;
//截取当前屏幕内容 将以下代码粘贴复制 直接调用imageWithScreenshot方法
/**
 *  截取当前屏幕
 *
 *  @return NSData *
 */
+ (NSData *)dataWithScreenshotInPNGFormat;

//图片合成
+ (UIImage *)composeImg :(UIImage *)bottomImage topImage:(UIImage *)topImage hcImageWidth:(float)hcImageWidth  hcImageHeight:(float)hcImageHeight hcFrame:(CGRect)hcFrame;
//生成二维码
+(UIImage * )erweima :(NSString *)dingDanHao;
//改变二维码大小

    +(UIImage *)createNonInterpolatedUIImageFormCIImage:(CIImage *)image withSize:(CGFloat) size ;
    + (UIImage *)image:(UIImage *)image rotation:(UIImageOrientation)orientation;
    +(int)getEnvironment;

    + (UIViewController *)getCurrentVC ;
+ (UIViewController *)recursiveFindCurrentShowViewControllerFromViewController:(UIViewController *)fromVC;
+ (NSString *)getCurrentDeviceModel;
+(BOOL)getVideoLimit;
+(BOOL)getRadioLimit;
+(BOOL)shuangXiangYanZheng:(NSDictionary *)info jsonStr:(NSString *)jsonStr;
//去除字符串中的emoji
+ (NSString *)filterEmoji:(NSString *)str;
+(void)setTextFieldPlaceholder:(NSString *)textStr placeHoldColor:(UIColor *)color textField:(UITextField *)textField;
+(NSString *)getCheckJBParameter;
+(NSString *)getCheckFZParameter;
+(NSString *)getCheckCZParameter;
+(NSString *)getCheckYEParameter;


//动态点赞评论 好友 关注等消息存储

+(void)setRYMessage:(NSDictionary *)info defaultsKey:(NSString *)defaultsKey;
+(void)removeRyMessageList:(NSString *)defaultsKey;
+(NSArray *)getRYMessageList:(NSString *)defaultsKey;


@end

NS_ASSUME_NONNULL_END
