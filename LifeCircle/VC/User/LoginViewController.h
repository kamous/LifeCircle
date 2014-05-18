//
//  LoginViewController.h
//  LifeCircle
//
//  Created by kamous on 14-4-4.
//  Copyright (c) 2014年 Jiawen Wang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;

- (IBAction)login:(id)sender;

-(IBAction)textFieldReturnEditing:(id)sender;

-(IBAction)backgroundTap:(id)sender;
@end
