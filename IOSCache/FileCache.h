//
//  FileCache.h
//  IOSCache
//
//  Created by zhiwen.mizw on 6/18/14.
//  Copyright (c) 2014 zhiwen.mizw. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FileCache : NSObject

@property(nonatomic) NSString *storePath;
@property(nonatomic) NSString *group;

- (BOOL)putObject:(id<NSCoding>)value
    expireSecTime:(int)expireSecTime
           forKey:(NSString *)key;

- (id)getObjectForKey:(NSString *)key;

- (BOOL)removeObjectForKey:(NSString *)key;

- (BOOL)removeForGroup:(NSString *)group;

- (BOOL)removeAll;

@end
