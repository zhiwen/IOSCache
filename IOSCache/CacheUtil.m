//
//  CacheUtil.m
//  IOSCache
//
//  Created by zhiwen.mizw on 6/18/14.
//  Copyright (c) 2014 zhiwen.mizw. All rights reserved.
//

#import "CacheUtil.h"
#import <sys/time.h>

@implementation CacheUtil

+(NSString *) md5String : (id) object {
    
    return [NSString stringWithFormat:@"%@", object];
}

+(NSString *) buildSign:(NSArray *)array {
    [array sortedArrayUsingSelector:@selector(compare:)];
    return [NSString stringWithFormat:@"%@", array];
}

+(time_t) calcExpireSecTime : (int) expireSecTime {
    time_t currentTime;
    time(&currentTime);
    return currentTime + expireSecTime;
}

@end
