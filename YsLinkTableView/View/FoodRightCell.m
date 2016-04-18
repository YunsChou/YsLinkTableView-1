//
//  FoodRightCell.m
//  YsLinkTableView
//
//  Created by weiying on 16/2/14.
//  Copyright © 2016年 Yuns. All rights reserved.
//

#import "FoodRightCell.h"
#import "FoodModel.h"
#import "UIImageView+WebCache.h"

@interface FoodRightCell ()
@property (nonatomic, strong) UIImageView *foodImgV;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *priceLabel;
@end

@implementation FoodRightCell

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"FoodRightCell";
    FoodRightCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[FoodRightCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.foodImgV = [[UIImageView alloc] init];//图片
        self.titleLabel = [[UILabel alloc] init];//名称
        self.priceLabel = [[UILabel alloc] init];//价格
        
        [self.contentView addSubview:self.foodImgV];
        [self.contentView addSubview:self.titleLabel];
        [self.contentView addSubview:self.priceLabel];
    }
    return self;
}

//获取模型数据
- (void)setFoodItemM:(FoodItemModel *)foodItemM
{
    _foodItemM = foodItemM;
    self.titleLabel.text = foodItemM.foodName;
    self.priceLabel.text = [NSString stringWithFormat:@"%0.0f元/份",foodItemM.foodPrice];
    [self.foodImgV sd_setImageWithURL:[NSURL URLWithString:foodItemM.foodImage] placeholderImage:[UIImage imageNamed:@"placeholder"]];
}

//目的：修改cell的宽度
- (void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
}

//UI控件布局
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat margin = 10;
    CGFloat imgWH = 80;
    CGFloat labelW = 100;
    CGFloat labelH = 20;
    self.foodImgV.frame = CGRectMake(margin, margin, imgWH, imgWH);
    self.titleLabel.frame = CGRectMake(CGRectGetMaxX(self.foodImgV.frame) + margin, margin, labelW, labelH);
    self.priceLabel.frame = CGRectMake(CGRectGetMaxX(self.foodImgV.frame) + margin, KFoodSubCellHeight - margin - labelH, labelW, labelH);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
