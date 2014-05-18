//
//  LoginViewController.m
//  LifeCircle
//
//  Created by kamous on 14-4-4.
//  Copyright (c) 2014年 Jiawen Wang. All rights reserved.
//

#import "LoginViewController.h"
#import "StatusView.h"


@interface LoginViewController ()

@end

@implementation LoginViewController

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


- (IBAction)login:(id)sender {
    if(self.emailTextField.text.length==0)
    {
        StatusView* sv = [StatusView statusViewInView:self.view withText:@"邮箱不能为空！" width:150 height:40 color:[UIColor clearColor] y:230];
        [self performSelector:@selector(dismissStatusView:) withObject:sv afterDelay:1.5];
    }else if(self.passwordTextField.text.length == 0)
    {
        StatusView* sv = [StatusView statusViewInView:self.view withText:@"密码不能为空！" width:150 height:40 color:[UIColor clearColor] y:230];
        [self performSelector:@selector(dismissStatusView:) withObject:sv afterDelay:1.5];
    }else if( [self.emailTextField.text isEqualToString:@"xx@qq.com"] && [self.passwordTextField.text isEqualToString:@"123"])//登录成功
    {
        NSUserDefaults* userDefaults = [NSUserDefaults standardUserDefaults];
        [userDefaults setBool:YES forKey:@"isLogin"];
        
        [userDefaults setInteger:1 forKey:@"userId"];
        
        [self.navigationController popViewControllerAnimated:YES];
        
    }else{
        StatusView* sv = [StatusView statusViewInView:self.view withText:@"邮箱或密码不正确！" width:180 height:40 color:[UIColor clearColor] y:230];
        [self performSelector:@selector(dismissStatusView:) withObject:sv afterDelay:1.5];
    }
}



-(void)dismissStatusView:(StatusView*)sv
{
    [sv removeView];
}


-(IBAction)textFieldReturnEditing:(id)sender
{
    [sender resignFirstResponder];
}

-(IBAction)backgroundTap:(id)sender
{
    [self.emailTextField resignFirstResponder];
    [self.passwordTextField resignFirstResponder];
}

@end
