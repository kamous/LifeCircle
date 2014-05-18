//
//  ListViewController.m
//  LifeCircle
//
//  Created by kamous on 14-3-23.
//  Copyright (c) 2014年 Jiawen Wang. All rights reserved.
//

#import "ListViewController.h"
#import "DropDownListView.h"
#import "City.h"
#import "Store.h"
#import "Product.h"
#import "Type.h"
#import "AsyncImageView.h"
#import "InfoViewController.h"
#import "NSString+Price.h"
#import "JSONKit.h"

#import "config.h"



@interface ListViewController ()
@property (nonatomic,strong) NSDictionary* sortList;
@property (nonatomic,strong) NSDictionary* typeList;
@property (nonatomic,assign) int selectedSortRow;
@property (nonatomic,assign) int selectedTypeRow;

@end

@implementation ListViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [self.locationManager stopUpdatingHeading];
}



- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    

    self.sortList = [NSDictionary  dictionaryWithObjectsAndKeys:@"按距离排序",[NSString stringWithFormat:@"%d",eLocation],
                              @"按价格排序",[NSString stringWithFormat:@"%d",ePrice],
                              @"按评分排序",[NSString stringWithFormat:@"%d",eScore],
                              @"智能排序",[NSString stringWithFormat:@"%d",eRecommend],nil];


    self.typeList = [NSDictionary  dictionaryWithObjectsAndKeys:@"全部",@"0",
                              @"美食",@"1",
                              @"电影",@"2",
                              @"KTV",@"3",
                              @"其它",@"4", nil];
    
}

-(void)viewWillAppear:(BOOL)animated
{

    if(IS_ON_LINE)//联网情况
    {
        //  self.list = [NSArray arrayWithObjects:@"xxx",@"ddd",@"aaa", nil];
        if(!self.productList)
        {
            self.productList = [[NSMutableArray alloc]init];
        }
        
        if(self.listType == eSroundType)//周边推荐
        {
            self.locationManager = [[CLLocationManager alloc]init];
            if([CLLocationManager locationServicesEnabled])
            {
                self.locationManager.delegate = self;
                self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
                self.locationManager.distanceFilter = 100.0f;
                [self.locationManager startUpdatingLocation];
                
            }else{
                NSLog(@"位置服务不可用");
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"位置服务不可用"
                                                                message:@"请先打开定位功能，并允许本应用定位" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
                [alert show];
            }

            if(self.location.coordinate.longitude>0)
            {
                NSString* parameter = [NSString stringWithFormat:@"?typeId=%d&&orderBy=%d&&rows=6&&order=asc&&lon=%f&&lat=%f",self.selectedTypeRow,self.selectedSortRow,self.location.coordinate.longitude,self.location.coordinate.latitude];
                
                self.netWorkManager = [[NetWorkManager alloc] initWithUrlString:@"showProductsInPage" parameters:parameter];
                self.netWorkManager.delegate = self;
                [self.netWorkManager startWork];
            }
            
        }else if(self.listType == eIndexType)//从主页分类进入
        {
            
        }
        
    }else{
        self.productList = [NSMutableArray arrayWithArray:[self preLoadTestData]];
        
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
    
    
    NSString* json = @"{\"productList\":[{\"pics\":\"001.jpg\",\"price\":45,\"store\":{\"lon\":1,\"phone\":\"027-59109655\",\"locationStr\":\"洪山区虎泉街地铁2号线虎泉站B出口凯乐桂园美乐汇美食休闲广场2楼\",\"name\":\"尚品宫韩式烤肉\",\"storeId\":1,\"lat\":0,\"info\":\"\"},\"description\":\"开业期间每位来宾送10元现金券1张\n免费提供20个停车位\n提供免费WiFi\n团购用户不可同时享受商家其他优惠\n90cm以下儿童（含90cm）免费，90cm-1.2米（含）儿童可享受24元/位，1.2米（不含）以上儿童按成人价收费。每位收费成人限带1名免票儿童\n提供免费WiFi\n团购用户不可同时享受商家其他优惠\n为了您的就餐质量，建议20:00前入场\n部分菜品因时令原因有所不同，请以店内当日实际供应为准\",\"name\":\"尚品宫韩式烤肉\",\"info\":\"【虎泉/关西】仅售45元！价值58元的尚品宫韩式烤肉单人自助晚餐，提供免费WiFi。正宗韩式自助烤肉，来自韩国的宫廷美味，费汤羹类，水果类，凉菜类，啤酒，饮料，糕点，冰淇淋可随意自取\",\"productId\":1},{\"pics\":\"002.jpg\",\"price\":26,\"store\":{\"lon\":0,\"phone\":\"027-87882649-805\",\"locationStr\":\"洪山区珞瑜路6号乐天城购物中心6楼（群光广场旁）\",\"name\":\"洪山天河国际影城\",\"storeId\":3,\"lat\":0,\"info\":\"\"},\"description\":\"电话咨询时间：周一到周五09:00-17:00\n现场选座，首映式/见面会不可使用\n每张美团券仅限兑换观影当日场次电影票\n使用3D眼镜，需要交纳押金50元/副，如无损坏，押金如数退还，请妥善使用\n1.3米及以下儿童在成人陪同下可免费观看2D电影，无座位，且每位成人限带1名儿童，1.3米（不含）以上儿童没有特殊优惠，也需购买1张美团券\n 限价片 1 补差价规则以影院公告为准\",\"name\":\"洪山天河国际影城\",\"info\":\"【石碑岭/街道口】仅售26元！价值70元的洪山天河国际影城2D电影票1张，到店另付5元可观看3D电影，如遇限价片，需到店补齐差价。\",\"productId\":2},{\"pics\":\"003.jpg\",\"price\":99.9,\"store\":{\"lon\":0,\"phone\":\"027-87776700\",\"locationStr\":\"洪山区珞喻路4号街道口乐天城3楼10号商铺\",\"name\":\"鼎滋味焖锅箸意（乐天城店）\",\"storeId\":2,\"lat\":0,\"info\":\"\"},\"description\":\"美味共享\n内容 单价 数量/规格 小计\n以下套餐2选1\n99.9元禅石方案\n以下10选2（不可重复选）\n白灼生菜 18元 1份 18元\n米酒果园 18元 1份 18元\n开胃双脆 18元 1份 18元\n椒油杏鲍菇 16元 1份 16元\n黄晶小土豆 19元 1份 19元\n麻婆豆腐 16元 1份 16元\n小白菜千张 18元 1份 18元\n清炒莴苣片 18元 1份 18元\n酸辣藕丁 18元 1份 18元\n鱼香茄子 22元 1份 22元\n以下10选1\n腊肉菜薹 26元 1份 26元\n外婆茄子煲 29元 1份 29元\n蟹黄晶虾豆腐 28元 1份 28元\n招牌吊烧鸭（半只） 32元 1份 32元\n小炒野山笋 39元 1份 39元\n傣家烧烤肉 39元 1份 39元\n砂锅娃娃菜 28元 1份 28元\n香煎武昌鱼 32元 1份 32元\n蜜汁樱桃肉 39元 1份 39元\n椒盐玉米 26元 1份 26元\n以下8选1\n酸菜鱼锅 68元 1份 68元\n排骨藕锅 68元 1份 68元\n萝卜牛杂锅 68元 1份 68元\n海鲜豆腐锅 68元 1份 68元\n糖醋松子鱼 59元 1份 59元\n酸汤牛蛙 59元 1份 59元\n水煮牛肉 59元 1份 59元\n石钵小兔 59元 1份 59元\n以下3选1\n香醇黑米饮 38元 1份 38元\n红豆抹茶 38元 1份 38元\n水蜜桃汁 38元 1份 38元\n99.9元鼎滋味焖锅方案\n以下10选2（不可重复选）\n牛蛙 38元 1份 38元\n三黄鸡 32元 1份 32元\n鱿鱼 38元 1份 38元\n脱骨鸭掌 38元 1份 38元\n江鲶 36元 1份 36元\n财鱼 36元 1份 36元\n牛腩 36元 1份 36元\n蹄花 38元 1份 38元\n野兔 36元 1份 36元\n羊排 42元 1份 42元\n以下3选1\n野山笋 22元 1份 22元\n山药 22元 1份 22元\n玉米棒 22元 1份 22元\n以下10选3（不可重复选）\n馓子 9元 1份 9元\n热干面 7元 1份 7元\n平菇 9元 1份 9元\n腐竹 9元 1份 9元\n黄瓜 7元 1份 7元\n红薯 7元 1份 7元\n黑木耳 9元 1份 9元\n土豆片 7元 1份 7元\n藕片 7元 1份 7元\n娃娃菜 7元 1份 7元\n以下3选1\n香醇黑米饮 38元 1份 38元\n红豆抹茶 38元 1份 38元\n水蜜桃汁 38元 1份 38元\n以下3选1\n酱汁 10元 1份 10元\n香辣汁 10元 1份 10元\n麻辣汁 10元 1份 10元\n最高价值：186元\n\n美团价：99.9元\",\"name\":\"禅石（鼎滋味焖锅）\",\"info\":\"仅售99.9元！最高价值186元的禅石（鼎滋味焖锅）3-4人餐，商家提供免费WiFi。\",\"productId\":3},{\"pics\":\"004.jpg\",\"price\":59,\"store\":{\"lon\":0,\"phone\":\"027-87878088\",\"locationStr\":\"洪山区光谷步行街大洋百货D座5楼\",\"name\":\"欢乐空间量贩式KTV（光谷店）\",\"storeId\":4,\"lat\":0,\"info\":\" \"},\"description\":\"套餐内容\t单价\t数量/规格\t小计\n以下时段3选1\t周一至周五12:00-18:30下午场\t￥299\t1次/6.5小时\t￥299\n周六至周日12:00-18:30任选3小时\t￥168\t1次/3小时\t￥168\n周日至周四23:00-次日06:00午夜场\t￥372\t1次/7小时\t￥372\n其他\t丽丽薯片\t￥12\t1袋\t￥12\n卤味\t￥12\t1碟\t￥12\n以下饮品2选1\t福建安溪铁观音\t￥48\t1壶\t￥48\n菊花茶\t￥38\t1壶\t￥38\n最高价值: ￥444美团价： ￥59\n\n豪华中包及以下可用，最高价值以豪华中包计算\n套餐内容\t单价\t数量/规格\t小计\n2张美团券升级可享\n以下时段4选1\t周一至周日19:00-24:00豪华中包及以下包房\t￥348\t1次/3小时\t￥348\n周五至周六23:00-次日06:00豪华中包及以下包房\t￥452\t1次/7小时\t￥452\n周一至周五12:00-18:30PARTY包及以下包房\t￥429\t1次/6.5小时\t￥429\n周日至周四23:00-次日06:00PARTY包及以下包房\t￥532\t1次/7小时\t￥532\n其他\t丽丽薯片\t￥12\t1袋\t￥12\n卤味\t￥12\t1碟\t￥12\n以下饮品2选1\t福建安溪铁观音\t￥48\t1壶\t￥48\n菊花茶\t￥38\t1壶\t￥38\n最高价值: ￥604美团价： ￥118\n\n黄金档不含小吃及饮品\n黄金场团购消费的客人赠送下午场或午夜场68元3小时包吃包唱券1张，限下次使用\",\"name\":\"欢乐空间量贩式KTV（光谷店）\",\"info\":\"【光谷/鲁巷】大家爱K歌！仅售49元，最高价值444元的欢乐空间量贩式KTV欢唱套餐时段3选1，豪华中包及以下可用，适合2-10人，可升级。\",\"productId\":4},{\"pics\":\"006.jpg\",\"price\":49,\"store\":{\"lon\":0,\"phone\":\"027-81880086\",\"locationStr\":\"洪山区街道口珞瑜路4号乐天城5楼（地铁2号线街道口站B出站口出站即到）\",\"name\":\"优畅时尚KTV\",\"storeId\":6,\"lat\":0,\"info\":\" \"},\"description\":\"套餐内容\t单价\t数量/规格\t小计\n以下时段2选1\t周一至周日11:00-19:00\t￥432\t1次/6小时\t￥432\n周一至周日23:30-次日05:30\t￥447\t1次/6小时\t￥447\n赠品\t果乐（柠檬/冰糖雪梨/橙汁/芒果）\t￥0\t1扎\t￥0\n指定小吃\t￥0\t2份\t￥0\n最高价值: ￥447美团价： ￥49\n\nBOX可用\",\"name\":\"优畅时尚KTV\",\"info\":\"【石碑岭/街道口仅售49元，最高价值447元的优畅时尚KTV精选欢唱套餐（周一至周日11:00-19:00欢唱6小时/周一至周日23:30-次日05:30欢唱6小时）时段2选1，免费提供WiFi，有赠送可享，BOX可用，适合2-8人使用。\",\"productId\":6},{\"pics\":\"007.jpg\",\"price\":25.5,\"store\":{\"lon\":0,\"phone\":\"027-87575577\",\"locationStr\":\"洪山区光谷资本大厦4楼（光谷广场转盘旁）\",\"name\":\"巨幕影城（光谷广场资本大厦店）\",\"storeId\":7,\"lat\":0,\"info\":\" \"},\"description\":\"套餐内容\t单价\t数量/规格\t小计\n2D/3D电影票\t￥120\t1张\t￥120\n价值: ￥120美团价： ￥25.5\n\n观影场次：2D/3D；可观影次数：1人观影1场\n周一至周五14:00（含）-17:59（含）观影需到店另付5元，18:00（含）-21:29（含）观影需到店另付10元\n周六日、法定节假日观影需到店另付10元\n套餐内容\t单价\t数量/规格\t小计\n同时使用2张美团券可升级\n巨幕厅电影票\t￥160\t1张\t￥160\n价值: ￥160美团价： ￥51\n\n观影场次：2D/3D；可观影次数：1人观影1场\n套餐内容\t单价\t数量/规格\t小计\n同时使用3张美团券可升级\nVIP厅电影票\t￥220\t1张\t￥220\n价值: ￥220美团价： ￥76.5\n\n观影场次：2D/3D；可观影次数：1人观影1场\",\"name\":\"巨幕影城\",\"info\":\"【光谷/鲁巷】仅售25.5元！价值120元的巨幕影城电影票1张，2D/3D可兑，周六日、法定节假日观影需到店另付10元，可在巨幕影城官网在线选座、自助兑换，无需排队，也可现场兑换！\",\"productId\":7},{\"pics\":\"008.jpg\",\"price\":2013.14,\"store\":{\"lon\":0,\"phone\":\"027-87780082\",\"locationStr\":\"洪山区光谷广场尖东智能花园3栋1001（光谷转盘旁）\",\"name\":\"雨墨摄影工作室\",\"storeId\":8,\"lat\":0,\"info\":\" \"},\"description\":\"套餐内容\t单价\t数量/规格\t小计\n婚纱摄影套系\t￥9999\t1套\t￥9999\n价值: ￥9999美团价： ￥2013\n\n拍摄背景：内景5组（室内，约3小时），外景5组（花园小区+东湖沿线风景区+解放公园+洪山公园+世茂龙湾+紫阳湖公园+起义门古建筑（客户自选场地也可），约6小时）\n外景费用：外景产生任何车费需由美团会员，景点门票费和餐费需由美团会员，包含美团会员及全部工作人员\n服装造型：提供男士5套/人，女士5套/人（全场任选），最多可自带服装5套，自带服装计入总数内\n化妆造型：提供整体妆面1次/人，造型5组/人\n造型用品：店家免费提供假睫毛1对，商家不免费提供安瓶，如需要，需到店另付安瓶费50元/瓶，可自带，商家不免费提供隐形内衣，如需要，需到店另付隐形内衣费80元/件，可自带\n服务人员：摄影师1位+化妆师1位+跟妆助理1位\n拍摄精修：至少拍摄200张，共精修68张\n底片赠送：赠送全部原始底片+全部精修照片，赠送方式为美团会员自带移动硬盘拷贝传输\n其余底片：赠送张数之外如需购买，精修照片10元/张，入册15元/张\n拍摄成品：\n16英寸PVC闪耀水晶琉璃册1本（10页，25张入册）\t\n12英寸PVC闪耀水晶琉璃册1本（10页，25张入册）\t\n8英寸PVC闪耀水晶琉璃册1本（10页，18张入册）\t\n60寸结婚海报放大照片1张\t\n48寸巨幅水晶1个\t\n36寸巨幅水晶1个\t\n20寸精致蕾梦娜1个\t※以上成品照片均选自精修\n套餐内另赠送：\n14寸3D玫瑰恋人水晶1座\n10寸玫瑰海岸水晶1座\n8寸玫瑰海岸水晶1座\n7寸玫瑰海岸水晶1座\n5寸玫瑰海岸水晶1座\n魔方音乐盒1座\nVIP卡4张数码底片\n设计版面全送\n婚纱租赁：婚礼当天免费提供新娘礼服1套，可租3天（白纱可租），需另付押金500元/套，不收取改动费、清洗费，返还时礼服无损坏将退还押金\n当天妆面：商家免费赠送新婚当天妆面，美团会员可09:00-11:00到店享用\n拍摄流程\n\n拍摄：拍摄前，请提前3天预约，如约到店拍摄\n看样：拍摄当天后看样\n选样：看样7天后选样\n取件：选样30天后取件\",\"name\":\"雨墨摄影工作室\",\"info\":\"【光谷/鲁巷】仅售2013.14元！价值9999元的雨墨摄影工作室婚纱摄影套系，记录幸福瞬间，“雨”你同行，非我“墨”属~\",\"productId\":8}],\"errorMsg\":\"\"}";
    
//    NSDictionary* dic = [json objectFromJSONString];
//    NSArray* productJsonList = [dic objectForKey:@"productList"];
//    NSMutableArray * productList = [[NSMutableArray alloc]init];
//    for(int i=0;i<[productJsonList count];i++)
//    {
//        Product * product = [Product productFromJsonDic:[productJsonList objectAtIndex:i]];
//        [productList addObject:product];
//    }
    
 //   return productList;
    return [NSArray arrayWithObjects:p1,p2,p3,p2,p1,p3, nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.productList.count;
}


- (IBAction)typeClick:(id)sender {
    self.clickType = eTypeClickType;
    

    CGRect dropDownListRect = CGRectMake(0,
                                         // button.frame.origin.y + button.frame.size.height,
                                         54,
                                         //self.navigationController.navigationBar.frame.size.height,
                                         self.view.frame.size.width,
                                         ([self.typeList count]+0.99) * 40);
    
    UIColor * color = [UIColor colorWithRed:0.2 green:0.2 blue:0.2 alpha:1];
    DropDownListView *dropDownListView = [[DropDownListView alloc]initWithFrame:dropDownListRect data:self.typeList backgroundColor:color];
    dropDownListView.delegate = self;
    
    self.selectedTypeRow =  dropDownListView.tableView.indexPathForSelectedRow.row;
    [dropDownListView showInView:self.view animated:YES];
    
}


- (IBAction)sortClick:(id)sender {
    self.clickType = eSortClickType;
    
    
    // self.automaticallyAdjustsScrollViewInsets = NO;
    
    CGRect dropDownListRect = CGRectMake(0,
                                         // button.frame.origin.y + button.frame.size.height,
                                         54,
                                         //self.navigationController.navigationBar.frame.size.height,
                                         self.view.frame.size.width,
                                         ([self.sortList count]+0.99) * 40);
    
    UIColor * color = [UIColor colorWithRed:0.2 green:0.2 blue:0.2 alpha:1];
    DropDownListView *dropDownListView = [[DropDownListView alloc]initWithFrame:dropDownListRect data:self.sortList backgroundColor:color];
    dropDownListView.delegate = self;
    self.selectedSortRow =  dropDownListView.tableView.indexPathForSelectedRow.row;
    [dropDownListView showInView:self.view animated:YES];
}





-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"productInfoSegue"])
    {
        Product * product = [self.productList objectAtIndex: self.tableView.indexPathForSelectedRow.row] ;
        InfoViewController* infoVC = (InfoViewController*)segue.destinationViewController;
        infoVC.product = product;
        self.infoViewVC = infoVC;
        if(self.netWorkManager)
        {
            [self.netWorkManager setUrlString:@"showProductById" parameters:[NSString stringWithFormat:@"?productId=%d",product.productId]];
        }else{
            self.netWorkManager = [[NetWorkManager alloc]initWithUrlString:@"showProductById" parameters:[NSString stringWithFormat:@"?productId=%d",product.productId]];
            self.netWorkManager.delegate = self;
        }
        
        [self.netWorkManager startWork];
    }
    
}


#pragma mark TableViewDelgate

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    Product * product =[self.productList objectAtIndex:indexPath.row];
    
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"listCell"];
    AsyncImageView *imageView = (AsyncImageView*)[cell viewWithTag:1];
    
    if(IS_ON_LINE)
    {
        
        imageView.imageURL = [NSURL URLWithString:[product pics]];
    }else{
        imageView.image = [UIImage imageNamed:product.pics];
    }
    
    
    
    UILabel *titleLabel = (UILabel*)[cell viewWithTag:2];
  
    titleLabel.text = product.name;
    
    UILabel *infoLabel = (UILabel*)[cell viewWithTag:21];
    infoLabel.text = product.info;
    
    UILabel *priceLabel = (UILabel*)[cell viewWithTag:22];
    priceLabel.text = [NSString stringInPriceFormat:product.price];
    
    
    return cell;
}


-(void)getOrderByIndex:(int)index
{
    
}

#pragma mark DropDownListDelegate

-(void)dropDownListView:(DropDownListView*)dropdownListView didSelectedIndex:(NSIndexPath*)indexPath
{
    UIButton *button = nil;
    
    NSString* parameter = nil;
    
    
    if(self.clickType == eTypeClickType)
    {
        button = (UIButton*)[self.view viewWithTag:101];
        
        self.selectedTypeRow =  dropdownListView.tableView.indexPathForSelectedRow.row;
        
        parameter = [NSString stringWithFormat:@"?typeId=%ld&&orderBy=%d&&rows=6&&order=asc",indexPath.row,self.selectedSortRow];
        
    }else if(self.clickType == eSortClickType)
    {
        button = (UIButton*)[self.view viewWithTag:102];
        self.selectedSortRow =  dropdownListView.tableView.indexPathForSelectedRow.row;
        
        parameter = [NSString stringWithFormat:@"?typeId=%d&&orderBy=%ld&&rows=6&&order=asc",self.selectedTypeRow,indexPath.row];
    }
    
    if(self.netWorkManager)
    {
        [self.netWorkManager setUrlString:@"showProductsInPage" parameters:parameter];
        
    }else{
        self.netWorkManager =[[NetWorkManager alloc] initWithUrlString:@"showProductsInPage" parameters:parameter];
        
        self.netWorkManager.delegate = self;
    }
    
    [self.netWorkManager startWork];
    
    
    
    NSString * selectStr =[dropdownListView.data objectForKey:[NSString stringWithFormat:@"%ld",(long)indexPath.row]];
    [button setTitle:selectStr forState:UIControlStateNormal];
//    [button sizeToFit];

}
//-(void)DropDownListView:(DropDownListView *)dropdownListView data:(NSArray*)data;
-(void)dropDownListViewDidCancel
{
    
}



#pragma mark - CoreLocation

-(void)locationManager:(CLLocationManager*)manager didUpdateLocations:(NSArray*)locations
{
    if(!self.location)
    {
        self.location = [locations objectAtIndex:0];
        NSString* parameter = [NSString stringWithFormat:@"?typeId=%d&&orderBy=%d&&rows=6&&order=asc&&lon=%f&&lat=%f",self.selectedTypeRow,self.selectedSortRow,self.location.coordinate.longitude,self.location.coordinate.latitude];
        
        
        [self requestDate:parameter];
    }
    
    CLLocation * location = [locations lastObject];
    self.location = location;
    NSLog(@"当前坐标：[%f,%f]", location.coordinate.latitude,location.coordinate.longitude);
}

- (void)locationManager:(CLLocationManager *)manager
       didFailWithError:(NSError *)error
{
    NSLog(@"【Location Error】:%@",error);
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"位置服务不可用"
                                                    message:@"请先打开定位功能，并允许本应用定位" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
    [alert show];
}


#pragma mark - NetWorkDelegate

-(void)netWorkFinished:(NetWorkManager*)netWorkManager dic:(NSDictionary*)dic
{
    NSString* errorStr = [dic objectForKey:@"errorMsg"];
    Product* product;
    NSDictionary* productDic;
    [self.productList removeAllObjects];
    if(errorStr==nil || errorStr.length==0)
    {
        NSArray * products = [dic objectForKey:@"productList"];
        if(products)
        {
            for(int i=0;i<[products count];i++)
            {
                productDic = [products objectAtIndex:i];
                product = [Product productFromJsonDic:productDic];
                [self.productList addObject:product];
            }
            [self.tableView reloadData];
        }
        
        NSDictionary* productDic = (NSDictionary*)[dic objectForKey:@"product"];
        if(productDic)
        {
            self.infoViewVC.product = [Product productFromJsonDic:productDic];
            [self.infoViewVC.tableView reloadData];
        }
        
    }
}

-(void)netWorkFailed:(NetWorkManager*)netWorkManager dic:(NSDictionary*)dic
{
    NSLog(@"【Network Error：】%@",[dic objectForKey:@"errorMsg" ]);
}


-(void)requestDate:(NSString*)parameter
{
    //NSString* parameter = [NSString stringWithFormat:@"?typeId=%d&&orderBy=%d&&rows=6&&order=asc&&lon=%f&&lat=%f",self.selectedTypeRow,self.selectedSortRow,self.location.coordinate.longitude,self.location.coordinate.latitude];
    
    if(self.netWorkManager)
    {
        [self.netWorkManager setUrlString:@"showProductsInPage" parameters:parameter];
        
    }else{
        self.netWorkManager = [[NetWorkManager alloc]initWithUrlString:@"showProductsInPage" parameters:parameter];
        self.netWorkManager.delegate = self;
    }
       [self.netWorkManager startWork];
}

@end
