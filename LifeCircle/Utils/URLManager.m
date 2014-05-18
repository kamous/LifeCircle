//
//  URLManager.m
//  LifeCircle
//
//  Created by kamous on 14-4-13.
//  Copyright (c) 2014年 Jiawen Wang. All rights reserved.
//

#import "URLManager.h"
@interface URLManager()
@property (nonatomic,strong)NSDictionary* urlDic;

@end

@implementation URLManager
+(URLManager*)shareManager
{
    static URLManager* urlManager = nil;
    static dispatch_once_t onceToken ;
    dispatch_once(&onceToken,^{
        urlManager = [[super allocWithZone:NULL]init];
        NSString * urlPlistPath = [[NSBundle mainBundle]  pathForResource:@"url" ofType:@"plist"];
        urlManager.urlDic = [[NSDictionary alloc] initWithContentsOfFile:urlPlistPath];
        
    });
    return urlManager;
}

+(instancetype)allocWithZone:(struct _NSZone *)zone
{
    return [self shareManager];
}


-(NSString*)urlStringOfName:(NSString*)urlName parameters:(NSString*)parameters
{
    if(parameters==nil)
    {
        parameters=@"";
    }
    if([urlName isEqualToString:@"baseIP"])
    {
        return [NSString stringWithFormat:@"%@",[self.urlDic objectForKey:@"baseIP"]];
    }
    return  [NSString stringWithFormat:@"%@/%@%@",[self.urlDic objectForKey:@"baseIP"],[self.urlDic objectForKey:urlName] , parameters];
}

-(NSString*)urlStringOfImageName:(NSString*)imageName type:(ImageType)imageType
{
    NSString* floder = @"";
    if(imageType == eProductImage )
    {
        floder = @"pic/image";
    }else if(imageType == eUserImage)
    {
        floder = @"pic/userImg";
    }
    
    return  [NSString stringWithFormat:@"%@/%@/%@",[self.urlDic objectForKey:@"baseIP"],floder ,imageName];
}


@end
