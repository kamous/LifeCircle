//
//  Store.h
//  LifeCircle
//
//  Created by kamous on 14-4-2.
//  Copyright (c) 2014年 Jiawen Wang. All rights reserved.
//

#import <Foundation/Foundation.h>
@class City;

@interface Store : NSObject
@property (nonatomic,strong) NSString* name;
@property (nonatomic,assign) int storeId;
@property (nonatomic,strong) City * city;
@property (nonatomic,strong) NSString* phone;
@property (nonatomic,strong) NSString* locationStr;
@property (nonatomic,assign) double lon;
@property (nonatomic,assign) double lat;

-(Store*)initWithName:(NSString*)name storeId:(int)storeId city:(City*)city phone:(NSString*)phone locationStr:(NSString*)locationStr lon:(double)lon lat:(double)lat;

+(Store*)storeWithJsonDic:(NSDictionary*)dic;

@end
