//
//  BuyTableViewController.h
//  LifeCircle
//
//  Created by kamous on 14-4-16.
//  Copyright (c) 2014年 Jiawen Wang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Product.h"

@interface BuyTableViewController : UITableViewController
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UITextField *countTextField;
@property (weak, nonatomic) IBOutlet UILabel *totalPriceLabel;

@property (nonatomic,strong) Product* product;
@end
