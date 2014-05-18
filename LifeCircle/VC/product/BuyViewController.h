//
//  BugyViewController.h
//  LifeCircle
//
//  Created by kamous on 14-4-4.
//  Copyright (c) 2014年 Jiawen Wang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Product.h"
#import "BuyTableViewController.h"
#import "NetWorkManager.h"

@interface BuyViewController : UIViewController<NetWorkDelegate>
@property(nonatomic,strong) Product* product;
@property(nonatomic,strong)BuyTableViewController* buyTableVC;
@property(nonatomic,strong) NetWorkManager * netWorkManager;
@end
