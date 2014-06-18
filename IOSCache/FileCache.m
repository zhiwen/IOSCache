//
//  FileCache.m
//  IOSCache
//
//  Created by zhiwen.mizw on 6/18/14.
//  Copyright (c) 2014 zhiwen.mizw. All rights reserved.
//

#import "FileCache.h"
#import "CacheUtil.h"
#import "FileCacheStore.h"
#import "NSKeyedArchiverExt.h"
#import "NSKeyedUnarchiverExt.h"

@implementation FileCache

-(FileCacheStore *) getFileCacheStore {
    FileCacheStore *fileCacheStore = [FileCacheStore sharedFileCacheStore];
    fileCacheStore.storePath = _storePath;
    fileCacheStore.group = _group;
    return fileCacheStore;
}

-(BOOL) putObject : (id<NSCoding>) value expireSecTime : (int) expireSecTime forKey : (NSString *) key {
    if (!key) {
        return NO;
    }
    
    NSString *md5Key = [CacheUtil md5String:key];
    if (!value) {
        return [self removeObjectForMD5Key:md5Key];
    }

    NSMutableData *data = [[NSMutableData alloc] init];
    NSKeyedArchiverExt *keyedArchiver = [[NSKeyedArchiverExt alloc] initForWritingWithMutableData:data];
    [keyedArchiver setOutputFormat:NSPropertyListXMLFormat_v1_0];
    [keyedArchiver encodeObject:value];
    [keyedArchiver encodeObjectExpireTime:expireSecTime];
    [keyedArchiver finishEncoding];
    
    return [[self getFileCacheStore] storeForFileName:md5Key data:data];
}

-(id) getObjectForKey : (NSString *) key {
    if (!key) {
        return nil;
    }
    NSString *md5Key = [CacheUtil md5String:key];
    NSMutableData *data = [[self getFileCacheStore] readForFileName:md5Key];
    if (!data) {
        return nil;
    }

    NSKeyedUnarchiverExt *keyedUnarchiver = [[NSKeyedUnarchiverExt alloc] initForReadingWithData:data];
    id result = [keyedUnarchiver decodeObject];
    
    //data-expire-validate
    BOOL isOKData = [keyedUnarchiver dataExpireValidate];
    if (!isOKData) {
        [self removeObjectForMD5Key:md5Key];
        return nil;
    }
    //data-sign-validate
    isOKData = [keyedUnarchiver dataSignValidate];
    if (!isOKData) {
        [self removeObjectForMD5Key:md5Key];
        return nil;
    }
    
    [keyedUnarchiver finishDecoding];
    return result;
}

-(BOOL) removeObjectForMD5Key:(NSString *)md5key {
    return [[self getFileCacheStore] removeForFileName:md5key];
}

-(BOOL) removeObjectForKey : (NSString *) key {
    NSString *md5Key = [CacheUtil md5String:key];
    return [self removeObjectForMD5Key:md5Key];
}

-(BOOL) removeForGroup : (NSString *) group {
    return [[self getFileCacheStore] removeForGroup:group];
}

-(BOOL) removeAll {
    return [[self getFileCacheStore] removeAll];
}

@end
