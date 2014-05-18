//
//  RegisterViewController.m
//  LifeCircle
//
//  Created by kamous on 14-4-4.
//  Copyright (c) 2014年 Jiawen Wang. All rights reserved.
//

#import "RegisterViewController.h"
#import "StatusView.h"
@interface RegisterViewController ()

@end

@implementation RegisterViewController

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

- (IBAction)regist:(id)sender {
    if(self.userNameTextField.text.length==0)
    {
        StatusView* sv = [StatusView statusViewInView:self.view withText:@"用户名不能为空！" width:180 height:40 color:[UIColor clearColor]  y:230];
        [self performSelector:@selector(dismissStatusView:) withObject:sv afterDelay:1.5];
    }else if(self.emailTextField.text.length==0)
    {
        StatusView* sv = [StatusView statusViewInView:self.view withText:@"邮箱不能为空！" width:180 height:40 color:[UIColor clearColor] y:230];
        [self performSelector:@selector(dismissStatusView:) withObject:sv afterDelay:1.5];
    }else if(self.passwordTextField.text.length == 0)
    {
        StatusView* sv = [StatusView statusViewInView:self.view withText:@"密码不能为空！" width:180 height:40 color:[UIColor clearColor] y:230];
        [self performSelector:@selector(dismissStatusView:) withObject:sv afterDelay:1.5];
    }else
    {
        StatusView* sv = [StatusView statusViewInView:self.view withText:@"注册成功，请登录！" width:180 height:40 color:[UIColor clearColor] y:230];
        [self performSelector:@selector(dismissStatusView:) withObject:sv afterDelay:1];
        
        [self performSelector:@selector(popViewControllerAnimated:) withObject:[NSNumber numberWithBool:YES] afterDelay:1.5];
        //[self.navigationController popViewControllerAnimated:YES];
        
    }
    
}


-(void)popViewControllerAnimated:(NSNumber*)number
{
    [self.navigationController popViewControllerAnimated:number.boolValue];
    
   // [self.navigationController.presentingViewController performSegueWithIdentifier:@"loginSegue" sender:nil];
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
    [self.userNameTextField resignFirstResponder];
    [self.emailTextField resignFirstResponder];
    [self.passwordTextField resignFirstResponder];
}



@end
