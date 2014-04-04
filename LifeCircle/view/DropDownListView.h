//
//  DropDownListView.h
//  LifeCircle
//
//  Created by kamous on 14-3-31.
//  Copyright (c) 2014年 Jiawen Wang. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol DropDownListDelegate;

@interface DropDownListView : UIView<UITableViewDataSource,UITableViewDelegate>


@property (nonatomic,strong) NSDictionary* data;
@property (nonatomic,assign) UIColor* backgroundColor;
@property (nonatomic,strong) UITableView* tableView;
@property (nonatomic,weak) id<DropDownListDelegate> delegate;

-(id)initWithFrame:(CGRect)frame data:(NSDictionary*)data backgroundColor:(UIColor*)color;
-(void)showInView:(UIView*)view animated:(BOOL)animated;
-(void)fadeIn;
-(void)fadeOut;


@end



@protocol DropDownListDelegate<NSObject>

-(void)dropDownListView:(DropDownListView*)dropdownListView didSelectedIndex:(NSIndexPath*)index;
//-(void)DropDownListView:(DropDownListView *)dropdownListView data:(NSArray*)data;
-(void)dropDownListViewDidCancel;

@end