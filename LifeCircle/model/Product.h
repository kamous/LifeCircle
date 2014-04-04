//
//  Product.h
//  LifeCircle
//
//  Created by kamous on 14-4-2.
//  Copyright (c) 2014年 Jiawen Wang. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Store;
@class Type;


@interface Product : NSObject

@property (nonatomic,strong) NSString * name;
@property (nonatomic,assign) int productId;
@property (nonatomic,assign) double price;
@property (nonatomic,assign) NSString * info;
//@property (nonatomic,strong) NSString * place;
@property (nonatomic,strong) NSString * description;
@property (nonatomic,strong) Store * store;
@property (nonatomic,strong) NSString* pics;
@property (nonatomic,strong) Type* type;

-(Product*)initWithName:(NSString*)name productId:(int)productId price:(double)price info:(NSString*)info description:(NSString*)description store:(Store*)store pics:(NSString*)pics type:(Type*)type;

@end
