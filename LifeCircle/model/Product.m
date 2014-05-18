//
//  Product.m
//  LifeCircle
//
//  Created by kamous on 14-4-2.
//  Copyright (c) 2014年 Jiawen Wang. All rights reserved.
//

#import "Product.h"
#import "Store.h"
#import "URLManager.h"
#import "config.h"

@implementation Product

-(Product*)initWithName:(NSString*)name productId:(int)productId price:(double)price info:(NSString*)info description:(NSString*)description store:(Store*)store pics:(NSString*)pics{
    self = [super init];
    if(self)
    {
        self.productId = productId;
        self.name = name;
        self.price = price;
        self.info = info;
        self.description = description;
        self.store = store;
        self.pics = pics;
    }
    return self;
}


+(Product*)productFromJsonDic:(NSDictionary *)dic
{
    Store * store = nil;
    NSDictionary* storeDic = [dic objectForKey:@"store"];
    
    if(storeDic !=nil)
    {
        store = [Store storeWithJsonDic:storeDic];
    }
    
    if(IS_ON_LINE)
    {
        return [[Product alloc] initWithName:[dic objectForKey:@"name"]
                                   productId:((NSNumber*)[dic objectForKey:@"productId"]).intValue
                                       price:((NSNumber*)[dic objectForKey:@"price"]).doubleValue
                                        info:[dic objectForKey:@"info"]
                                 description:[dic objectForKey:@"description" ]
                                       store:store
                                        pics:[[URLManager shareManager] urlStringOfImageName:[dic objectForKey:@"pics"] type:eProductImage]];
    }else
    {
        return [[Product alloc] initWithName:[dic objectForKey:@"name"]
                                   productId:((NSNumber*)[dic objectForKey:@"productId"]).intValue
                                       price:((NSNumber*)[dic objectForKey:@"price"]).doubleValue
                                        info:[dic objectForKey:@"info"]
                                 description:[dic objectForKey:@"description" ]
                                       store:store
                                        pics:[dic objectForKey:@"pics"]];
    }
    
}
@end
