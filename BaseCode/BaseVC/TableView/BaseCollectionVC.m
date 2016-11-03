//
//  BaseCollectionVC.m
//  BaseCode
//
//  Created by yssj on 2016/11/3.
//  Copyright © 2016年 liubin. All rights reserved.
//

#import "BaseCollectionVC.h"
#import "WaterFLayout.h"
#import "CollectionHeaderView.h"
#import "ReusableView.h"

@interface BaseCollectionVC ()<UICollectionViewDelegate,UICollectionViewDataSource>
{
    NSInteger SelectIndex;
}
@property (strong, nonatomic) CollectionHeaderView *headerView;

@end

@implementation BaseCollectionVC

static NSString * const reuseIdentifier = @"Cell";
static NSString *headerID = @"headerID";
/*
- (instancetype)init {
    WaterFLayout *flowLayout=[[WaterFLayout alloc]init];
    flowLayout.sectionInset = UIEdgeInsetsMake(0, 5, 0, 5);
    flowLayout.minimumColumnSpacing=5;
    flowLayout.minimumInteritemSpacing=5;
    flowLayout.columnCount=3;
    
    return [self initWithCollectionViewLayout:flowLayout];
}
*/
- (void)viewDidLoad {
    [super viewDidLoad];
//    self.automaticallyAdjustsScrollViewInsets = NO;

    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    
    [self.view addSubview:self.collectionView];
    
    // Do any additional setup after loading the view.
}
- (UICollectionView *)collectionView {
    if (nil == _collectionView) {
        WaterFLayout *flowLayout=[[WaterFLayout alloc]init];
        flowLayout.sectionInset = UIEdgeInsetsMake(0, 5, 0, 5);
        flowLayout.minimumColumnSpacing=5;
        flowLayout.minimumInteritemSpacing=5;
        flowLayout.columnCount=3;
        
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)collectionViewLayout:flowLayout];
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.dataSource=self;
        _collectionView.delegate=self;
        // Register cell classes
        [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
        [_collectionView registerClass:[ReusableView class] forSupplementaryViewOfKind:WaterFallSectionHeader  withReuseIdentifier:headerID];
        [_collectionView registerClass:[CollectionHeaderView class] forSupplementaryViewOfKind:WaterFallSectionHeader withReuseIdentifier:@"HeaderView"];
    }
    return _collectionView;
}

- (NSMutableArray *)dataArray {
    if (nil == _dataArray) {
        _dataArray=[NSMutableArray array];
    }
    return _dataArray;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
#warning Incomplete implementation, return the number of sections
    return 2;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of items
    if(section == 0)
    {
        return 0;
    }
    return self.dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    cell.backgroundColor=[UIColor colorWithRed:arc4random_uniform(256)/255.0 green:arc4random_uniform(256)/255.0 blue:arc4random_uniform(256)/255.0 alpha:1.0];
    // Configure the cell
    
    return cell;
}

#pragma mark UICollectionView---section
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    if (kind != WaterFallSectionHeader)
        return nil;
    if(indexPath.section == 0)
    {
        _headerView =(CollectionHeaderView *)[collectionView dequeueReusableSupplementaryViewOfKind:WaterFallSectionHeader withReuseIdentifier:@"HeaderView" forIndexPath:indexPath];
        _headerView.backgroundColor=[UIColor groupTableViewBackgroundColor];
        return _headerView;
    }else{
        ReusableView *header = [collectionView  dequeueReusableSupplementaryViewOfKind:WaterFallSectionHeader withReuseIdentifier:headerID forIndexPath:indexPath];
        [header receiveWithNames:nil pubIndex:SelectIndex targe:self action:@selector(shopclick:)];
        return header;
    }
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout heightForHeaderInSection:(NSInteger)section{
    if(section == 0)
    {
        return  320;
    }
    return  44;
}
//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
//{
//    if(section == 0)
//    {
//        return CGSizeMake(320, 320);
//    }
//    return CGSizeMake(0, 44);
//}
#pragma mark - UICollectionViewDelegateFlowLayout
#pragma mark item 大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
#if 0
    CGFloat imgwidh;
    CGFloat imgheigh;
    ShopDetailModel *model=_dataArray[indexPath.item];
    NSString *str=model.shop_pic;
    str=[str substringToIndex:[str length]-4];
    NSArray *arr=[str componentsSeparatedByString:@"_"];
    if(arr.count){
        imgheigh=[arr[1] floatValue];
        imgwidh=[arr[2] floatValue];
    }
    CGFloat f=imgwidh/imgheigh;
#endif
    
    CGFloat imgH = 900;
    CGFloat imgW = 600;
    
    CGFloat W = (self.view.frame.size.width-18)/2.0;
    CGFloat H = imgH*W/imgW;
    
    CGSize size = CGSizeMake(W, H+5);
    return size;
}

#pragma mark <UICollectionViewDelegate>
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
}
/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/
- (void)shopclick:(UIButton *)sender {
    SelectIndex=sender.tag-3333;
    [UIView performWithoutAnimation:^{
        [self.collectionView reloadSections:[NSIndexSet indexSetWithIndex:1]];
    }];
}
@end
