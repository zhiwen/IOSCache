//
//  main.m
//  IOSCache
//
//  Created by zhiwen.mizw on 6/18/14.
//  Copyright (c) 2014 zhiwen.mizw. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FileCache.h"
#import "PersonModule.h"

int main(int argc, const char * argv[])
{

    @autoreleasepool {
        
        FileCache *fc = [[FileCache alloc] init];
        
        fc.storePath = @"/Users/zhiwenmizw/work/laiwang/output/temp";
        //fc.group = @"p";
        
        PersonModule *person1 = [[PersonModule alloc] init];
        person1.name = @"zhiwen";
        person1.age = 12;
        person1.address = [[NSMutableArray alloc] initWithObjects:@"hn",@"hz", nil];
        person1.weight = 15.6;
        
        [fc putObject:person1 expireSecTime:10 forKey:@"person1"];
        
        
    }
    return 0;
}

