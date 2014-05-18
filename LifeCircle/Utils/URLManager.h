//
//  URLManager.h
//  LifeCircle
//
//  Created by kamous on 14-4-13.
//  Copyright (c) 2014年 Jiawen Wang. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum{
    eProductImage =0,
    eUserImage = 1
}ImageType;


@interface URLManager : NSObject
+(URLManager*)shareManager;
-(NSString*)urlStringOfName:(NSString*)urlName parameters:(NSString*)parameters;

-(NSString*)urlStringOfImageName:(NSString*)imageName type:(ImageType)imageType;

@end

