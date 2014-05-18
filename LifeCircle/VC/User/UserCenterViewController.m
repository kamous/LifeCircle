//
//  UserCenterViewController.m
//  LifeCircle
//
//  Created by kamous on 14-4-4.
//  Copyright (c) 2014年 Jiawen Wang. All rights reserved.
//

#import "UserCenterViewController.h"
#import "StatusView.h"
#import "UserManager.h"

@interface UserCenterViewController ()

@end

@implementation UserCenterViewController

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

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    NSUserDefaults* userDefaults = [NSUserDefaults standardUserDefaults];
    BOOL isLogin = [userDefaults boolForKey:@"isLogin"];
    
    [self updateUserViewWithIsLogin:isLogin];
    
}

-(void)updateUserViewWithIsLogin:(BOOL)isLogin
{
    UIView * userInfoView = [self.view viewWithTag:102];
    UIView * buttonView = [self.view viewWithTag:101];
    
    UIView* logoutButton = [self.view viewWithTag:104];
    
    if(isLogin)//login
    {
        [userInfoView setHidden:NO];
        [buttonView setHidden:YES];
        [logoutButton setHidden:NO];
    }else//not login
    {
        [userInfoView setHidden:YES];
        [buttonView setHidden:NO];
        [logoutButton setHidden:YES];
    }

    
}
- (IBAction)logout:(id)sender {
    
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    [userDefault setBool:NO forKey:@"isLogin"];
    [userDefault setInteger:0 forKey:@"userId"];
    [self updateUserViewWithIsLogin:NO];
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{

}
- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender
{
    if([identifier isEqualToString:@"orderListSegue"] && ![UserManager isLogin])
    {
        StatusView* sv = [StatusView statusViewInView:self.view withText:@"请先登录！" width:180 height:40 color:[UIColor clearColor] y:430];
        
        [self performSelector:@selector(dismissStatusView:) withObject:sv afterDelay:1.5];
        [self performSelector:@selector(jumpToLoginPage) withObject:nil afterDelay:1.7];
        
        return NO;
    }
    return YES;
}

-(void)dismissStatusView:(StatusView*)sv
{
    [sv removeView];
}

-(void)jumpToLoginPage
{
    [self performSegueWithIdentifier:@"loginSegue" sender:self];
}


@end
