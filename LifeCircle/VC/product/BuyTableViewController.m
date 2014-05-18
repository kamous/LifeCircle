//
//  BuyTableViewController.m
//  LifeCircle
//
//  Created by kamous on 14-4-16.
//  Copyright (c) 2014年 Jiawen Wang. All rights reserved.
//

#import "BuyTableViewController.h"
#import "NSString+Price.h"

@interface BuyTableViewController ()

@end

@implementation BuyTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tableView.scrollEnabled = NO;
    
    self.priceLabel.text = [NSString stringInPriceFormat:self.product.price];
    self.totalPriceLabel.text = [NSString stringInPriceFormat:self.product.price];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

 */

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 50;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if(self.product.name && ![self.product.name isEqualToString:@""])
    {
        return self.product.name;
    }
    return @"确认订单";
    
}

- (IBAction)addCountClick:(id)sender {
    int count =  self.countTextField.text.intValue;
    self.countTextField.text = [NSString stringWithFormat:@"%d",++count];
    self.totalPriceLabel.text = [NSString stringInPriceFormat:count*self.priceLabel.text.doubleValue];
}
- (IBAction)minusCountClick:(id)sender {
    
    int count =  self.countTextField.text.intValue;

    if(count>1)
    {
        self.countTextField.text = [NSString stringWithFormat:@"%d",--count];
        self.totalPriceLabel.text = [NSString stringInPriceFormat:count*self.priceLabel.text.doubleValue];

    }
}

@end
