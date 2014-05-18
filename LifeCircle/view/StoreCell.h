//
//  StoreCell.h
//  LifeCircle
//
//  Created by kamous on 14-4-4.
//  Copyright (c) 2014年 Jiawen Wang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StoreCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *storeNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *storeLocationLable;
@property (weak, nonatomic) IBOutlet UILabel *storeDistanceLabel;

@end
