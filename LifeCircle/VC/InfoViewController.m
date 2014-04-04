//
//  InfoViewController.m
//  LifeCircle
//
//  Created by kamous on 14-4-4.
//  Copyright (c) 2014年 Jiawen Wang. All rights reserved.
//

#import "InfoViewController.h"
#import "ImageCell.h"
#import "PriceLabelCell.h"
#import "StoreCell.h"
#import "DescriptionCell.h"


@interface InfoViewController ()

@end

@implementation InfoViewController

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
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.tableView registerNib:[UINib nibWithNibName:@"ImageCell" bundle:nil] forCellReuseIdentifier:@"imageCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"PriceLabelCell" bundle:nil] forCellReuseIdentifier:@"priceLabelCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"StoreCell" bundle:nil] forCellReuseIdentifier:@"storeCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"DescriptionCell" bundle:nil] forCellReuseIdentifier:@"descriptionCell"];
    
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    int row = indexPath.row;
    UITableViewCell* cell = NULL;
    switch (row) {
        case 0:
            cell = (ImageCell*)[tableView dequeueReusableCellWithIdentifier:@"imageCell"];
            cell.imageView.image = [UIImage imageNamed:@"001.jpg"];
            break;
        case 1:
            cell = (PriceLabelCell*)[tableView dequeueReusableCellWithIdentifier:@"priceLabelCell"];
            break;
        case 2:
            cell = (StoreCell*)[tableView dequeueReusableCellWithIdentifier:@"storeCell"];
            break;
        case 3:
            cell = (DescriptionCell*)[tableView dequeueReusableCellWithIdentifier:@"descriptionCell"];
            break;
            
            
        default:
            cell = (ImageCell*)[tableView dequeueReusableCellWithIdentifier:@"imageCell"];
            cell.imageView.image = [UIImage imageNamed:@"001.jpg"];
            break;

            break;
    }
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    float height = 40;
    int row = indexPath.row;
    switch (row) {
        case 0:
            height = 150;
            break;
        case 1:
            height = 65;
            break;
            
        case 2:
            height = 70;
            break;
            
        case 3:
        {
            DescriptionCell * cell = (DescriptionCell*)[tableView dequeueReusableCellWithIdentifier:@"descriptionCell"];
            NSString * descriptionStr = cell.descriptionLabel.text;
            CGRect rect = [descriptionStr boundingRectWithSize:CGSizeMake(282, 1000) options:NSStringDrawingUsesLineFragmentOrigin  attributes:nil context:nil];
            
            CGSize fontSize = [descriptionStr sizeWithFont:cell.descriptionLabel.font forWidth:cell.descriptionLabel.frame.size.width lineBreakMode:NSLineBreakByWordWrapping];
            height = rect.size.height + 45;
            break;
        }
        default:
            
            break;
    }
    return height;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}



@end
