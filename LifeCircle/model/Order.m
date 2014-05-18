//
//  Order.m
//  LifeCircle
//
//  Created by kamous on 14-4-7.
//  Copyright (c) 2014年 Jiawen Wang. All rights reserved.
//

#import "Order.h"
#import "Product.h" 

@implementation Order


-(Order*)initWithOrderId:(int)orderId userId:(int)userId product:(Product*)product date:(NSDate*)date count:(int)count totalPrice:(double)totalPrice;
{
    self = [super init];
    if(self)
    {
        self.orderId = orderId;
        self.userId = userId;
        self.product = product;
        self.date = date;
        self.count = count;
        self.totalPrice = totalPrice;
    }
    return  self;
}

+(Order*)orderFromJsonDic:(NSDictionary*)dic
{
    NSDictionary * productDic = [dic objectForKey:@"product"];
    Product* product = [Product productFromJsonDic:productDic];
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"yyyy-mm-dd"];
    
   // NSDictionary* dateDic = [dic objectForKey:@"date"];
   // NSDate* date = [NSDate dateWithTimeIntervalSince1970:((NSNumber*)[dateDic objectForKey:@"time"]).doubleValue];
    
    
    Order * order = [[Order alloc] initWithOrderId:((NSNumber*)[dic objectForKey:@"orderId"]).intValue
                                            userId:((NSNumber*)[dic objectForKey:@"userId"]).intValue
                                           product:product
                                              date:[dateFormatter dateFromString:[dic objectForKey:@"date"]]
                                             count:((NSNumber*)[dic objectForKey:@"count"]).intValue
                                        totalPrice:((NSNumber*)[dic objectForKey:@"count"]).doubleValue
                     ];
    return order;
    
}
@end
