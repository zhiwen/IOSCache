//
//  NSKeyedArchiverExt.h
//  IOSCache
//
//  Created by zhiwen.mizw on 6/18/14.
//  Copyright (c) 2014 zhiwen.mizw. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSKeyedArchiverExt : NSKeyedArchiver

- (NSArray *)getAllEncodeNames;

- (void)encodeObjectExpireTime:(int)expireSecTime;

@end
