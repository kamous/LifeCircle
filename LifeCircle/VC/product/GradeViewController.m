//
//  GradeViewController.m
//  LifeCircle
//
//  Created by kamous on 14-5-14.
//  Copyright (c) 2014年 Jiawen Wang. All rights reserved.
//

#import "GradeViewController.h"
#import "Product.h"
#import "Store.h"
#import "Order.h"
#import "TQStarRatingView.h"

@interface GradeViewController ()

@end

@implementation GradeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    
    [super viewDidLoad];
    if(self.order)
    {
        self.nameLabel.text  = self.order.product.name;
        self.storeLabel.text = self.order.product.store.name;
    }
    
    
    TQStarRatingView *starRatingView = [[TQStarRatingView alloc] initWithFrame:CGRectMake(30, 200, 250, 50)
                                                                  numberOfStar:5];
    starRatingView.delegate = self;
    [self.view addSubview:starRatingView];
    
    
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma StarRatingViewDelegate
-(void)starRatingView:(TQStarRatingView *)view score:(float)score
{
    self.scoreLabel.text = [NSString stringWithFormat:@"%0.2f",score * 10 ];
}



@end
