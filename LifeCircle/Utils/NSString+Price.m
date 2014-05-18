//
//  NSString+Price.m
//  LifeCircle
//
//  Created by kamous on 14-4-14.
//  Copyright (c) 2014年 Jiawen Wang. All rights reserved.
//

#import "NSString+Price.h"

@implementation NSString (Price)

+(NSString*)stringInPriceFormat:(double) price
{
    NSMutableString * priceStr = [NSMutableString stringWithFormat:@"%f",price];
    NSRange pointRange = [priceStr rangeOfString:@"."];
    if(pointRange.location == NSNotFound)
    {
        return priceStr;
    }
    int notZeroNum = 0;
    NSString * afterPoint = [priceStr substringFromIndex:pointRange.location+1];
    if([afterPoint characterAtIndex:1] != '0')
    {
        notZeroNum = 2;
        
    }else if([afterPoint characterAtIndex:0] != '0')
    {
        notZeroNum = 1;
    }
    notZeroNum = (notZeroNum == 0) ? 0 : (notZeroNum+1);
    return [NSString stringWithFormat:@"%@元",[priceStr substringToIndex:pointRange.location+notZeroNum ]];
}

@end
