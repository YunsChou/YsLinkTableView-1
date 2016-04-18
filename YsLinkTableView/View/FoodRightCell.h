//
//  FoodRightCell.h
//  YsLinkTableView
//
//  Created by weiying on 16/2/14.
//  Copyright © 2016年 Yuns. All rights reserved.
//

#import <UIKit/UIKit.h>

//右侧cell的高度为100
#define KFoodSubCellHeight 100

@class FoodItemModel;

@interface FoodRightCell : UITableViewCell

@property (nonatomic, strong) FoodItemModel *foodItemM;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
