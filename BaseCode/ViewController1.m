//
//  ViewController1.m
//  BaseCode
//
//  Created by yssj on 16/9/20.
//  Copyright © 2016年 YSSJ. All rights reserved.
//

#import "ViewController1.h"
#import "ViewController2.h"

@interface ViewController1 ()<UISearchDisplayDelegate,UISearchBarDelegate>

@end

@implementation ViewController1


#pragma mark - UITableViewDataSource and UItableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 8;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 8;
}



- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return section == 0 ? CGFLOAT_MIN:20.;
}


- (void)viewDidLoad {
    [super viewDidLoad];

    [self.view addSubview:self.seachBarView];
    self.searchController.active = NO;
    self.tableView.frame=CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    self.tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, 49)];

    self.tableView.showsVerticalScrollIndicator=NO;
    [self tableViewCellBlock:^(UITableView *tableView,UITableViewCell *cell, NSIndexPath *indexPath, NSString *model) {
        DS_LanguageCell *cells = (DS_LanguageCell *)cell;
        cells.selectedState = YES;
        cell.textLabel.text = [NSString stringWithFormat:@"%ld",(long)indexPath.row];
    }];
    [self tableViewDidClickBlock:^(UITableView *tableView, UITableViewCell *cell, NSIndexPath *indexPath, id model) {
        ViewController2 *view = [[ViewController2 alloc]init];
        [self.navigationController pushViewController:view animated:YES];
    }];

    
}
#pragma mark - overwirte
- (void)registerSearchTableViewCellClass
{
    [self.searchController.searchResultsTableView registerClass:[DS_LanguageCell class] forCellReuseIdentifier:@"UITableViewCellDS"];
    
}

#pragma mark - UISearchBarDelegate
-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
//    self.searchDataArray = [[DS_WeChatControllerManager searchDataSource] mutableCopy];
//    DS_WeChatListModel *model = [self.searchDataArray firstObject];
//    model.chatRoomName = _searchString;
    [self.searchController.searchResultsTableView reloadData];
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

@end
