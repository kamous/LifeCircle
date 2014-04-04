//
//  Store.m
//  LifeCircle
//
//  Created by kamous on 14-4-2.
//  Copyright (c) 2014年 Jiawen Wang. All rights reserved.
//

#import "Store.h"

@implementation Store



-(Store*)initWithName:(NSString*)name storeId:(int)storeId city:(City*)city phone:(NSString*)phone locationStr:(NSString*)locationStr lon:(double)lon lat:(double)lat
{
    self = [ super init];
    if(self)
    {
        self.storeId = storeId;
        self.name = name;
        self.city = city;
        self.phone = phone;
        self.locationStr = locationStr;
        self.lon = lon;
        self.lat = lat;
    }
    return self;
}


@end
