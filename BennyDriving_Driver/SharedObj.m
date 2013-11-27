//
//  SharedObj.m
//  BennyDriving_Driver
//
//  Created by ZHOUHONG on 8/14/13.
//  Copyright (c) 2013 BennyDriving. All rights reserved.
//

#import "SharedObj.h"

@interface SharedObj ()

@end

static SharedObj *__sharedObj = nil;

@implementation SharedObj

@synthesize SerNum,dialNum,switchon,segmentIndex;
@synthesize indexPathRow_news,indexPathRow_orders,logindriid,logindrinum,loginisagr,startLocation,endLocation;

- (id)init
{
    self = [super init];
    if (self) {
        self.switchon = 0;
        self.segmentIndex = 0;
        self.indexPathRow_news = 0;
        self.indexPathRow_orders = 0;
        self.logindriid = @"";
        self.logindrinum = @"";
        self.loginisagr = @"";
        self.startLocation = @"";
        self.endLocation = @"";
        self.starTime = @"";
        self.endTime = @"";
        self.driLog = 0;
        self.driLat = 0;
    }
    return self;
}

+ (SharedObj *)sharedOBJ
{
    if (__sharedObj == nil)
        __sharedObj = [[self alloc] init];
    return __sharedObj;
}

@end
