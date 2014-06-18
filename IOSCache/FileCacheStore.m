//
//  FileCacheStore.m
//  IOSCache
//
//  Created by zhiwen.mizw on 6/18/14.
//  Copyright (c) 2014 zhiwen.mizw. All rights reserved.
//

#import "FileCacheStore.h"

@implementation FileCacheStore {

    @private
    NSRecursiveLock *fileAccessLock;
    
}

#define DEFAULT_GROUP_VALUE @"app"

-(BOOL) directoryExists : (NSString *) directory {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL isDirectory = NO;
    BOOL exists = [fileManager fileExistsAtPath:directory isDirectory:&isDirectory];
    return exists && isDirectory;
}

-(NSString *) createDirectoryIfNULL {
    if (!_storePath) {
        [NSException raise:@"StorePathIsNull" format:@"storePath is required"];
    }
    if (!_group) {
        _group = DEFAULT_GROUP_VALUE;
    }
    
    NSFileManager *fileManager = [NSFileManager defaultManager];

    NSString *directory = [NSString stringWithFormat:@"%@/%@", _storePath, _group];
    if (![self directoryExists:directory]) {
        BOOL created = [fileManager createDirectoryAtPath:directory withIntermediateDirectories:YES attributes:nil error:nil];
        if (!created) {
            [NSException raise:@"FailedToCreateCacheDirectory" format:@"Failed to create a directory for the cache at '%@'",directory];
        }
    }
    return directory;
}

-(NSString *) filePathConcat : (NSString *) fileName {
    NSString *directory = [self createDirectoryIfNULL];
    NSString *filePath = [NSString stringWithFormat:@"%@/%@", directory, fileName];
    return filePath;
}

-(id) init {
    return [FileCacheStore sharedFileCacheStore];
}

-(instancetype) initInstance {
    if (self = [super init]) {
        fileAccessLock = [[NSRecursiveLock alloc] init];
        _storePath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingString:@"/data-caches"];
        _group = DEFAULT_GROUP_VALUE;
        //load file calc size and count
    }
    return self;
}

+(instancetype) sharedFileCacheStore {
    static FileCacheStore *fileCacheStore;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^(void) {
        fileCacheStore = [[FileCacheStore alloc] initInstance];
    });
    return fileCacheStore;
}

-(BOOL) storeForFileName : (NSString *) fileName data : (NSMutableData *) data {
    if (!fileName || !data) {
        return NO;
    }
    @try {
        [fileAccessLock lock];
        NSString *filePath = [self filePathConcat:fileName];
        return [data writeToFile:filePath atomically:YES];
    }
    @finally {
        [fileAccessLock unlock];
    }
}

-(id) readForFileName : (NSString *) fileName {
    if (!fileName) {
        return nil;
    }
    NSString *filePath = [self filePathConcat:fileName];
    NSMutableData *data = [NSMutableData dataWithContentsOfFile:filePath];
    return data;
}

@end
