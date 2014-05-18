//
//  FirstViewController.h
//  LifeCircle
//
//  Created by kamous on 14-3-22.
//  Copyright (c) 2014年 Jiawen Wang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ListViewController.h"
#import "XLCycleScrollView.h"

@interface IndexViewController : UIViewController<UICollectionViewDataSource,UICollectionViewDelegate,NetWorkDelegate,XLCycleScrollViewDatasource,XLCycleScrollViewDelegate>
@property (nonatomic,strong)ListViewController* listVC;
@property (nonatomic,strong)NetWorkManager* netWorkManager;
@property (nonatomic,strong)NSArray* adProductList;
@property (nonatomic,strong)XLCycleScrollView *csView;
@property (nonatomic,strong)InfoViewController* infoVC;
@end
