//
//  GradeViewController.h
//  LifeCircle
//
//  Created by kamous on 14-5-14.
//  Copyright (c) 2014年 Jiawen Wang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TQStarRatingView.h"

@class Order;
@interface GradeViewController : UIViewController<StarRatingViewDelegate>
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *storeLabel;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;


//@property (nonatomic,strong) Product * product;

@property (nonatomic,strong) Order * order;
@end
