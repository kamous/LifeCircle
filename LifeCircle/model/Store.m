//
//  Store.m
//  LifeCircle
//
//  Created by kamous on 14-4-2.
//  Copyright (c) 2014年 Jiawen Wang. All rights reserved.
//

#import "Store.h"
#import "Type.h"

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


+(Store*)storeWithJsonDic:(NSDictionary*)dic
{
    
    Store * store = [[Store alloc]initWithName:[dic objectForKey:@"name"]
                                       storeId:((NSNumber*)[dic objectForKey:@"storeId"]).intValue
                                          city:nil
                                         phone:[dic objectForKey:@"phone"]
                                   locationStr:[dic objectForKey:@"locationStr"]
                                           lon:((NSNumber*)[dic objectForKey:@"lon"]).doubleValue
                                           lat:((NSNumber*)[dic objectForKey:@"lat"]).doubleValue
                     ];
    return store;
}

@end
