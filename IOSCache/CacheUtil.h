//
//  CacheUtil.h
//  IOSCache
//
//  Created by zhiwen.mizw on 6/18/14.
//  Copyright (c) 2014 zhiwen.mizw. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CacheUtil : NSObject

+(NSString *) md5String : (id) object;

+(NSString *) buildSign : (NSArray *) array;

+(time_t) calcExpireSecTime : (int) expireSecTime;

@end
