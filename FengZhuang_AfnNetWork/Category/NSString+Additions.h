//
//  NSString+Additions.h
//  DidiTravel
//
//  Created by Apple_yjh on 15-4-10.
//  Copyright (c) 2015年 yjh. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Additions)

- (NSString*)stringByAddingQueryDictionary:(NSDictionary*)query;

- (NSString *)JSONRepresentation;

- (id)JSONValue;

- (CGSize)sizeWithFont:(UIFont *)font maxSize:(CGSize)maxSize;

- (NSString *)getReadableDateFromTimestamp;
@end
