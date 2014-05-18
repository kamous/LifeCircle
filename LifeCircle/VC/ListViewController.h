//
//  ListViewController.h
//  LifeCircle
//
//  Created by kamous on 14-3-23.
//  Copyright (c) 2014年 Jiawen Wang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DropDownListView.h"
#import <CoreLocation/CoreLocation.h>
#import "NetWorkManager.h"
#import "InfoViewController.h"


typedef enum{
    eSroundType = 0,
    eIndexType
}ListType;

typedef enum{
    eTypeClickType=0,
    eSortClickType
}DropDownListViewClickType;


typedef enum{
    eRecommend = 0,
    eLocation = 1,
    ePrice,
    eScore
}sortType;



@interface ListViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,DropDownListDelegate,CLLocationManagerDelegate,NetWorkDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UINavigationItem *navBar;

@property (nonatomic,strong) CLLocationManager *locationManager;
@property (nonatomic,strong) CLLocation * location;
@property (nonatomic,strong) NetWorkManager* netWorkManager;


@property (nonatomic,strong) NSMutableArray * productList;

@property (nonatomic,strong) InfoViewController* infoViewVC;

@property (nonatomic,assign) ListType  listType;

@property(nonatomic,assign)DropDownListViewClickType  clickType;

@end
