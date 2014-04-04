//
//  City.m
//  LifeCircle
//
//  Created by kamous on 14-4-2.
//  Copyright (c) 2014年 Jiawen Wang. All rights reserved.
//

#import "City.h"

@implementation City



-(City*)initWithName:(NSString*)name cityId:(int)cityId
{
    self = [super init];
    if(self)
    {
        self.name = name;
        self.cityId =cityId;
    }
    return self;
}


@end
