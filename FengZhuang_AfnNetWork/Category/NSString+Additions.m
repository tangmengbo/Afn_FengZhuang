//
//  NSString+Additions.m
//  DidiTravel
//
//  Created by Apple_yjh on 15-4-10.
//  Copyright (c) 2015年 yjh. All rights reserved.
//
#import "Usually.h"
#import "NSString+Additions.h"

@implementation NSString (Additions)

- (NSString*)stringByAddingQueryDictionary:(NSDictionary*)query
{
    NSMutableArray* pairs = [NSMutableArray array];
    for (NSString* key in [query keyEnumerator]) {
        NSString* value = [query objectForKey:key];
        value = [value stringByReplacingOccurrencesOfString:@"?" withString:@"%3F"];
        value = [value stringByReplacingOccurrencesOfString:@"=" withString:@"%3D"];
        NSString* pair = [NSString stringWithFormat:@"%@=%@", key, value];
        [pairs addObject:pair];
    }
    
    NSString* params = [pairs componentsJoinedByString:@"&"];
    if ([self rangeOfString:@"?"].location == NSNotFound) {
        return [self stringByAppendingFormat:@"?%@", params];
        
    } else {
        return [self stringByAppendingFormat:@"&%@", params];
    }
}

- (NSString *)JSONRepresentation
{
    NSString *str;
    if ([NSJSONSerialization isValidJSONObject:self])
    {
        NSError *err;
        NSData *strData = [NSJSONSerialization dataWithJSONObject:self options:NSJSONWritingPrettyPrinted error:&err];
        str = [[NSString alloc] initWithData:strData encoding:NSUTF8StringEncoding];
    }
    return str;
}

- (id)JSONValue
{
    //处理报文
    NSError *err;
    //判断是否为json字符串
    if ([self isKindOfClass:[NSString class]])
    {
        NSString *jsonstr = (NSString*)self;
        NSString *containString = @":";
        NSRange range = [jsonstr rangeOfString:containString];
        if (range.location == NSNotFound || [Usually strNilOrEmpty:jsonstr])
        {
            return nil;
        }
    }
    else
    {
        NSString *jsonstr = [[NSString alloc]initWithData:(NSData *)self encoding:NSUTF8StringEncoding];
        NSString *containString = @":";
        NSRange range = [jsonstr rangeOfString:containString];
        if (range.location == NSNotFound || [Usually strNilOrEmpty:jsonstr])
        {
            return nil;
        }
    }
    if ([self isKindOfClass:[NSString class]])
    {
        NSString *jsonstr = (NSString*)self;
        NSData *data = [jsonstr dataUsingEncoding:NSUTF8StringEncoding];
        id dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&err];
        return dict;
    }
    
    id dict = [NSJSONSerialization JSONObjectWithData:(NSData *)self options:NSJSONReadingAllowFragments error:&err];
    return dict;
}

- (CGSize)sizeWithFont:(UIFont *)font maxSize:(CGSize)maxSize
{
    NSDictionary *attrs = @{NSFontAttributeName : font};
    return [self boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
}

- (NSString *)getReadableDateFromTimestamp
{
    NSString *_timestamp;
    
    NSTimeInterval createdAt = [self doubleValue];
    
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
            [dateFormatter setDateFormat:@"yy- MM- dd"];
        }
        NSDate *date = [NSDate dateWithTimeIntervalSince1970:createdAt];
        _timestamp = [dateFormatter stringFromDate:date];
    }
    
    return _timestamp;
}

@end
