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
#import "AsyncImageView.h"
#import "Product.h"
#import "NSString+Price.h"
#import "Store.h"
#import "BuyViewController.h"
#import "config.h"

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
    self.automaticallyAdjustsScrollViewInsets = YES;
   // [self.tableView registerNib:[UINib nibWithNibName:@"ImageCell" bundle:nil] forCellReuseIdentifier:@"imageCell"];
    [self.tableView registerClass:[ImageCell class] forCellReuseIdentifier:@"imageCell"];
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

#pragma mark TableViewDelegate

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    int row = indexPath.row;
    UITableViewCell* cell = NULL;
    switch (row) {
        case 0:
        {
            ImageCell* imageCell = (ImageCell*)[tableView dequeueReusableCellWithIdentifier:@"imageCell"];
            
            //cancel loading previous image for cell
            //[[AsyncImageLoader sharedLoader] cancelLoadingImagesForTarget:imageCell.productImageView];
            
            //UIImageView* asyncImageView = (UIImageView*)[imageCell viewWithTag:101];
          //  imageCell.productImageView.image =  [UIImage imageNamed:@"001.jpg"];

            if(IS_ON_LINE)
            {
                imageCell.productImageView.imageURL = [NSURL URLWithString:self.product.pics];
            }else{
                imageCell.productImageView.image =  [UIImage imageNamed:self.product.pics];
            }
            cell = imageCell;
            
           // [[AsyncImageLoader sharedLoader]loadImageWithURL:[NSURL URLWithString:self.product.pics] ];
            //[AsyncImageLoader load];
            //cell.imageView.image = [UIImage imageNamed:@"001.jpg"];
            break;
        }
        case 1:
        {
            PriceLabelCell *priceLabelCell = (PriceLabelCell*)[tableView dequeueReusableCellWithIdentifier:@"priceLabelCell"];
            
            priceLabelCell.delegate = self;
            priceLabelCell.priceLabel.text = [NSString stringInPriceFormat: self.product.price ];
            cell = priceLabelCell;
            
            break;
        }
        case 2:
        {
            StoreCell *storeCell = (StoreCell*)[tableView dequeueReusableCellWithIdentifier:@"storeCell"];
            storeCell.storeNameLabel.text = self.product.name;
            storeCell.storeLocationLable.text = self.product.store.locationStr;
            storeCell.storeDistanceLabel.text = @"200m";
            
            cell = storeCell;
            break;
        }
        case 3:
        {
            DescriptionCell *descriptionCell = (DescriptionCell*)[tableView dequeueReusableCellWithIdentifier:@"descriptionCell"];
            descriptionCell.descriptionLabel.text = self.product.description;
            cell = descriptionCell;
            break;
            
        }
        default:
            cell = (ImageCell*)[tableView dequeueReusableCellWithIdentifier:@"imageCell"];
            cell.imageView.image = NULL;
           // cell.imageView.image = [UIImage imageNamed:@"001.jpg"];
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
            height = 58;
            break;
            
        case 2:
            height = 75;
            break;
            
        case 3:
        {
           // DescriptionCell * cell = (DescriptionCell*)[tableView dequeueReusableCellWithIdentifier:@"descriptionCell"];
            NSString * descriptionStr = self.product.description;
            
            NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
            paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
            NSDictionary * attributes = @{NSFontAttributeName:[UIFont fontWithName:@"HelveticaNeue" size:16],NSParagraphStyleAttributeName:paragraphStyle};
            
            //ios7 fontsize
            CGRect rect = [descriptionStr boundingRectWithSize:CGSizeMake(282, 1000) options:NSStringDrawingUsesLineFragmentOrigin  attributes:attributes context:nil];
            
            height = rect.size.height + 85;
            break;
        }  
        default:
            
            break;
    }
    return height;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

-(BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row == 2)
        return YES;
    return NO;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
   
    return 4;
}



-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 1;
}




-(void)buyClick:(id)sender{
    [self performSegueWithIdentifier:@"buySegue" sender:self];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"buySegue"])
    {
        BuyViewController * buyVC =  segue.destinationViewController;
        buyVC.product = self.product;
    }

}
@end
