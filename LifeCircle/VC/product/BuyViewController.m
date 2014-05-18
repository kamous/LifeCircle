//
//  BugyViewController.m
//  LifeCircle
//
//  Created by kamous on 14-4-4.
//  Copyright (c) 2014年 Jiawen Wang. All rights reserved.
//

#import "BuyViewController.h"
//#import "BuyTableViewController.h"
#import "StatusView.h"
#import "UserManager.h"
#import "config.h"

@interface BuyViewController ()

@end

@implementation BuyViewController

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
    
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"buyTableSegue"])
    {
        BuyTableViewController* buyTableVC = [segue destinationViewController];
        self.buyTableVC = buyTableVC;
        buyTableVC.product = self.product;
    }
}

- (IBAction)submitOrderClick:(id)sender
{
    long userId = [[NSUserDefaults standardUserDefaults] integerForKey:@"userId"];
    
    if(![UserManager isLogin])//未登录
    {
        StatusView* sv = [StatusView statusViewInView:self.view withText:@"请先登录！" width:180 height:40 color:[UIColor clearColor] y:430];
        [self performSelector:@selector(dismissStatusView:) withObject:sv afterDelay:1.5];
        [self performSelector:@selector(jumpToLoginPage) withObject:nil afterDelay:1.7];
        return;
    }
    
    if(IS_ON_LINE)
    {
        NSString* parameters = [NSString stringWithFormat:@"?productId=%d&&userId=%ld&&count=%d",self.product.productId,userId,self.buyTableVC.countTextField.text.intValue] ;
        if(!self.netWorkManager)
        {
            self.netWorkManager = [[NetWorkManager alloc]initWithUrlString:@"buyProduct" parameters:parameters];
        }else{
            [self.netWorkManager setUrlString:@"buyProduct" parameters:parameters];
        }
        
        self.netWorkManager.delegate = self;
        
        [self.netWorkManager startWork];
    }else{
        StatusView* sv = [StatusView statusViewInView:self.view withText:@"购买成功！" width:180 height:40 color:[UIColor clearColor] y:430];
        [self performSelector:@selector(dismissStatusView:) withObject:sv afterDelay:1.5];
        [self performSelector:@selector(jumpToOrderList) withObject:nil afterDelay:1.7];

    }
    
}

#pragma mark NetWorkDelegate
-(void)netWorkFailed:(NetWorkManager *)netWorkManager dic:(NSDictionary *)dic
{
    StatusView* sv = [StatusView statusViewInView:self.view withText:@"购买失败，稍后再试！" width:180 height:40 color:[UIColor clearColor] y:430];
    [self performSelector:@selector(dismissStatusView:) withObject:sv afterDelay:1.5];

}

-(void)netWorkFinished:(NetWorkManager *)netWorkManager dic:(NSDictionary *)dic
{
    NSString* errorStr = [dic objectForKey:@"errorMsg"];
    if(errorStr ==nil || [errorStr isEqualToString:@""])
    {
        StatusView* sv = [StatusView statusViewInView:self.view withText:@"购买成功！" width:180 height:40 color:[UIColor clearColor] y:430];
        [self performSelector:@selector(dismissStatusView:) withObject:sv afterDelay:1.5];
        [self performSelector:@selector(jumpToOrderList) withObject:nil afterDelay:1.7];
        
    }else{
        StatusView* sv = [StatusView statusViewInView:self.view withText:errorStr width:180 height:40 color:[UIColor clearColor] y:430];
        [self performSelector:@selector(dismissStatusView:) withObject:sv afterDelay:1.5];
       

    }

}


-(void)dismissStatusView:(StatusView*)sv
{
    [sv removeView];
}

-(void)jumpToLoginPage
{
    [self performSegueWithIdentifier:@"loginSegue" sender:self];
}

-(void)jumpToOrderList
{
    [self performSegueWithIdentifier:@"orderListSegue" sender:self];
}

@end
