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
        person1.name = @"yyyyy";
        person1.age = 12;
        person1.address = [[NSMutableArray alloc] initWithObjects:@"hn", nil];
        person1.weight = 15.6;
        
        [fc putObject:person1 expireSecTime:100 forKey:@"person1"];
        
     
        person1 = [fc getObjectForKey:@"person1"];
        NSLog(@"%@", person1);
        
        //[fc removeForGroup:@"app"];
        //[fc removeAll];
    }
    return 0;
}

