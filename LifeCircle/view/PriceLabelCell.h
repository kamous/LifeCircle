//
//  PriceLabelCell.h
//  LifeCircle
//
//  Created by kamous on 14-4-4.
//  Copyright (c) 2014年 Jiawen Wang. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol BuyButtonDelegate <NSObject>

-(void)buyClick:(id)sender;

@end


@interface PriceLabelCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property id<BuyButtonDelegate> delegate;
@end


