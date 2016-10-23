//
//  PopArrowTable.h
//  BaseCode
//
//  Created by yssj on 2016/10/23.
//  Copyright © 2016年 YSSJ. All rights reserved.
//

#import "DXPopover.h"
@class PopArrowTable;

@protocol PopArrowTableDelegate <NSObject>

- (void)PopArrowTable:(PopArrowTable *)PopArrowTable didSelectRowAtIndexPath:(NSInteger)indexPath;

@end

@interface PopArrowTable : DXPopover
<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,weak) id<PopArrowTableDelegate> delegate;
- (void)showAtPointView:(UIView *)atView;

@end
