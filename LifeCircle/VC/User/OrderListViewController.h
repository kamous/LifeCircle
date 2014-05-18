//
//  OrderListViewController.h
//  LifeCircle
//
//  Created by kamous on 14-4-4.
//  Copyright (c) 2014年 Jiawen Wang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NetWorkManager.h"

@interface OrderListViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,NetWorkDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,strong) NetWorkManager* netWorkManager;


@property (nonatomic,strong) NSMutableArray* orderList;
@end
