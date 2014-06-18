//
//  PersonModule.h
//  IOSCache
//
//  Created by zhiwen.mizw on 6/19/14.
//  Copyright (c) 2014 zhiwen.mizw. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PersonModule : NSObject<NSCoding>

@property(nonatomic) NSString *name;
@property(nonatomic) int age;
@property(nonatomic) NSMutableArray *address;
@property(nonatomic) float  weight;

@end
