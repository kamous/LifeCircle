//
//  InfoViewController.h
//  LifeCircle
//
//  Created by kamous on 14-4-4.
//  Copyright (c) 2014年 Jiawen Wang. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol BuyButtonDelegate;
@class Product;
@interface InfoViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,BuyButtonDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) Product* product;
@end
