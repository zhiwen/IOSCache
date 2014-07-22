//
//  NSKeyedUnarchiverExt.h
//  IOSCache
//
//  Created by zhiwen.mizw on 6/18/14.
//  Copyright (c) 2014 zhiwen.mizw. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSKeyedUnarchiverExt : NSKeyedUnarchiver

- (BOOL)dataExpireValidate;
- (BOOL)dataSignValidate;

@end
