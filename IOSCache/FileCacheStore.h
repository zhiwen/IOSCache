//
//  FileCacheStore.h
//  IOSCache
//
//  Created by zhiwen.mizw on 6/18/14.
//  Copyright (c) 2014 zhiwen.mizw. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FileCacheStore : NSObject

+ (instancetype)sharedFileCacheStore;

@property(nonatomic) NSString *storePath;
@property(nonatomic) NSString *group;

- (BOOL)storeForFileName:(NSString *)fileName data:(NSMutableData *)data;

- (id)readForFileName:(NSString *)fileName;

- (BOOL)removeForFileName:(NSString *)fileName;

- (BOOL)removeForGroup:(NSString *)group;

- (BOOL)removeAll;
@end
