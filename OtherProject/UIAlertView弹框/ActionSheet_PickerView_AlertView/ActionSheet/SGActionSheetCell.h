//
//  SGActionSheetCell.h
//  SGActionSheetExample
//
//  Created by Jack on 16/9/17.
//  Copyright © 2016年 Jack. All rights reserved.
//
//  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - //
//
//

#import <UIKit/UIKit.h>

@interface SGActionSheetCell : UITableViewCell

/** cell上的标题内容 */
@property (nonatomic, strong) UILabel *titleLabel;

/** cell之间的分割线 */
@property (nonatomic, strong) UIImageView *splitters;

@end
