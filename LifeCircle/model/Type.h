//
//  Type.h
//  LifeCircle
//
//  Created by kamous on 14-4-2.
//  Copyright (c) 2014年 Jiawen Wang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Type : NSObject

@property (nonatomic,strong)NSString* name;
@property (nonatomic,assign)int typeId;

-(Type*)initWithName:(NSString*)name typeId:(int)typeId;

@end
