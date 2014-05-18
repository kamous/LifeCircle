//
//  Order.h
//  LifeCircle
//
//  Created by kamous on 14-4-7.
//  Copyright (c) 2014年 Jiawen Wang. All rights reserved.
//

#import <Foundation/Foundation.h>
@class  Product;

@interface Order : NSObject

@property (nonatomic,assign) int  orderId;
@property (nonatomic,assign) int userId;
@property (nonatomic,strong) Product * product;
@property (nonatomic,strong) NSDate * date;
@property (nonatomic,assign) int count;
@property (nonatomic,assign) double totalPrice;


-(Order*)initWithOrderId:(int)orderId userId:(int)userId product:(Product*)product date:(NSDate*)date count:(int)count totalPrice:(double)totalPrice;

+(Order*)orderFromJsonDic:(NSDictionary*)dic;
@end
