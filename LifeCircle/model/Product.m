//
//  Product.m
//  LifeCircle
//
//  Created by kamous on 14-4-2.
//  Copyright (c) 2014年 Jiawen Wang. All rights reserved.
//

#import "Product.h"

@implementation Product

-(Product*)initWithName:(NSString*)name productId:(int)productId price:(double)price info:(NSString*)info description:(NSString*)description store:(Store*)store pics:(NSString*)pics type:(Type *)type{
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
        self.type = type;
    }
    return self;
}
@end
