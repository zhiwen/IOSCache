//
//  NSKeyedUnarchiverExt.m
//  IOSCache
//
//  Created by zhiwen.mizw on 6/18/14.
//  Copyright (c) 2014 zhiwen.mizw. All rights reserved.
//

#import "NSKeyedUnarchiverExt.h"
#import "CacheConstant.h"
#import "CacheUtil.h"

@implementation NSKeyedUnarchiverExt {
@private
    NSMutableArray *_decodeNames;
}

-(id) init {
    if (self = [super init]) {
        [self initData];
    }
    return self;
}

-(id) initForReadingWithData:(NSData *)data {
    self = [super initForReadingWithData:data];
    if (self) {
        [self initData];
    }
    return self;
}

-(void) initData {
    _decodeNames  = [[NSMutableArray alloc] init];
}

- (id)decodeObjectForKey:(NSString *)key {
    [_decodeNames addObject:key];
    return [super decodeObjectForKey:key];
}
- (BOOL)decodeBoolForKey:(NSString *)key {
    [_decodeNames addObject:key];
    return [super decodeBoolForKey:key];
}
- (int)decodeIntForKey:(NSString *)key {
    [_decodeNames addObject:key];
    return [super decodeIntForKey:key];
}
- (int32_t)decodeInt32ForKey:(NSString *)key {
    [_decodeNames addObject:key];
    return [super decodeInt32ForKey:key];
}
- (int64_t)decodeInt64ForKey:(NSString *)key {
    [_decodeNames addObject:key];
    return [super decodeInt64ForKey:key];
}
- (float)decodeFloatForKey:(NSString *)key {
    [_decodeNames addObject:key];
    return [super decodeFloatForKey:key];
}
- (double)decodeDoubleForKey:(NSString *)key {
    [_decodeNames addObject:key];
    return [super decodeDoubleForKey:key];
}
- (const uint8_t *)decodeBytesForKey:(NSString *)key returnedLength:(NSUInteger *)lengthp NS_RETURNS_INNER_POINTER {
    [_decodeNames addObject:key];
    return [super decodeBytesForKey:key returnedLength:lengthp];
}

-(BOOL) dataExpireValidate {
    int64_t expireTime = [super decodeInt64ForKey:LW_OBJ_CACHE_EXPIRE_NAME];
    //current time
    time_t currentTime;
    time(&currentTime);
    NSLog(@"currT:%ld expireT:%lld", currentTime, expireTime);
    return expireTime > currentTime;
}

-(BOOL) dataSignValidate {
    
    NSString *currentObjSign = [CacheUtil buildSign:_decodeNames];
    NSString *serializedSign = [self getTargetObjectSign];

    NSLog(@"target-sign %@  currentObjSign %@", serializedSign, currentObjSign);
    return [currentObjSign isEqualToString:serializedSign];
}

-(NSString *) getTargetObjectSign {
    return [super decodeObjectForKey:LW_OBJ_SER_SIGN];
}


@end
