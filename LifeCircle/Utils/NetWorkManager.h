//
//  NetWorkManager.h
//  LifeCircle
//
//  Created by kamous on 14-4-13.
//  Copyright (c) 2014年 Jiawen Wang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ASIHTTPRequest.h"
@protocol ASIHTTPRequestDelegate;
@class  NetWorkManager;

@protocol NetWorkDelegate <NSObject>



-(void)netWorkFinished:(NetWorkManager*)netWorkManager dic:(NSDictionary*)dic;

-(void)netWorkFailed:(NetWorkManager*)netWorkManager dic:(NSDictionary*)dic;

@end


@interface NetWorkManager : NSObject<ASIHTTPRequestDelegate>

@property(nonatomic,strong) NSString* urlStr;
@property(nonatomic,weak) id<NetWorkDelegate> delegate;

@property(nonatomic,strong) ASIHTTPRequest* request;

-(id)initWithUrlString:(NSString*)baseUrl parameters:(NSString*)parameters;
-(void)setUrlString:(NSString*)baseUrl parameters:(NSString*)parameters;
-(void)startWork;
@end
