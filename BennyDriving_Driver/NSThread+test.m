//
//  NSThread+test.m
//  BennyDriving_Driver
//
//  Created by ZHOUHONG on 8/22/13.
//  Copyright (c) 2013 BennyDriving. All rights reserved.
//

#import "NSThread+test.h"

@implementation NSThread (test)
+(NSThread *)getThread
{
    static NSThread *a;
    if (a == nil) {
        a = [NSThread alloc];
    }
    return a;
}
@end
