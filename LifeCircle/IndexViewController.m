//
//  FirstViewController.m
//  LifeCircle
//
//  Created by kamous on 14-3-22.
//  Copyright (c) 2014年 Jiawen Wang. All rights reserved.
//

#import "IndexViewController.h"
#import "ListViewController.h"
#import "Product.h"
#import "Store.h"
#import "City.h"
#import "AsyncImageView.h"
#import "config.h"
#import "InfoViewController.h"

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
    
    self.adProductList = [self preLoadTestData];
    
    self.csView = [[XLCycleScrollView alloc] initWithFrame:CGRectMake(0, 66, 320, 180)];
    self.csView.delegate = self;
    self.csView.datasource = self;
    [self.view addSubview:self.csView];
    
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark UICollectionViewDelegate

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.menuItems.count;
}
// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"menuItem"forIndexPath:indexPath];
    
    UIImageView * imageView = (UIImageView*)[cell viewWithTag:1];
    NSString *imageName  =[NSString stringWithFormat:@"%ld@2x.png",(long)indexPath.row];
    imageView.image = [UIImage imageNamed:imageName];
    
    UILabel * label = (UILabel*)[cell viewWithTag:2];
    label.text = [self.menuItems objectForKey:[NSString stringWithFormat:@"%ld",(long)indexPath.row]];
    
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    self.netWorkManager = [[NetWorkManager alloc] initWithUrlString:@"showProductsInPage" parameters:[NSString stringWithFormat:@"%@%ld",@"?typeId=",indexPath.row+1]];
    self.netWorkManager.delegate = self;
    [self.netWorkManager startWork];
}


#pragma mark NetWorkDelegate

-(void)netWorkFailed:(NetWorkManager *)netWorkManager dic:(NSDictionary *)dic
{
    NSLog(@"Network error:%@",netWorkManager.request.error);
}

-(void)netWorkFinished:(NetWorkManager *)netWorkManager dic:(NSDictionary *)dic
{
    NSString* errorStr = [dic objectForKey:@"errorMsg"];
    Product* product;
    NSDictionary* productDic;
    if(errorStr==nil || errorStr.length==0)
    {
        NSArray * products = [dic objectForKey:@"productList"];
        if(products)//分类页面进入
        {
            for(int i=0;i<[products count];i++)
            {
                productDic = [products objectAtIndex:i];
                product = [Product productFromJsonDic:productDic];
                [self.listVC.productList addObject:product];
                self.listVC.listType = eIndexType;
            }
            [self.listVC.tableView reloadData];
        }
        
        NSDictionary* productDic = [dic objectForKey:@"product"];
        if(productDic)//广告页面进入
        {
            self.infoVC.product = [Product productFromJsonDic:productDic];;
            [self.infoVC.tableView reloadData];
        }
        
        
    }
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"indexTypeList"])
    {
        ListViewController* listVC = segue.destinationViewController;
        [listVC.navBar setTitle: @"商品列表"];
        self.listVC = listVC;
        self.listVC.listType = eIndexType;
    }else if([segue.identifier isEqualToString:@"infoSegue"])
    {
        self.infoVC = segue.destinationViewController;
        self.infoVC.product = [self.adProductList objectAtIndex:self.csView.currentPage];
        
        if(self.netWorkManager)
        {
            [self.netWorkManager setUrlString:@"showProductById" parameters:[NSString stringWithFormat:@"?productId=%d",self.infoVC.product.productId]];
        }else{
            self.netWorkManager = [[NetWorkManager alloc]initWithUrlString:@"showProductById" parameters:[NSString stringWithFormat:@"?productId=%d",self.infoVC.product.productId]];
            self.netWorkManager.delegate = self;
        }
        
        [self.netWorkManager startWork];

        
    }
}

-(NSArray*)preLoadTestData
{
    City* c1 = [[City alloc] initWithName:@"武汉" cityId:2];
    // City* c2 = [[City alloc] initWithName:@"北京" cityId:1];
    
    Store *s1 = [[Store alloc]initWithName:@"尚品宫韩式烤肉"
                                   storeId:1
                                      city:c1
                                     phone:@"027-59109655"
                               locationStr:@"洪山区虎泉街地铁2号线虎泉站B出口凯乐桂园美乐汇美食休闲广场2楼"
                                       lon:1
                                       lat:1];
    Store *s2 = [[Store alloc]initWithName:@"鼎滋味焖锅箸意（乐天城店）"
                                   storeId:1
                                      city:c1
                                     phone:@"027-87776700"
                               locationStr:@"洪山区珞喻路4号街道口乐天城3楼10号商铺"
                                       lon:1
                                       lat:1];
    
    Store *s3 = [[Store alloc]initWithName:@"洪山天河国际影城"
                                   storeId:1
                                      city:c1
                                     phone:@"027-87882649-805"
                               locationStr:@"洪山区珞瑜路6号乐天城购物中心6楼（群光广场旁）"
                                       lon:1
                                       lat:1];
    
    //  Type * t1 = [[Type alloc] initWithName:@"美食" typeId:1];
    
    //  Type * t2 = [[Type alloc] initWithName:@"电影" typeId:2];
    
    Product *p1 = [[Product alloc] initWithName:@"尚品宫韩式烤肉"
                                      productId:1
                                          price:45.01
                                           info:@"【虎泉/关西】仅售45元！价值58元的尚品宫韩式烤肉单人自助晚餐，提供免费WiFi。正宗韩式自助烤肉，来自韩国的宫廷美味，费汤羹类，水果类，凉菜类，啤酒，饮料，糕点，冰淇淋可随意自取"
                                    description:@"开业期间每位来宾送10元现金券1张\
                   免费提供20个停车位\
                   提供免费WiFi\
                   团购用户不可同时享受商家其他优惠\
                   90cm以下儿童（含90cm）免费，90cm-1.2米（含）儿童可享受24元/位，1.2米（不含）以上儿童按成人价收费。每位收费成人限带1名免票儿童\
                   提供免费WiFi\
                   团购用户不可同时享受商家其他优惠\
                   为了您的就餐质量，建议20:00前入场\
                   部分菜品因时令原因有所不同，请以店内当日实际供应为准"
                   
                                          store:s1
                                           pics:@"001.jpg"];
    
    Product *p2 = [[Product alloc] initWithName:@"洪山天河国际影城"
                                      productId:2
                                          price:26
                                           info:@"【石碑岭/街道口】仅售26元！价值70元的洪山天河国际影城2D电影票1张，到店另付5元可观看3D电影，如遇限价片，需到店补齐差价。"
                                    description:@"电话咨询时间：周一到周五09:00-17:00\
                   现场选座，首映式/见面会不可使用\
                   每张美团券仅限兑换观影当日场次电影票\
                   使用3D眼镜，需要交纳押金50元/副，如无损坏，押金如数退还，请妥善使用\
                   1.3米及以下儿童在成人陪同下可免费观看2D电影，无座位，且每位成人限带1名儿童，1.3米（不含）以上儿童没有特\殊优惠，也需购买1张美团券\
                   限价片 1 补差价规则以影院公告为准"
                                          store:s2
                                           pics:@"002.jpg"];
    Product *p3 = [[Product alloc] initWithName:@"禅石（鼎滋味焖锅）"
                                      productId:3
                                          price:99.90
                                           info:@"仅售99.9元！最高价值186元的禅石（鼎滋味焖锅）3-4人餐，商家提供免费WiFi。"
                                    description:@"美味共享\
                   内容 单价 数量/规格 小计\
                   以下套餐2选1\
                   99.9元禅石方案\
                   以下10选2（不可重复选）\
                   白灼生菜 18元 1份 18元\
                   米酒果园 18元 1份 18元\
                   开胃双脆 18元 1份 18元\
                   椒油杏鲍菇 16元 1份 16元\
                   黄晶小土豆 19元 1份 19元\
                   麻婆豆腐 16元 1份 16元\
                   小白菜千张 18元 1份 18元\
                   清炒莴苣片 18元 1份 18元\
                   酸辣藕丁 18元 1份 18元\
                   鱼香茄子 22元 1份 22元"
                                          store:s3
                                           pics:@"003.jpg"];
    return [NSArray arrayWithObjects:p1,p2,p3, nil];
}



#pragma mark CycleScrollViewDelegate

- (NSInteger)numberOfPages
{
    return self.adProductList.count;
}

- (UIView *)pageAtIndex:(NSInteger)index
{
//    UILabel *l = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320, 180)];
//    l.text = [NSString stringWithFormat:@"%ld",(long)index];
//    l.font = [UIFont systemFontOfSize:72];
//    l.textAlignment = NSTextAlignmentCenter;
//    l.backgroundColor = [UIColor blueColor];
    
    UIImageView* imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 320, 180)];
    Product * product = (Product*)[self.adProductList objectAtIndex:index];
    
   
    imageView.image = [UIImage imageNamed:product.pics];
    
    return imageView;
   // return l;
}

- (void)didClickPage:(XLCycleScrollView *)csView atIndex:(NSInteger)index
{
 
    [self performSegueWithIdentifier:@"infoSegue" sender:nil];
  //  [alert show];
}



@end
