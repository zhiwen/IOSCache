//
//  PersonModule.m
//  IOSCache
//
//  Created by zhiwen.mizw on 6/19/14.
//  Copyright (c) 2014 zhiwen.mizw. All rights reserved.
//

#import "PersonModule.h"

@implementation PersonModule

-(void) encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:_name forKey:@"name"];
    [aCoder encodeInt32:_age forKey:@"age"];
    [aCoder encodeObject:_address forKey:@"address"];
    [aCoder encodeFloat:_weight forKey:@"weight"];
}

-(id) initWithCoder:(NSCoder *)aDecoder {
    if (self = [super init]) {
        self.name = [aDecoder decodeObjectForKey:@"name"];
        //self.age = [aDecoder decodeInt32ForKey:@"age"];
        //self.address = [aDecoder decodeObjectForKey:@"address"];
        //self.weight = [aDecoder decodeFloatForKey:@"weight"];
    }
    return self;
}

@end
