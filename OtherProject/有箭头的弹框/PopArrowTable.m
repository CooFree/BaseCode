//
//  PopArrowTable.m
//  BaseCode
//
//  Created by yssj on 2016/10/23.
//  Copyright © 2016年 YSSJ. All rights reserved.
//

#import "PopArrowTable.h"

static CGFloat const cellWidth=100;
static CGFloat const cellHeight=50;

@implementation PopArrowTable


/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */
- (void)showAtPointView:(UIView *)atView {
    UITableView *blueView = [[UITableView alloc] init];
    blueView.frame = CGRectMake(0, 0, cellWidth, 3*cellHeight);
    blueView.dataSource = self;
    blueView.delegate = self;
    
    [self showAtView:atView withContentView:blueView];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return cellHeight;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellId = @"cellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier:cellId];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"%zd",indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.delegate respondsToSelector:@selector(PopArrowTable:didSelectRowAtIndexPath:)]) {
        [self.delegate PopArrowTable:self didSelectRowAtIndexPath:indexPath.row];
    }
    [self dismiss];
}


@end
