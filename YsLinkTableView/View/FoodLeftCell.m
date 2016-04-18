//
//  FoodLeftCell.m
//  YsLinkTableView
//
//  Created by weiying on 16/2/14.
//  Copyright © 2016年 Yuns. All rights reserved.
//

#import "FoodLeftCell.h"

@implementation FoodLeftCell

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"FoodLeftCell";
    FoodLeftCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[FoodLeftCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1.0];
        //设置左侧栏目选中背景
        UIView *selectBackV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, KFoodItemCellHeight)];
        selectBackV.backgroundColor = [UIColor whiteColor];
        //将选中标识（左侧竖线）添加到选中背景上
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, KFoodItemCellHeight)];
        lineView.backgroundColor = [UIColor colorWithRed:0.7 green:0.05 blue:0.03 alpha:1.0];
        [selectBackV addSubview:lineView];
        //设置cell选中View
        self.selectedBackgroundView = selectBackV;
    }
    return self;
}

//目的：修改cell的宽度
- (void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
