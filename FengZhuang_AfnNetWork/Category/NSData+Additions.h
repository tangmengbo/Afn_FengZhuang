//
//  NSData+Additions.h
//  DidiTravel
//
//  Created by Apple_yjh on 15-4-10.
//  Copyright (c) 2015年 yjh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonDigest.h>

@interface NSData (Additions)

- (NSString*)md5Hash;
- (NSString*)sha1Hash;
@end
