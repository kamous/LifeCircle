//
//  UserManager.m
//  LifeCircle
//
//  Created by kamous on 14-4-20.
//  Copyright (c) 2014年 Jiawen Wang. All rights reserved.
//

#import "UserManager.h"

@implementation UserManager

+(BOOL)isLogin
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    BOOL isLogin = [userDefaults boolForKey:@"isLogin"];
    int userId = [userDefaults boolForKey:@"userId"];
    if(isLogin && userId!=0)
    {
        return true;
    }
    return false;
    
}

+(int)getLoginUserId
{
    return [[NSUserDefaults standardUserDefaults] boolForKey:@"userId"];
 }
@end
