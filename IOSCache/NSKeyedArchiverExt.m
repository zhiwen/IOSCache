//
//  NSKeyedArchiverExt.m
//  IOSCache
//
//  Created by zhiwen.mizw on 6/18/14.
//  Copyright (c) 2014 zhiwen.mizw. All rights reserved.
//

#import "NSKeyedArchiverExt.h"
#import "CacheConstant.h"
#import "CacheUtil.h"

@implementation NSKeyedArchiverExt {

@private
    NSMutableArray *_encodeNames;
    
}

-(id) init {
    self = [super init];
    if (self) {
        [self initData];
    }
    return self;
}

- (id)initForWritingWithMutableData:(NSMutableData *)data {
    if (self = [super initForWritingWithMutableData:data]) {
        [self initData];
    }
    return self;
}

-(void) initData {
    _encodeNames = [[NSMutableArray alloc] init];
}

-(NSArray *) getAllEncodeNames {
    return [NSArray arrayWithArray:_encodeNames];
}

- (void)encodeObject:(id)objv forKey:(NSString *)key {
    [_encodeNames addObject:key];
    [super encodeObject:objv forKey:key];
}

- (void)encodeConditionalObject:(id)objv forKey:(NSString *)key {
    [_encodeNames addObject:key];
    [super encodeConditionalObject:objv forKey:key];
}
- (void)encodeBool:(BOOL)boolv forKey:(NSString *)key {
    [_encodeNames addObject:key];
    [super encodeBool:boolv forKey:key];
}
- (void)encodeInt:(int)intv forKey:(NSString *)key {
    [_encodeNames addObject:key];
    [super encodeInt:intv forKey:key];
}
- (void)encodeInt32:(int32_t)intv forKey:(NSString *)key {
    [_encodeNames addObject:key];
    [super encodeInt32:intv forKey:key];
}
- (void)encodeInt64:(int64_t)intv forKey:(NSString *)key {
    [_encodeNames addObject:key];
    [super encodeInt64:intv forKey:key];
}
- (void)encodeFloat:(float)realv forKey:(NSString *)key {
    [_encodeNames addObject:key];
    [super encodeFloat:realv forKey:key];
}
- (void)encodeDouble:(double)realv forKey:(NSString *)key {
    [_encodeNames addObject:key];
    [super encodeDouble:realv forKey:key];
}
- (void)encodeBytes:(const uint8_t *)bytesp length:(NSUInteger)lenv forKey:(NSString *)key {
    [_encodeNames addObject:key];
    [super encodeBytes:bytesp length:lenv forKey:key];
}

-(void) finishEncoding {
    [super encodeObject:[CacheUtil buildSign:_encodeNames] forKey:LW_OBJ_SER_SIGN];
    [super finishEncoding];
}

-(void) encodeObjectExpireTime : (int) expireSecTime {
    [super encodeInt64:[CacheUtil calcExpireSecTime:expireSecTime] forKey:LW_OBJ_CACHE_EXPIRE_NAME];
}

@end
