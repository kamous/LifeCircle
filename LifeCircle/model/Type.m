//
//  Type.m
//  LifeCircle
//
//  Created by kamous on 14-4-2.
//  Copyright (c) 2014年 Jiawen Wang. All rights reserved.
//

#import "Type.h"

@implementation Type



-(Type*)initWithName:(NSString*)name typeId:(int)typeId
{
    self = [super init];
    if(self)
    {
        self.name = name;
        self.typeId = typeId;
    }
    return self;
}

@end
