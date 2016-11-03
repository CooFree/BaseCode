//
//  BaseCollectionVC.h
//  BaseCode
//
//  Created by yssj on 2016/11/3.
//  Copyright © 2016年 liubin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

@interface BaseCollectionVC : BaseViewController
@property (nonatomic,strong) NSMutableArray *dataArray;
@property (nonatomic,strong) UICollectionView *collectionView;
@end
