//
//  FirstViewController.m
//  LifeCircle
//
//  Created by kamous on 14-3-22.
//  Copyright (c) 2014年 Jiawen Wang. All rights reserved.
//

#import "IndexViewController.h"

@interface IndexViewController ()
@property (nonatomic,strong) NSDictionary* menuItems;
@end

@implementation IndexViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.menuItems = [ NSDictionary dictionaryWithObjectsAndKeys:@"美食",@"0",
                 @"电影",@"1",
                 @"KTV",@"2",
                 @"购物",@"3",nil];
    
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.menuItems.count;
}
// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"menuItem"forIndexPath:indexPath];
    
    UIImageView * imageView = (UIImageView*)[cell viewWithTag:1];
    NSString *imageName  =[NSString stringWithFormat:@"%d@2x.png",indexPath.row];
    imageView.image = [UIImage imageNamed:imageName];
    
    UILabel * label = (UILabel*)[cell viewWithTag:2];
    label.text = [self.menuItems objectForKey:[NSString stringWithFormat:@"%d",indexPath.row]];
    
    return cell;
}

@end
