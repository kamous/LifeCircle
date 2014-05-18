//
//  UserManager.h
//  LifeCircle
//
//  Created by kamous on 14-4-20.
//  Copyright (c) 2014年 Jiawen Wang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserManager : NSObject
+(BOOL)isLogin;

+(int)getLoginUserId;
@end
