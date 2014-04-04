//
//  DropDownListView.m
//  LifeCircle
//
//  Created by kamous on 14-3-31.
//  Copyright (c) 2014年 Jiawen Wang. All rights reserved.
//

#import "DropDownListView.h"
#define DROPDOWNCELL_IDENTIFY @"DropDownViewCell"

@implementation DropDownListView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(id)initWithFrame:(CGRect)frame data:(NSDictionary*)data backgroundColor:(UIColor*)color
{
    self = [super initWithFrame:frame];
    if(self)
    {
        self.data = data;
        self.backgroundColor = color;
        self.tableView = [[UITableView alloc]initWithFrame:frame];
        self.tableView.separatorColor = [UIColor colorWithWhite:0 alpha:1];
        self.tableView.backgroundColor = [UIColor clearColor];
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        [self addSubview:self.tableView];
        
    }
    return self;
}

-(void)showInView:(UIView*)view animated:(BOOL)animated
{
    [view addSubview:self];
    if(animated)
    {
        [self fadeIn];
    }
}


-(void)fadeIn
{
    self.transform = CGAffineTransformMakeScale(1.3,1.3);
    self.alpha = 0;
    [UIView animateWithDuration:0.35 animations:^{
        self.alpha = 1;
        self.transform= CGAffineTransformMakeScale(1, 1);
    }];
}


-(void)fadeOut
{
    [UIView animateWithDuration:0.35 animations:^{
        self.transform = CGAffineTransformMakeScale(1.3, 1.3);
    }completion:^(BOOL isFinished){
        if(isFinished)
        {
            [self removeFromSuperview];
        }
        
    }];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.data count];
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:DROPDOWNCELL_IDENTIFY];
    if(!cell)
    {
        [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:DROPDOWNCELL_IDENTIFY];
        cell = [tableView dequeueReusableCellWithIdentifier:DROPDOWNCELL_IDENTIFY];
    }
    cell.textLabel.text = [self.data objectForKey:[NSString stringWithFormat:@"%d",[indexPath row]+1]];
    
    [cell.textLabel setTextColor:[UIColor colorWithRed:0 green:0.3 blue:0.9 alpha:1] ];
    [cell.textLabel setFont:[cell.textLabel.font fontWithSize:17]];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if(self.delegate && [self.delegate respondsToSelector:@selector(dropDownListView:didSelectedIndex:)])
    {
        [self.delegate dropDownListView:self didSelectedIndex:indexPath];
    }
    [self fadeOut];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
