//
//  NetWorkManager.m
//  LifeCircle
//
//  Created by kamous on 14-4-13.
//  Copyright (c) 2014年 Jiawen Wang. All rights reserved.
//

#import "NetWorkManager.h"
#import "URLManager.h"
#import "JSONKit.h"

@interface NetWorkManager()
@end



@implementation NetWorkManager
-(id)init{
    self = [super init];
    if(self)
    {
        
    }
    
    return self;
}

-(id)initWithUrlString:(NSString*)baseUrl parameters:(NSString*)parameters
{
    self = [self init];
    self.urlStr = [[URLManager shareManager] urlStringOfName:baseUrl parameters:parameters];
    self.request = [[ASIHTTPRequest alloc]initWithURL:[NSURL URLWithString:self.urlStr]];
    [self.request setDelegate:self];
    self.request.defaultResponseEncoding = NSUTF8StringEncoding;
    return self;
}

-(void)setUrlString:(NSString*)baseUrl parameters:(NSString*)parameters
{
    self.urlStr = [[URLManager shareManager] urlStringOfName:baseUrl parameters:parameters];
    self.request = [[ASIHTTPRequest alloc]initWithURL:[NSURL URLWithString:self.urlStr]];
    [self.request setDelegate:self];
    self.request.defaultResponseEncoding = NSUTF8StringEncoding;
}

-(void)startWork
{
    [self.request startAsynchronous];
    NSLog(@"【URL】:%@",self.request.url);
}

#pragma ASIHTTPRequestDelegate

-(void)requestFailed:(ASIHTTPRequest *)request
{
    NSDictionary * dic = [request.responseString objectFromJSONString];
    [self.delegate netWorkFailed:self dic:dic];
}

-(void)requestFinished:(ASIHTTPRequest *)request
{
    NSDictionary * dic = [request.responseString objectFromJSONString];
    [self.delegate netWorkFinished:self dic:dic];
}

@end
