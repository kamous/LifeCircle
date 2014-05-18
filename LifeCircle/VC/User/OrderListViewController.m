//
//  OrderListViewController.m
//  LifeCircle
//
//  Created by kamous on 14-4-4.
//  Copyright (c) 2014年 Jiawen Wang. All rights reserved.
//

#import "OrderListViewController.h"
#import "StatusView.h"
#import "Order.h"
#import "Product.h"
#import "AsyncImageView.h"
#import "config.h"
#import "JSONKit.h"
#import "GradeViewController.h"

@interface OrderListViewController ()

@end

@implementation OrderListViewController

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
    self.tableView.delegate = self;
    
    self.automaticallyAdjustsScrollViewInsets = YES;
    
    self.orderList = [[NSMutableArray alloc]init];
	// Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated
{
    int userId = (int)[[NSUserDefaults standardUserDefaults] integerForKey:@"userId"];
    if(IS_ON_LINE)
    {
        if(userId!=0)
        {
            self.netWorkManager = [[NetWorkManager alloc] initWithUrlString:@"showOrderListByUserId" parameters:[NSString stringWithFormat:@"?userId=%d",userId]];
            self.netWorkManager.delegate = self;
            [self.netWorkManager startWork];
        }
    }else{
        NSString *jsonStr = @"{\"errorMsg\":\"\",\"orderList\":[{\"product\":{\"pics\":\"003.jpg\",\"price\":99.9,\"name\":\"禅石（鼎滋味焖锅）\",\"productId\":3},\"count\":1,\"date\":\"2014-04-18\",\"orderId\":18,\"totalPrice\":99.9},{\"product\":{\"pics\":\"003.jpg\",\"price\":99.9,\"name\":\"禅石（鼎滋味焖锅）\",\"productId\":3},\"count\":1,\"date\":\"2014-04-18\",\"orderId\":17,\"totalPrice\":99.9},{\"product\":{\"pics\":\"002.jpg\",\"price\":26,\"name\":\"洪山天河国际影城\",\"productId\":2},\"count\":1,\"date\":\"2014-04-18\",\"orderId\":16,\"totalPrice\":26},{\"product\":{\"pics\":\"002.jpg\",\"price\":26,\"name\":\"洪山天河国际影城\",\"productId\":2},\"count\":3,\"date\":\"2014-04-11\",\"orderId\":2,\"totalPrice\":78}]}";
        NSDictionary* dic = [jsonStr objectFromJSONString];
        
        NSArray* orderDicList = [dic objectForKey:@"orderList"];
        for(int i=0;i<[orderDicList count];i++)
        {
            Order * order = [Order orderFromJsonDic:[orderDicList objectAtIndex:i]];
            [self.orderList addObject:order];
        }
       // [self.tableView reloadData];
    }

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark TableViewDelegate

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.orderList count];
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"orderCell"];
   
    
    UIImageView *imageView = (UIImageView*)[cell viewWithTag:501];
    
    Order* order = [self.orderList objectAtIndex:indexPath.row];
    UILabel* nameLabel = (UILabel*)[cell viewWithTag:502];
    UILabel* priceLabel = (UILabel*)[cell viewWithTag:503];
    UILabel* countLabel = (UILabel*)[cell viewWithTag:504];
    UILabel* timeLabel = (UILabel*)[cell viewWithTag:505];
    
    NSDateFormatter* dateFromatter = [[NSDateFormatter alloc]init];
    [dateFromatter setDateFormat:@"yyyy-mm-dd"];
    
    nameLabel.text = order.product.name;
    priceLabel.text = [NSString stringInPriceFormat:order.product.price];
    countLabel.text = [NSString stringWithFormat:@"%d",order.count];
    timeLabel.text = [dateFromatter stringFromDate:order.date];
    if(IS_ON_LINE)
    {
        imageView.imageURL =[NSURL URLWithString: order.product.pics];
    }else
    {
        imageView.image = [UIImage imageNamed:order.product.pics];
    }
    
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Order* order = [self.orderList objectAtIndex:indexPath.row];
    Product * product = order.product;
    
    
}


#pragma mark NetWorkDelegate
-(void)netWorkFinished:(NetWorkManager *)netWorkManager dic:(NSDictionary *)dic
{
    NSString* errorStr = [dic objectForKey:@"errorMsg"];
    
    if(errorStr ==nil || [errorStr isEqualToString:@""])
    {
        NSArray* orderDicList = [dic objectForKey:@"orderList"];
        for(int i=0;i<[orderDicList count];i++)
        {
            Order * order = [Order orderFromJsonDic:[orderDicList objectAtIndex:i]];
            [self.orderList addObject:order];
        }
        [self.tableView reloadData];
    }else{
        StatusView* sv = [StatusView statusViewInView:self.view withText:errorStr width:180 height:40 color:[UIColor clearColor] y:430];
        [self performSelector:@selector(dismissStatusView:) withObject:sv afterDelay:1.5];
        
        
    }

}

-(void)netWorkFailed:(NetWorkManager *)netWorkManager dic:(NSDictionary *)dic
{
    NSString* errorStr = [dic objectForKey:@"errorMsg"];
    StatusView* sv = [StatusView statusViewInView:self.view withText:errorStr width:180 height:40 color:[UIColor clearColor] y:430];
    [self performSelector:@selector(dismissStatusView:) withObject:sv afterDelay:1.5];
}


-(void)dismissStatusView:(StatusView*)sv
{
    [sv removeView];
}

-(void)jumpToLoginPage
{
    [self performSegueWithIdentifier:@"loginSegue" sender:self];
}

-(void)jumpToOrderList
{
    [self performSegueWithIdentifier:@"orderListSegue" sender:self];
}



-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"gradeSegue"])
    {
        //Product * product = [self.orderList objectAtIndex: self.tableView.indexPathForSelectedRow.row] ;
        Order * order = [self.orderList objectAtIndex: self.tableView.indexPathForSelectedRow.row] ;
        GradeViewController* gradeVC = (GradeViewController*)segue.destinationViewController;
        gradeVC.order = order;
        /*
        self.infoViewVC = infoVC;
        if(self.netWorkManager)
        {
            [self.netWorkManager setUrlString:@"showProductById" parameters:[NSString stringWithFormat:@"?productId=%d",product.productId]];
        }else{
            self.netWorkManager = [[NetWorkManager alloc]initWithUrlString:@"showProductById" parameters:[NSString stringWithFormat:@"?productId=%d",product.productId]];
            self.netWorkManager.delegate = self;
        }
        
        [self.netWorkManager startWork];
         */
    }
    
}

@end
